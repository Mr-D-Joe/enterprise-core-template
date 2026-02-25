# How To: `bootstrap_project.sh`

## Zweck
`bootstrap_project.sh` erzeugt ein neues Projekt auf Basis des V2-Frameworks.

## Datei
- Script: `bootstrap_project.sh`
- How-To: `bootstrap_project.sh.HOWTO.md`

## Verwendung

### 1. In den Template-Ordner wechseln
```bash
cd /Users/joern/Development/stock-news-pro/system_reports/templates/llm_spec_framework_v2
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
./bootstrap_project.sh /Users/joern/Development
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
  - `./scripts/bootstrap_project.sh /mein/zielpfad`
- Wenn kein Parameter gesetzt ist:
  - Das Projekt wird im aktuellen Verzeichnis angelegt (`$PWD`).

## Ergebnis
Das Script erstellt:
- die komplette Framework-Struktur,
- alle nötigen Unterordner (`docs/specs`, `docs/governance`, `system_reports/...`, `reports`),
- initiale Datei für das PO-Role-Packet:
  - `system_reports/gates/po_role_packet_template.env`

Zusätzlich werden Platzhalter (Projektname, Datum) direkt ersetzt, damit du sofort mit dem ersten Prompt starten kannst.
