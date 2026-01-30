# Anleitung zur Nutzung des Enterprise Core Templates

Diese Anleitung beschreibt, wie du aus dem **Enterprise Core Template** (Golden Standard) ein neues Projekt startest und es mithilfe von KI initialisierst.

Version: 1.9.3  
Datum: 2026-01-30  
Status: Released (Golden Standard)

INIT_STATUS: TEMPLATE

> **Rule:** Set `INIT_STATUS: COMPLETE` only after **all** checklist items in Section 4 are checked and **all placeholders** in the repository are replaced. Partial completion is not allowed.
> **Strict Mode Parameter (Mandatory):** `strict_mode: true`

## 0. Einmalige Einrichtung (Nur für Administratoren)

Damit dieses Repository als Vorlage genutzt werden kann, muss es **einmalig** konfiguriert werden. Wenn du den grünen Button **"Use this template"** oben rechts auf der Hauptseite nicht siehst, führe diese Schritte aus:

1.  Öffne die Hauptseite dieses Repositories auf GitHub.
2.  Klicke oben in der Leiste auf den Reiter **Settings** (:gear:).
3.  Du landest im Menüpunkt **General** (in der linken Seitenleiste ganz oben).
4.  Scrolle im Hauptbereich etwas herunter bis zum Abschnitt, der direkt unter dem Repository-Namen steht.
5.  Suche die Checkbox mit dem Text **"Template repository"**.
6.  ✅ **Setze den Haken** bei dieser Checkbox.
7.  Die Einstellung wird meist sofort automatisch gespeichert (oder klicke unten auf "Save", falls vorhanden).

Sobald dies erledigt ist, erscheint für alle Nutzer der grüne Button **"Use this template"**.

---

## 1. Start eines neuen Projekts (Für Entwickler)

Da dieses Repository als "Template Repository" konfiguriert ist, kopierst du es nicht manuell, sondern instanziierst es sauber über GitHub.

1.  Gehe zur Repository-Hauptseite auf GitHub.
    *   *Hinweis:* Klicke in deiner Repository-Übersicht auf den **Namen** des Repositories (z. B. `enterprise-core-template`), um hineinzugelangen. Der Button ist **nicht** in der Listenansicht sichtbar.
2.  Klicke auf den Button **"Use this template"** → **"Create a new repository"**.
3.  Gib deinem neuen Projekt einen Namen (z. B. `mein-neues-projekt`) und erstelle es.
4.  **Clone** das neue Repository auf deinen lokalen Rechner:
    ```bash
    git clone https://github.com/DEIN-USER/mein-neues-projekt.git
    cd mein-neues-projekt
    ```
5.  Öffne das Projekt in deiner IDE (VS Code, Cursor, Windsurf, etc.).

---

## 2. Der "Golden Prompt" (Für die KI)

Kopiere den folgenden Prompt und sende ihn als **erste Nachricht** an deine KI (z. B. mich). Er stellt sicher, dass Governance, Scaffolding und Architekturregeln perfekt eingehalten werden.

---
**Kopiere diesen Bereich:**

