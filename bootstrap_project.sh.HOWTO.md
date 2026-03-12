# How To: `bootstrap_project.sh`

## Zweck
`bootstrap_project.sh` erzeugt ein neues Projekt auf Basis des V2-Frameworks.

## Datei
- Script: `bootstrap_project.sh`
- Finder-Starter: `bootstrap_project_picker.command`
- How-To: `bootstrap_project.sh.HOWTO.md`

## Verwendung

### 1. In den Template-Ordner wechseln
```bash
cd /PATH/TO/TEMPLATE/ROOT
```

### 2. Script starten

Mit Finder-Ordnerauswahl (empfohlen auf macOS):
```bash
./bootstrap_project_picker.command
```

Oder per Doppelklick auf `bootstrap_project_picker.command`.
Das Script fragt zuerst nach dem Projektnamen und öffnet dann einen Finder-Dialog zur Auswahl des Zielordners.

Ohne Zielordner (erstellt Projekt im aktuellen Verzeichnis):
```bash
./bootstrap_project.sh
```

Mit Zielordner (empfohlen):
```bash
./bootstrap_project.sh /pfad/zum/zielordner
```

Beispiel:
```bash
./bootstrap_project.sh /PATH/TO/WORKSPACE
```

## Projektnamen eingeben
Nach dem Start fragt das Script:
```text
Projektname:
```

Hier den gewünschten Namen eingeben, z. B.:
```text
Anti Gravity
```

Das Script erzeugt daraus automatisch einen Ordnernamen (Slug), z. B.:
- Eingabe: `Anti Gravity`
- Zielordner: `anti-gravity`

## Zielordner auswählen
- Mit Finder-Dialog:
  - `./bootstrap_project_picker.command`
  - Zielordner wird grafisch ausgewählt.
- Übergib den Zielordner als ersten Parameter:
  - `./bootstrap_project.sh /mein/zielpfad`
- Wenn kein Parameter gesetzt ist:
  - Das Projekt wird im aktuellen Verzeichnis angelegt (`$PWD`).

## Ergebnis
Das Script erstellt:
- die komplette Framework-Struktur,
- alle nötigen Unterordner (`changes`, `docs/modules`, `docs/templates`, `docs/governance`, `system_reports/...`, `reports`),
- eine allgemeine Runtime-/Toolchain-Umgebungsdatei:
  - `.env.template` (Python/Node/.NET/C/C++-Variablen als Startpunkt),
- eine aktive `.env` automatisch aus der Vorlage,
- wenn Python verfügbar: automatische `.venv`-Erzeugung,
- Runtime-Bootstrap-Evidenz:
  - `system_reports/gates/runtime_bootstrap.env`,
- initiales Tooling-Decision-Paket:
  - `system_reports/gates/tooling_decision_template.env`,
- eine Basis-`.gitignore` für lokale Artefakte (`.venv`, `node_modules`, `.env.local`, ...),
- initiale Datei für das PO-Role-Packet:
  - `system_reports/gates/po_role_packet_template.env`,
- Planungs-/Onboarding-Dokumente:
  - `docs/BACKLOG.md`
  - `docs/STARTUP_CHECKLIST.md`
  - `changes/CHG-TEMPLATE.md`
  - `docs/modules/index.md`
  - `docs/templates/module-docs/...`
  - `docs/governance/FOUR_EYES_GATING.md`
- Gate-Skripte:
  - `scripts/gates/dev_gate.sh`
  - `scripts/gates/audit_gate.sh`
- Versionshistorie:
  - `CHANGELOG.md`

Zusätzlich werden Platzhalter (Projektname, Datum) direkt ersetzt, damit du sofort mit dem ersten Prompt starten kannst.

## Nächste Schritte nach Bootstrap
1. `system_reports/gates/runtime_bootstrap.env` kurz prüfen (Status/Evidenz).
2. `system_reports/gates/tooling_decision_template.env` mit Tool-Entscheidung + Quellen füllen (Agent-Aufgabe).
   - zuerst `application_profile` setzen,
   - dann konkrete Stack-Auswahl + Runtime-/Compiler-Versionen eintragen,
   - nur neueste stabile Versionen verwenden und mit offiziellen Quellen belegen.
3. Ersten Change-Brief aus `changes/CHG-TEMPLATE.md` ableiten.
4. `system_reports/gates/po_role_packet_template.env` mit `REQ_IDS` und Scope ausfüllen.
5. DEV-Run starten (ohne manuelle Runtime-Setup-Kommandos für den Kunden).
6. DEV-Gate ausführen: `./scripts/gates/dev_gate.sh`.
7. AUDIT-Gate ausführen: `./scripts/gates/audit_gate.sh`.
8. `docs/BACKLOG.md` und `LASTENHEFT.md` Metadaten aktuell halten (`generated_at_utc`, `source_commit_sha`).
9. Traceability-Matrix pflegen: pro aktivem `REQ_ID` mindestens ein Positiv- und ein Negativ-Test mit Evidenz und `PASS`.
10. Bei Python-Scope getrennte Tests laufen lassen:
   - `pytest -m "not integration"`
   - `pytest -m integration`
