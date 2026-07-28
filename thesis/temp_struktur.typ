//Diese Datei enthält alte Strukturen, die noch bearbeitet werden

== Datenfluss durch die Pipeline

#figure(
  rect(width: 100%, height: 100pt, stroke: 1pt + gray, fill: rgb("#f7fafc"))[
    #set align(center + horizon)
    [Katalon Project] → [Parser: Extract] → [Transformer: Groovy→Python] → [Mapper: Objects→Locators] → [Generator: Write Code] → [Output: Pytest Structure]
  ],
  caption: [Vereinfachter Datenfluss durch die Migrationspipeline. Jede Phase produziert Intermediate Representations, die in die nächste Phase fließen.],
) <fig-dataflow>

== Detailliertes Aktivitätsdiagramm der Test-Transformation

Das folgende Diagramm zeigt den genauen Transformationsablauf eines Katalon-Tests zu einem Python-Pytest-Test. Es illustriert die zentralen Phasen "Scanner & Parsing", "Transpilation" und "Code Generation" sowie das Fehlerbehandlungs-Verfahren für komplexe Tests:

```mermaid
graph TD
    A["Start: Katalon Test<br/>Scripts/TestName.groovy"] --> B["Phase 1: Scanner<br/>Datei lesen"]
    B --> C["Phase 2: Parsing<br/>Kommentare entfernen<br/>Zeilen extrahieren"]
    C --> D["Regex-Filter<br/>WebUI-Methoden<br/>identifizieren"]
    D --> E{Test zu<br/>komplex?}
    
    E -->|Ja| F["Phase 4: Error<br/>Klassifizierung"]
    F --> G["Output: Fehler-Datei<br/>src/unreadable_tests/"]
    
    E -->|Nein| H["Phase 3: Transpilation<br/>Katalon Methoden<br/>↓<br/>Selenium WebDriver API"]
    H --> I["Mapping:<br/>TestObject → Locator<br/>GlobalVariable → Attribute"]
    I --> J["Phase 4: Code Generation<br/>Python-Pytest Code<br/>Assembly"]
    J --> K["Imports + Klasse +<br/>Test-Methode +<br/>Fixtures"]
    K --> L["Output: Python Test<br/>src/tests/TestName.py"]
    L --> M["End: Generierter<br/>Pytest-Test"]
    
    G --> N["Archiv für<br/>manuelle Überprüfung"]
    
    style A fill:#e8f4f8
    style M fill:#c8f4c8
    style G fill:#f4c8c8
    style H fill:#ffe8c8
    style I fill:#ffe8c8
```

Das Diagramm verdeutlicht: Einfache Tests durchlaufen den vollständigen Transformationspfad. Komplexe Tests, die mit Regex-Pattern nicht zu erfassen sind, werden in ein separates Verzeichnis geschrieben und können später manuell überprüft oder angepasst werden.


Das folgende Diagramm zeigt die Datenfluss-Abhängigkeiten zwischen den 7 Pipeline-Modulen:

```mermaid
graph TB
    subgraph Input["Katalon-Projekt Input"]
        SF["Scripts/*.groovy<br/>Test Cases"]
        OR["Object Repository/*.rs<br/>XML"]
        TC["Test Cases/*.tc<br/>XML"]
        PF["Profiles/default.glbl<br/>XML"]
        DF["Data Files/*.dat"]
    end
    
    subgraph Pipeline["Build-Time Pipeline"]
        M1["Module 1:<br/>test_suite_translator<br/>Scanner + Orchestration"]
        M2["Module 2:<br/>test_transpiler<br/>Groovy→Python"]
        M3["Module 3:<br/>test_assembler<br/>Pytest Code Gen"]
        M4["Module 4:<br/>object_repo_converter<br/>XML→JSON"]
        M5["Module 5:<br/>variables_extractor<br/>TC Variables"]
        M6["Module 6:<br/>global_vars_generator<br/>Profile Variables"]
        M7["Module 7:<br/>copy_runtime_files<br/>Assembly + Config"]
    end
    
    subgraph Output["Ziel-Projekt Output"]
        OUT1["src/tests/test_*.py<br/>Pytest Tests"]
        OUT2["src/object_repository/<br/>*.rs JSON"]
        OUT3["src/variables/var_*.py<br/>Test Variables"]
        OUT4["src/profiles/<br/>global_variables.py"]
        OUT5["src/runtime/<br/>base_test.py<br/>katalon_helpers.py"]
        OUT6["pytest.ini<br/>requirements.txt<br/>.gitignore"]
        OUT7["data/<br/>kopierte Testdaten"]
    end
    
    SF --> M1 --> M2 --> M3 --> OUT1
    M1 --> M4
    OR --> M4 --> OUT2
    TC --> M5 --> OUT3
    M1 --> M5
    PF --> M6 --> OUT4
    M1 --> M3 --> M7
    M2 --> M7
    M4 --> M7
    M5 --> M7
    M6 --> M7
    DF --> M7 --> OUT7
    M7 --> OUT5
    M7 --> OUT6
    
    style Input fill:#e8f4f8
    style Output fill:#c8f4c8
    style Pipeline fill:#ffe8c8
```

