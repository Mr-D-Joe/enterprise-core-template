# Anleitung zur Nutzung des Enterprise Core Templates

Diese Anleitung beschreibt, wie du aus dem **Enterprise Core Template** (Golden Standard) ein neues Projekt startest und es mithilfe von KI initialisierst.

## 1. Vorbereitung (GitHub Template)

Da dieses Repository als "Template Repository" konfiguriert ist, kopierst du es nicht manuell, sondern instanziierst es sauber über GitHub.

1.  Gehe zur Repository-Hauptseite auf GitHub.
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

```text
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
    - Führe das Skript `./scaffold_structure.sh` aus, um die Ordner `/frontend` und `/ai_service` sauber anzulegen (oder zu verifizieren).
    - Bestätige mir, dass die Ordnerstruktur korrekt ist.

4.  **Dokumente aktualisieren:**
    - Sobald ich dir die Infos gebe, aktualisiere `README.md` (Titel, Purpose).
    - Aktualisiere `LASTENHEFT.md`:
        - Trage den Projektnamen ein.
        - Ersetze die Beispiel-Requirements durch meine ersten Kern-Features.
        - Weise neuen Requirements eine ID zu (z. B. `UI-REQ-01`).
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

## Tipps für die weitere Arbeit

*   **Neue Features:** Wenn du ein neues Feature willst, sage der KI: *"Schreibe bitte erst eine Anforderung ins Lastenheft für Feature X, bevor du codest."*
*   **Architektur:** Wenn die KI vorschlägt "Wir nehmen Redux", sage: *"Prüfe erst in DESIGN.md, ob das erlaubt ist."* (Regel: `DESIGN.md` gewinnt immer).
*   ** Governance Check:** Bei jedem Pull Request prüft der Workflow `governance-check.yml`, ob du die Doku vernachlässigt hast.
