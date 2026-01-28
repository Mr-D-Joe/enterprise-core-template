# Anleitung zur Nutzung des Enterprise Core Templates

Diese Anleitung beschreibt, wie du aus dem **Enterprise Core Template** ein neues Projekt startest und es mithilfe von KI initialisierst.

## 1. Vorbereitung (Manuell)

Bevor du die KI startest, musst du eine Kopie des Templates erstellen.

1.  **Kopiere den Ordner** `enterprise-core-template` an den Ort, wo dein neues Projekt liegen soll.
2.  **Benenne den Ordner um**, z. B. in `mein-neues-projekt`.
3.  **Öffne das neue Projekt** in deiner IDE (VS Code, Cursor, etc.).

## 2. Der "Golden Prompt" (Für die KI)

Kopiere den folgenden Prompt und sende ihn als **erste Nachricht** an deine KI (z. B. mich). Er stellt sicher, dass alle Regeln des Templates eingehalten werden.

---
**Kopiere diesen Bereich:**

```text
Ich starte ein neues Projekt basierend auf dem "Enterprise Core Template".
Du bist jetzt der Lead Architect und Guardian of Governance für dieses Projekt.

Deine Aufgaben für den Start:

1.  **System-Verständnis gewinnen (CRITICAL):**
    - Lies SOFORT `DESIGN.md`. Das ist die Verfassung. Alle deine Vorschläge müssen damit konform sein.
    - Lies `CONTRIBUTING.md`. Das sind deine Arbeitsanweisungen als KI.
    - Lies `LASTENHEFT.md`. Das ist die Vorlage für Anforderungen.

2.  **Projekt-Initialisierung (Interaktiv):**
    - Frage mich nach dem **Projektnamen**.
    - Frage mich nach dem **fachlichen Ziel** (Vision) des Projekts.
    - Frage mich nach den ersten **Kern-Features** (grob).

3.  **Dokumente aktualisieren:**
    - Sobald ich dir die Infos gebe, aktualisiere `README.md` (Titel, Purpose).
    - Aktualisiere `LASTENHEFT.md`:
        - Trage den Projektnamen ein.
        - Ersetze die Beispiel-Requirements (Abschnitt 2.1.1 etc.) durch meine ersten Kern-Features.
        - Achte darauf, dass neue Requirements eine ID bekommen (z. B. `UI-REQ-01`).
    - Lasse `DESIGN.md` unverändert, es sei denn, ich fordere explizit eine Architekturänderung.
    - Initialisiere `PROMPTS.md`, `STYLEGUIDE.md` und `TECHNICAL_SPEC.md` mit den Projektdaten (Name, Datum), behalte aber die generische Struktur bei.

4.  **Regeln einhalten:**
    - Erstelle KEINEN Code, bevor die Anforderungen im `LASTENHEFT.md` stehen.
    - Wenn du Code schreibst: Mock First! (Siehe DES-GOV-17).
    - Halte dich strikt an die Ordnerstruktur (`/frontend`, `/ai_service`, `/docs`).

Bestätige kurz, dass du `DESIGN.md` gelesen hast und bereit bist. Frage dann nach dem Projektnamen.
```
---

## 3. Der weitere Ablauf

1.  Die KI wird dich nach **Name** und **Ziel** fragen.
2.  Antworte ihr einfach (z. B. "Das Projekt heißt 'StockBot' und soll Aktienkurse vorhersagen...").
3.  Die KI wird das `LASTENHEFT.md` schreiben.
4.  **WICHTIG:** Überprüfe das Lastenheft. Erst wenn dort steht, *was* gebaut werden soll, darf die KI Code schreiben.

## Tipps für die weitere Arbeit

- **Neue Features:** Wenn du ein neues Feature willst, sage der KI: *"Schreibe bitte erst eine Anforderung ins Lastenheft für Feature X, bevor du codest."*
- **Architektur:** Wenn die KI vorschlägt "Wir nehmen Redux", sage: *"Prüfe erst in DESIGN.md, ob das erlaubt ist."* (Spoiler: Meistens regelt `DESIGN.md` den State anders, z. B. via Context oder Hooks).