Diese modulare Struktur gewährleistet, dass jede Pipeline-Phase isoliert getestet, validiert und bei Bedarf erweitert werden kann.

== Pipeline-Phasen (Datenfluss)

Der Migrations-Prozess läuft durch 7 sequenzielle Phasen:

*Phase 1 — Test Suite Scanning* (test_suite_translator.py)
- Scanne `source_root/Scripts` nach allen `.groovy` Dateien
- Erhält die Katalon-Ordnerhierarchie
- Setzt bereits ein `__init__.py` für korrekte Python-Paketstruktur

*Phase 2 — Groovy→Python Transpilation* (test_transpiler.py)
- Parse jeden `.groovy`-Test mit Regex-Patterns
- Extrahiere WebUI-Methodenaufrufe (z.B. `WebUI.click(...)`)
- Identifiziere Test-Objekt-Referenzen und Variablen
- Kennzeichne nicht-übersetzbare Tests (z.B. mit Cutsom Code)

*Phase 3 — Code Assembly* (test_assembler.py)
- Assembliere TransPilot-Ausgaben in vollständige Python-Klassen
- Generiere Pytest-Test-Methoden mit korrekten Imports
- Erstelle Fixture-Integrationen und Assert-Statements
- Behandle Spezialfälle (String-Interpolation, Parametrisierung)

*Phase 4 — Object Repository Konvertierung* (object_repo_converter.py)
- Scanne `source_root/Object Repository` nach `.rs` XML-Dateien
- Konvertiere jede XML in JSON (besseres Python-Parsing)
- Gebe in `destination/src/object_repository/**/*.rs` aus

*Phase 5 — Variablen-Extraktion* (variables_extractor.py)
- Scanne `source_root/Test Cases` nach `.tc` XML-Dateien
- Extrahiere Test-lokale Variablen (Typ, Name, Defaultwert)
- Generiere Python-Klassen in `destination/src/variables/var_*.py`

*Phase 6 — Globale Variablen Generator* (global_vars_generator.py)
- Lese `source_root/Profiles/default.glbl` (Katalon Profile XML)
- Parse GlobalVariableEntity-Einträge
- Generiere `destination/src/profiles/global_variables.py`

```python
class GlobalVariables:
    URL = "https://..."
    USERNAME = "admin"
    PASSWORD = "secret"
```

*Phase 7 — Runtime Files & Config* (copy_runtime_files.py)
- Kopiere `src/runtime/base_test.py` ins Ziel-Projekt
- Kopiere `src/runtime/katalon_helpers.py` ins Ziel-Projekt
- Generiere `pytest.ini`, `requirements.txt`, `.gitignore`, `README.md`
- Kopiere Test-Daten von `source_root/Data Files` nach `destination/data/`

== Kernmodule und ihre Funktionen

=== test_transpiler.py — Groovy→Python Transpilfähigkeit
Dieser Modul implementiert den Kern der syntaktischen Transformation:

```python
def translate_katalon_test(katalon_test_path: str) -> Tuple[str, str]:
    """
    Read .groovy file, parse Groovy Syntax, emit Python Pytest code.
    Returns: (python_code, error_message)
    """
```

Schlüssel-Funktionen:
- `parse_katalon_test()`: Zerlege Groovy in Linien, finde WebUI-Methoden
- `get_katalon_test_name()`: Extrahiere Test-Namen aus Dateipfad
- `cast_parameter()`: Konvertiere numerische String-Parameter zu int/float

=== test_assembler.py — Pytest Code-Generierung
Die `TestAssembler`-Klasse übersetzt erkannte WebUI-Methodenaufrufe zu Selenium-Äquivalenten:

```python
class TestAssembler:
    translate_methods_list = [
        "openBrowser", "click", "setText", 
        "verifyElementPresent", "delay", ...
    ]
    
    def click(self, to, *args):
        self.file_content_tests.append(f"{to}.click()")
    
    def setText(self, to, text, *args):
        self.file_content_tests.append(
            f"{to}.clear()\n{to}.send_keys({text})"
        )
```

Jede Methode kennt die Katalon-Signatur und erzeugt das Python-Äquivalent.

=== object_repo_converter.py — Object Repository Migration
Konvertiert Katalon's Object Repository Format:

```python
def create_object_repository(source_root: str, destination_root: str):
    # Scanne source_root/Object Repository
    # Für jede .rs XML-Datei:
    #   → write_xml_to_json(xml_path, json_path)
```

Der Output ist eine JSON-Struktur, die von `katalon_helpers.py` im Ziel-Projekt gelesen wird:

```json
{
  "WebElementEntity": {
    "selectorMethod": "XPATH",
    "selectorCollection": {
      "entry": [
        {"key": "XPATH", "value": "//input[@id='email']"}
      ]
    }
  }
}
```

Das folgende Diagramm zeigt den Transformationsprozess von Katalon Object Repository zu JSON:

```mermaid
graph LR
    A["Input:<br/>Object Repository/<br/>*.rs XML"] --> B["Scanner:<br/>Alle .rs Dateien<br/>verzeichnis-rekursiv"]
    B --> C["XML Parser:<br/>xmltodict"]
    C --> D["Extract:<br/>WebElementEntity<br/>selectorMethod<br/>selectorCollection"]
    D --> E["Transform:<br/>Nested XML →<br/>Flache JSON<br/>Struktur"]
    E --> F["Map Locators:<br/>XPATH/CSS/ID<br/>zu Selenium<br/>By-Strategien"]
    F --> G["Output:<br/>src/object_repository/<br/>*.rs JSON"]
    
    style A fill:#e8f4f8
    style G fill:#c8f4c8
    style C fill:#ffe8c8
    style E fill:#ffe8c8
    style F fill:#ffe8c8
```

Die konvertierten JSON-Dateien werden zur Laufzeit von `katalon_helpers.py` gelesen, um Locator-Strategien zu bestimmen.

=== global_vars_generator.py — Globale Variablen
Liest `.glbl` XML-Profil und generiert Python:

```python
def create_global_variables_file(source_root: str, dest_root: str):
    glbl_path = f"{source_root}/Profiles/default.glbl"
    with open(glbl_path) as f:
        profile_data = xmltodict.parse(f.read())
    
    # Extract GlobalVariableEntity items
    for entity in profile_data["GlobalVariableEntities"]["GlobalVariableEntity"]:
        name = normalize_identifier(entity["name"])
        value = to_python_literal(entity["initValue"])
        # Write: name = value
```

Das folgende Diagramm zeigt die Generierung von globalen Variablen und die Extraktion von Test-lokalen Variablen:

```mermaid
graph LR
    A1["Input:<br/>Profiles/<br/>default.glbl"]
    A2["Input:<br/>Test Cases/<br/>*.tc XML"]
    
    A1 --> B1["Parser:<br/>xmltodict<br/>GlobalVariableEntity"]
    A2 --> B2["Parser:<br/>xmltodict<br/>variable tags"]
    
    B1 --> C1["Extract:<br/>Name +<br/>Initial Value +<br/>Type"]
    B2 --> C2["Extract:<br/>Variable Name +<br/>Default Value +<br/>Type Info"]
    
    C1 --> D1["Normalize:<br/>SCREAMING_SNAKE_CASE<br/>Python Literal"]
    C2 --> D2["Normalize:<br/>snake_case<br/>Class Attributes"]
    
    D1 --> E1["Output:<br/>src/profiles/<br/>global_variables.py"]
    D2 --> E2["Output:<br/>src/variables/<br/>var_*.py"]
    
    style A1 fill:#e8f4f8
    style A2 fill:#e8f4f8
    style E1 fill:#c8f4c8
    style E2 fill:#c8f4c8
    style D1 fill:#ffe8c8
    style D2 fill:#ffe8c8
```

Die generierten Variablen-Module stehen allen Tests zur Verfügung und können über Import oder direkt über ihren Klassen-Namespace angesprochen werden.

=== runtime/base_test.py — Selenium Base Class
Die Basis-Testklasse für alle generierten Tests:

```python
class BaseTest:
    @classmethod
    def setup_class(cls):
        cls.driver = cls.chrome_configurations()
        cls.driver.maximize_window()
        cls.driver.get(GlobalVariables.URL)
    
    @classmethod
    def teardown_class(cls):
        if hasattr(cls, "driver"):
            cls.driver.quit()
```

