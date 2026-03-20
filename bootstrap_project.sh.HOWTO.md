# bootstrap_project.sh.HOWTO.md

## Zweck
`bootstrap_project.sh` erstellt ein neues Projekt aus der finalisierten kanonischen Enterprise-Core-Template-Baseline.
Nicht-kanonische Working-State-Artefakte aus dem Template-Repository werden nicht in neue Projekte übernommen.

## Dateien
- Script: `bootstrap_project.sh`
- Finder-Starter: `bootstrap_project_picker.command`
- How-To: `bootstrap_project.sh.HOWTO.md`

## Verwendung

### 1. In den Template-Ordner wechseln
```bash
cd /PATH/TO/TEMPLATE/ROOT
```

### 2. Script starten

Mit Finder-Ordnerauswahl auf macOS:
```bash
./bootstrap_project_picker.command
```

Oder direkt im Terminal:
```bash
./bootstrap_project.sh
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

Beispiel:
```text
Anti Gravity
```

Das Script erzeugt daraus automatisch einen Slug als Zielordner, zum Beispiel:
- Eingabe: `Anti Gravity`
- Zielordner: `anti-gravity`

## Was der Bootstrap jetzt wirklich macht
Das Script kopiert nur die kanonische Template-Baseline in das neue Projekt.
Nicht-kanonische Artefakte wie `.git`, `.DS_Store`, `codex_outputs`, alte `system_reports`-Inhalte, alte `reports`-Inhalte und transiente Review-Artefakte werden nicht übernommen.

Danach erzeugt das Script einen neutralen Projektstartzustand mit:
- frischen Verzeichnissen:
  - `system_reports/gates`
  - `system_reports/releases`
  - `system_reports/tasks`
  - `reports`
- finalisierten kanonischen Starterdokumenten aus dem Template:
  - `docs/BACKLOG.md`
  - `changes/CHG-TEMPLATE.md`
  - `LASTENHEFT.md`
  - `CHANGELOG.md`
- Runtime-/Tooling-Starterartefakten:
  - `system_reports/gates/po_role_packet_template.env`
  - `system_reports/gates/tooling_decision_template.env`
  - `system_reports/gates/runtime_bootstrap.env`
- lokaler Entwicklungsbasis:
  - `.env.template`
  - `.env`
  - `.gitignore`
  - `.vscode/settings.json`
  - `pyrightconfig.json`

Wenn Python verfügbar ist, erzeugt das Script zusätzlich automatisch `.venv` und versucht `pyright` zu installieren.

## Wichtige Starterartefakte
- `docs/BACKLOG.md`
  - kompakte Package-Steuerung im finalisierten Format
- `changes/CHG-TEMPLATE.md`
  - bounded operative package context template
- `LASTENHEFT.md`
  - orientation-only Produkt-/Scope-/Capability-Dokument
- `CHANGELOG.md`
  - release-history only
- `system_reports/gates/po_role_packet_template.env`
  - Startpunkt für das PO-Role-Packet mit den Pflichtfeldern inklusive `chg_id` und `package_id`
- `system_reports/gates/tooling_decision_template.env`
  - Startpunkt für die Tooling-Entscheidung
- `system_reports/gates/runtime_bootstrap.env`
  - Evidenz des ausgeführten Runtime-Bootstraps

## Erste Schritte nach dem Bootstrap
1. `system_reports/gates/runtime_bootstrap.env` kurz prüfen.
2. `system_reports/gates/tooling_decision_template.env` ausfüllen.
   - zuerst `application_profile` setzen
   - danach konkrete Tool-/Runtime-Entscheidungen und Quellen eintragen
3. Den ersten bounded package context aus `changes/CHG-TEMPLATE.md` ableiten.
4. `system_reports/gates/po_role_packet_template.env` für das erste Paket ausfüllen, einschließlich:
   - `req_ids`
   - `chg_id`
   - `package_id`
   - `scope_allowlist`
5. Bei technisch betroffenen Modulen module-local documentation/specification near the code anlegen oder aktualisieren.
6. DEV-Run starten.
7. Gate-Kette ausführen:
   - `./scripts/gates/dev_gate.sh`
   - `./scripts/gates/audit_gate.sh`

## Einordnung
Dieses How-To beschreibt nur den Bootstrap-Ablauf und die erzeugten Starterartefakte.
Es ersetzt keine Governance-, Runtime-, Architektur- oder Enforcementspezifikation.