```markdown
Ich starte ein neues Projekt basierend auf dem "Enterprise Core Template".
Du bist jetzt der Lead Architect und Guardian of Governance für dieses Projekt.

Deine Aufgaben für den Start:

1.  **System-Verständnis gewinnen (CRITICAL):**
    - Lies SOFORT `DESIGN.md`. Das ist die Verfassung. Alle deine Vorschläge müssen damit konform sein.
    - Lies `CONTRIBUTING.md`. Das sind deine verbindlichen Arbeitsanweisungen.
    - Lies `LASTENHEFT.md`. Das ist die Vorlage für Anforderungen.

2.  **Projekt-Initialisierung (Interaktiv):**
    - Frage mich nach dem **Projektnamen**.
    - Frage mich nach dem **fachlichen Ziel** (Vision) des Projekts.
    - Frage mich nach den ersten **Kern-Features** (grob).

3.  **Technische Basis legen (Scaffolding):**
    - Führe das Skript `./scaffold_structure.sh --platform desktop|web|api-only` aus, um nur die für die Plattform nötigen Ordner anzulegen.
    - Bestätige mir, dass die Ordnerstruktur korrekt ist.

4.  **Dokumente aktualisieren:**
    - Sobald ich dir die Infos gebe, aktualisiere `README.md` (Titel, Purpose).
    - Aktualisiere `LASTENHEFT.md`:
        - Trage den Projektnamen ein.
        - Ersetze die Beispiel-Requirements durch meine ersten Kern-Features.
        - Weise neuen Requirements eine ID zu (z. B. `UI-REQ-01`).
        - Lege die Zielplattform explizit fest (z. B. `Desktop`, `Web`, `API-only`).
    - Initialisiere `PROMPTS.md`, `STYLEGUIDE.md` und `TECHNICAL_SPEC.md` mit den Projektdaten.
    - Lasse `DESIGN.md` unverändert.

5.  **Regeln einhalten:**
    - Erstelle KEINEN Code, bevor die Anforderungen im `LASTENHEFT.md` stehen.
    - Wenn du Code schreibst: **Mock First!** (Halte dich strikt an `DES-GOV-17` und `DES-GOV-19`).
    - Nutze `scaffold_structure.sh` als Referenz für die Ordnerstruktur.

Bestätige kurz, dass du `DESIGN.md` verstanden hast. Starte dann das Skript `./scaffold_structure.sh` und frage danach nach dem Projektnamen.
```
---

## 3. Der weitere Ablauf

1.  Die KI wird das Scaffolding-Skript ausführen und prüfen, ob die Ordner da sind.
2.  Sie wird dich nach **Name** und **Ziel** fragen.
3.  Antworte ihr einfach (z. B. "Das Projekt heißt 'StockBot' und soll Aktienkurse vorhersagen...").
4.  Die KI wird das `LASTENHEFT.md` schreiben.
5.  **WICHTIG:** Überprüfe das Lastenheft. Erst wenn dort steht, *was* gebaut werden soll, darf die KI Code schreiben.

---

## 4. Template Initialization Checklist (Mandatory)

- [ ] **Project Name** defined in `README.md` and `LASTENHEFT.md`
- [ ] **Target Platform** explicitly set in `LASTENHEFT.md` (Desktop/Web/API-only)
- [ ] **Platform Decision Checklist** completed (LASTENHEFT.md section 1.5)
- [ ] **Scaffolded Directories** verified (`/frontend`, `/ai_service`, optional `/desktop`, `/shared`)
- [ ] **Placeholders Replaced** (`{{PROJECT_NAME}}`, `{{DATE}}`, and all document placeholders)
- [ ] **Changelog Updated** (`CHANGELOG.md` has a new version entry)
- [ ] **Initialization Status Set** (`INIT_STATUS: COMPLETE` in this file)
- [ ] **DOC-ID Update Order Enforced** (required order):
1. Add new DOC-IDs in `docs/artifact_index.md`
2. Update the source artifact file
3. Keep order locked
4. Update `TECHNICAL_SPEC.md` Section 6
5. Update `CHANGELOG.md`

## 4.1 Template Consistency Check (Prepare)

- [ ] **Versions aligned** across DESIGN/LASTENHEFT/TECHNICAL_SPEC/STYLEGUIDE/PROMPTS/SYSTEM_REPORT/RELEASE_CHECKLIST.
- [ ] **Release checklist updated** after governance rule changes.
- [ ] **Scaffold platform selected** and only required directories created.
- [ ] **Run consistency script:** `./scripts/consistency_check.sh`

## Tipps für die weitere Arbeit

*   **Neue Features:** Wenn du ein neues Feature willst, sage der KI:
    ```markdown
    Schreibe bitte erst eine Anforderung ins Lastenheft für Feature X, bevor du codest.
    ```
*   **Architektur:** Wenn die KI vorschlägt "Wir nehmen Redux", sage:
    ```markdown
    Prüfe erst in DESIGN.md, ob das erlaubt ist.
    ```
    (Regel: `DESIGN.md` gewinnt immer).
*   **Governance Check:** Bei jedem Pull Request prüft der Workflow `governance-check.yml`, ob du die Doku vernachlässigt hast.