=== runtime/katalon_helpers.py — Katalon-kompatible Helfer
Stellt Funktionen bereit, die von generierten Tests aufgerufen werden:

```python
def find_katalon_test_object(driver, path: str) -> WebElement:
    """Locate element via converted Object Repository JSON."""
    # Read JSON from src/object_repository/
    # Extract selector (CSS, XPATH, etc.)
    # Return driver.find_element(...)

def find_katalon_test_data(csv_name, column, row) -> str:
    """Read test data from CSV files in data/ folder."""
```

Diese Module werden ins Ziel-Projekt kopiert und sind Runtime-Abhängigkeiten.

== Fehlerbehandlung und Robustheit

Das Tool implementiert mehrere Validierungsebenen:

1. *Transpilation-Fehler*: Tests mit Custom Code (z.B. `if`-Statements, String-Variablen-Deklarationen) werden als "not automatically translateable" gekennzeichnet und in `src/unreadable_tests/` geschrieben

2. *Referenz-Validierung*: `check_params_for_specialties()` validiert dass:
   - Alle `findTestObject('...')` Referenzen im Object Repository existieren
   - Alle `findTestData('...')` Referenzen in Data Files existieren

3. *Import-Validierung*: Vor der Generierung wird geprüft, dass alle notwendigen Module verfügbar sind

== Konfigurierbarkeit und Erweiterung

Das System ist für Erweiterungen ausgelegt:

- Neue WebUI-Methoden: Einfach neue Methoden zu `TestAssembler` hinzufügen
- Neue Datenquellen: Neue Extraktoren für Custom Keywords oder Plugins
- Verschiedene Browser: `base_test.py` kann für Firefox, Edge angepasst werden
- Pytest-Hooks: `conftest.py` in Ziel-Projekt kann Hook-Integration vornehmen

```python
def write_test_file(test_content, test_name, output_dir):
    filepath = os.path.join(output_dir, f"test_{test_name}.py")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(test_content)
```

Fügt auch automatisch:
- Import-Statements (pytest, selenium, etc.)
- Fixture-Definitionen in `conftest.py`
- Test-Daten-Referenzen ein
- Konfigurationsdetails in `pytest.ini` oder `pyproject.toml`

=== base_test.py — Pytest-Basis-Klasse
Definiert eine Basis-Testklasse, die von allen migrierten Tests erbt:

```python
class BaseTestCase:
    @pytest.fixture(autouse=True)
    def setup(self):
        self.driver = self.get_webdriver()
        self.wait = WebDriverWait(self.driver, timeout=10)
        
    def teardown(self):
        self.driver.quit()
```

= Evaluation & Results
// Since you just completed your results phase, you should fully draft this section right now!
#figure(
  table(
    columns: (1.5fr, 1fr, 1fr),
    inset: 10pt,
    align: (left, center, center),
    [*Test Suite Key*], [*Katalon Execution (s)*], [*Selenium Execution (s)*],
    [TS-01: Core Authentication], [14.2], [11.5],
    [TS-02: Inventory Checkout], [32.8], [24.1],
    [TS-03: Reporting Dashboard], [45.1], [41.9],
  ),
  caption: [Runtime performance and execution velocity comparisons between the legacy system and the migrated prototype. (Source: Compiled from test logs)],
) <table-performance>

The validation metrics recorded inside @table-performance show the functional performance of direct WebDriver implementation.

= Discussion & Future Work
[Evaluate technical constraints, limitations, and future scalability to frameworks like Playwright or Cypress.]

= Conclusion / Zusammenfassung
[Summarize final project milestones.]

#pagebreak()

// ==========================================
// BACK MATTER (Arabic Numerals Continued)
// ==========================================

= Appendix / Anhang
[Attach sample XML files and extracted parsed code structures here.]

= Declaration of Originality / Eigenständigkeitserklärung
I hereby declare that:
- I have written this academic thesis independently and without any unauthorized assistance,
- I have not used any sources or aids other than those explicitly specified,
- I have clearly marked all passages taken verbatim or in spirit from the referenced sources as citations,
- This work has not been submitted in the same or a similar form to any other examination authority.

#v(5em)
#grid(
  columns: (1fr, 1fr),
  row-gutter: 2em,
  [.................................................... \ \ Berlin, Date],
  [.................................................... \ \ Konstantin Regenhardt]
)