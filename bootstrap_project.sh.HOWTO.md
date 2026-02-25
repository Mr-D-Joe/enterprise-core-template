# How To: `bootstrap_project.sh`

## Zweck
`bootstrap_project.sh` erzeugt ein neues Projekt auf Basis des V2-Frameworks.

## Datei
- Script: `bootstrap_project.sh`
- How-To: `bootstrap_project.sh.HOWTO.md`

## Verwendung

### 1. In den Template-Ordner wechseln
```bash
cd /PATH/TO/TEMPLATE/ROOT
```

### 2. Script starten

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
- Übergib den Zielordner als ersten Parameter:
  - `./bootstrap_project.sh /mein/zielpfad`
- Wenn kein Parameter gesetzt ist:
  - Das Projekt wird im aktuellen Verzeichnis angelegt (`$PWD`).

## Ergebnis
Das Script erstellt:
- die komplette Framework-Struktur,
- alle nötigen Unterordner (`docs/specs`, `docs/governance`, `system_reports/...`, `reports`),
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
  - `system_reports/gates/po_role_packet_template.env`

Zusätzlich werden Platzhalter (Projektname, Datum) direkt ersetzt, damit du sofort mit dem ersten Prompt starten kannst.

## Nächste Schritte nach Bootstrap
1. `system_reports/gates/runtime_bootstrap.env` kurz prüfen (Status/Evidenz).
2. `system_reports/gates/tooling_decision_template.env` mit Tool-Entscheidung + Quellen füllen (Agent-Aufgabe).
   - zuerst `application_profile` setzen,
   - dann konkrete Stack-Auswahl + offizielle Quellen eintragen.
3. `system_reports/gates/po_role_packet_template.env` mit `REQ_IDS` und Scope ausfüllen.
4. DEV-Run starten (ohne manuelle Runtime-Setup-Kommandos für den Kunden).
