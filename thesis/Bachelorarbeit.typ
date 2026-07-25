#import "template.typ": project

#show: project.with(
  thesisKindDE: "Bachelorarebeit",
  thesisExaminationDE: "Bachelorprüfung",
  thesisKindEN: "Bachelor Thesis",
  thesisExaminationEN: "Bachelor Examination",
  titleDE: "Entwurf und Evaluation eines automatisierten Migrationswerkzeugs von Katalon-Groovy-Tests zu Selenium-Pytest",
  titleEN: "From Proprietary Test Automation to Open Execution: Design and Evaluation of a Katalon-to-Selenium/Pytest Migration Tool",
  abstractDE: [
    In der Softwareentwicklung bieten proprietäre Low-Code-Plattformen wie Katalon einen schnellen Einstieg in die Testautomatisierung. Mit steigender Projektkomplexität führen diese jedoch häufig zu einem massiven Kostenanstieg durch unflexible Lizenzmodelle für fortgeschrittene Funktionen. Da die Testlogik und Datenobjekte in proprietären Formaten gespeichert sind, stehen Nutzer vor dem Dilemma, entweder hohe Gebühren zu zahlen oder den Verlust der bisherigen Entwicklungsarbeit bei einem Plattformwechsel hinzunehmen. 
    Ziel dieser Bachelorarbeit ist die Entwicklung eines programmatischen Migrationspfades von Katalon zu einer Open-Source-Alternative, geschrieben in Selenium. Dabei soll die manuelle Neuerstellung der Test-Suites durch eine automatisierte Transformations-Pipeline ersetzt werden, um die bisherige Arbeit nicht zu verlieren. 
    Es wird ein Migrations-Algorithmus entworfen, der auf Regular Expressions und Python-Methoden basiert. Dieser scannt die proprietären Strukturen, übersetzt die bestehende Testlogik von Groovy nach Python und bildet die internen Datenobjekte sowie Referenzdateien auf eine neue, Open-Source Projektstruktur im Selenium-Framework ab. 
    Das Ergebnis ist ein funktionsfähiger Prototyp eines Migrations-Tools. Dieses Tool ermöglicht den Transfer von Test-Suiten in ein erweiterbares Open-Source-Projekt. Dabei bleibt die Integrität der Tests gewahrt und die Abhängigkeit von Lizenzgebühren wird vollständig eliminiert. 
    Die Arbeit zeigt auf, wie durch automatisierte Code-Migration und -Transformation der Wechsel von proprietären "Low-Code" zu Open-Source "Pro-Code" gelingen kann. Die Ergebnisse bieten Nutzern eine gute Möglichkeit für den Ausstieg aus proprietären Test-Ökosystemen. 
  ],
  abstractEN: [
    In software development, proprietary low-code platforms like _Katalon_ offer a fast initial entry point into test automation. However, as project complexity scales, these systems frequently lead to a massive escalation of costs due to inflexible licensing frameworks. This thesis addresses this "Vendor Lock-In" problem by establishing an automated transformation pipeline that migrates test suites from closed Katalon structures into an open-source, flexible framework written in Python using _Selenium_. 

    A core migration algorithm based on Python execution logic and Regular Expressions (Regex) handles the automated parsing of proprietary formats, translations of test scripts from _Groovy_ to _Python_, and mapping of object repositories. The evaluation showcases a fully functional prototype that successfully eliminates license fee dependencies while completely preserving test suite runtime integrity.
  ],
  keywordsDE: "",
  keywordsEN: "",
  author: "Konstantin Lucius Regenhardt",
  language: "de",
  studyCourseName: "Bachelor of Science Umweltinformatik",
  submissionDate: "01.08.2026",
  departmentDE: "Fachbereich 2",
  departmentEN: "Faculty 2",
  facultyDE: "Fakultät Technik und Informatik",
  facultyEN: "Faculty of Engineering and Computer Science",
  university: "Hochschule für Technik und Wirtschaft Berlin",
  firstSupervisor: "Prof. Dr. Jochen Wittmann",
  secondSupervisor: "Prof. Dr. Zaphod Beeblebrox",
  )

#pagebreak()

// ==========================================
// MAIN BODY (Numbered in Arabic Numerals: 1, 2, 3...)
// ==========================================
= Einleitung
== Motivation 

Automatisiertes Testen ist eine zentrale Komponente moderner Software-Qualitätssicherung. In vielen Teams werden Testautomatisierungs-Frameworks eingesetzt, um Regressionstests zu beschleunigen und das Vertrauen in Veröffentlichungen zu stärken@katalon_website. Anfangs nutzte unser Team Katalon Studio als IDE um neben der Entwicklung einer internen Geschäftssoftware auch eine grundlegende Testinfrastruktur aufzubauen. Im Laufe der Zeit wuchs die Infrastruktur stark an und umspannte den Großteil der Software.

Da sich die Anforderungen des Projekts weiterentwickelten, benötigte das Team fortgeschrittenere Automatisierungs-Techniken, wie automatisiertes Berechnen von Datums-Einträgen und eine tiefere Kontrolle über die Testausführung und das Debugging. In dieser Phase traten erste Blockaden auf: Erweiterte Funktionen, die im Programmieren als elementar gesehen werden, erforderten zusätzliche Lizenzen, was erhebliche Kosten verursachte und die Skalierung der Infrastruktur einschränkte. Dies kristallisierte sich schnell als ein blockierendes Problem heraus da die Preise in keinem Verhältnis zu den Leistungen standen und über längere Zeit nicht tragbar waren. Als Lösungsansatz wurde eine Migration zu einem Open-Source Projekt vorgeschlagen. 

Angesichts der erheblichen bestehenden Investitionen in eine Katalon-basierte Test-Umgebung war ein vollständiges Neuschreiben der aller gesammelten Tests von Grund auf, nicht machbar. Deswegen wurde ein Migrationsansatz als PoC untersucht, um die zuvor erstellten Tests und alles Zugehörige zu erhalten und gleichzeitig den Übergang zu einer offenen und erweiterbaren Open-Source Struktur zu ermöglichen.

== Problemstellung

Das Kernproblem das in dieser Arbeit behandelt wird, ist die Frage wie ein bestehendes Katalon-Projekt beim Wechsel in eine lizenzunabhängige Open-Source Umgebung beibehalten und wiederverwendet werden kann. Eine manuelle Migration von Katalon-Tests zu Selenium/Pytest ist extrem zeitaufwendig und bei einer großen Testmenge praktisch unerreichbar. Das liegt daran, dass neben der reinen Skriptübersetzung eine Menge an zusätzlichen Abhängigkeiten und Konfigurationen berücksichtigt werden müssen. Ein Katalon-Projekt besteht nicht nur aus Testskripten, sondern auch aus einer Vielzahl von Assets wie Objekt-Repositorys, Variablen-Definitionen, globalen Profilen und Datenabhängigkeiten. Diese sind jeweils in proprietären Formaten gespeichert und müssten manuell "ausgegraben" und zusammengeführt werden.
Eine manuelle Migration würde daher nicht nur die Übersetzung von Groovy nach Python erfordern, sondern auch die Rekonstruktion der gesamten Projektstruktur und die Anpassung an die Open-Source-Frameworks.

Die technische Herausforderung liegt nicht nur in der syntaktischen Konvertierung des Testcodes, sondern in der End-to-End-Transformation eines Testautomatisierungsprojekts in ein ausführbares und skalierbares alternatives Format.

== Ziel & Aufbau der Arbeit 

Das Ziel dieser Arbeit ist es, einen automatisierten Migrator zu entwerfen, zu implementieren und zu evaluieren, der Katalon-basierte Testprojekte in eine Python-Selenium/Pytest-Projektstruktur konvertiert.

Um dieses Ziel zu erreichen wird in dieser Arbeit zuerst werden die Struktur eines Katalon-Projektes und die eines Python-Selenium/Pytest-Projektes analysiert. Dann wird Stück für Stück ein Migrationsalgorithmus entworfen, der die proprietären Formate des einen in offen nutzbare Formate des anderen überführt. Anschließend wird ein Prototyp implementiert, der die Transformation automatisiert und die Integrität der Tests sicherstellt. Abschließend werden die Ergebnisse evaluiert und diskutiert, um die Effektivität des Migrationsprozesses zu bewerten.

= Grundlagen
== Automatisiertes Testen

Softwaretests sind ein grundlegender Bestandteil der Qualitätssicherung in der Softwareentwicklung. Ihr Ziel ist es, sicherzustellen, dass ein System korrekt funktioniert und definierte Anforderungen erfüllt. Dabei unterscheidet man grob zwischen manuellen und automatisierten Tests.

Bei manuellen Tests führt eine Person die Testschritte selbst aus und bewertet das Ergebnis. Dieser Ansatz ist bei kleinen, seltenen oder testhaften Überprüfungen praktikabel, skaliert jedoch schlecht: Mit wachsender Softwarekomplexität steigt der Zeitaufwand für manuelle Regressionstests exponentiell.

Automatisiertes Testen bezeichnet das maschinengestützte Ausführen von Testfällen anhand von Testskripten. Die Skripte definieren Eingaben, Aktionen und erwartete Ergebnisse. Wesentliche Vorteile automatisierter Tests sind@istqb_glossary:
- *Wiederholbarkeit*: Dieselben Tests können beliebig oft und konsistent ausgeführt werden.
- *Geschwindigkeit*: Große Test-Suiten lassen sich in kurzer Zeit ausführen.
- *Regressionssicherheit*: Nach Codeänderungen kann schnell geprüft werden, ob bestehende Funktionalität noch korrekt arbeitet.
- *CI/CD-Integration*: Automatisierte Tests können direkt in Deployment-Pipelines eingebunden werden.

Ein häufig eingesetztes Verfahren ist der *End-to-End-Test* (E2E-Test), bei dem eine Anwendung aus Nutzerperspektive durch die Benutzeroberfläche getestet wird. Werkzeuge wie die Selenium @webdriver ermöglichen solche Tests für webbasierte Anwendungen, indem sie einen Browser programmatisch steuern.

== Vendor Lock-in bei proprietären Plattformen
@vendor-lock-in beschreibt die Abhängigkeit eines Nutzers oder einer Organisation von einem bestimmten Anbieter, sodass ein Wechsel zu einer Alternative mit erheblichem Aufwand oder hohen Kosten verbunden ist@shapiro1998information. Diese Abhängigkeit entsteht häufig durch proprietäre Dateiformate, plattformspezifische Programmiersprachen oder APIs, die außerhalb des jeweiligen Ökosystems nicht verwendet werden können.

Im Bereich der Testautomatisierung zeigt sich Vendor Lock-in beispielsweise dann, wenn:
- Testskripte in einer plattformeigenen Skriptsprache verfasst sind und nicht ohne Weiteres auf andere Frameworks übertragen werden können,
- interne Datenstrukturen wie Objekt-Repositorys oder Profil-Konfigurationen in proprietären Formaten gespeichert sind,
- bestimmte Funktionen nur in kostenpflichtigen Lizenzstufen verfügbar sind.

Die Konsequenz ist, dass Teams entweder steigende Lizenzkosten akzeptieren oder bei einem Plattformwechsel einen erheblichen Teil ihrer bisherigen Arbeit verlieren. Für das in dieser Arbeit beschriebene Projekt manifestierte sich dieses Problem konkret: Grundlegende Entwicklungsfunktionen wie das Debugging über die CLI erforderten teurere Lizenzpakete, was die langfristige Nutzung der Plattform unwirtschaftlich machte.

== Low-Code-Plattformen im Testbereich
Low-Code-Plattformen sind Entwicklungsumgebungen, die komplexe technische Operationen durch grafische Oberflächen und vorgefertigte Bausteine abstrahieren. Im Bereich der Testautomatisierung bieten sie einen niedrigschwelligen Einstieg: Tests können über eine GUI aufgezeichnet oder aus einem Katalog von vordefinierten Aktionen zusammengestellt werden, ohne tiefgehende Programmierkenntnisse vorauszusetzen.

Diese Eigenschaft macht Low-Code-Tools attraktiv für Teams in der frühen Phase der Testautomatisierung. Mit wachsender Anforderungskomplexität stoßen sie jedoch an Grenzen@sahay2020lowcode:
- Individuelle Logik, die über vorgefertigte Bausteine hinausgeht, ist schwer oder gar nicht umsetzbar.
- Die Testlogik ist eng an die Plattform gebunden und schlecht in externe Versionskontrollsysteme integrierbar.
- Skalierbarkeit und Anpassbarkeit sind durch das Plattformmodell begrenzt.

Im Gegensatz dazu stehen sogenannte *Pro-Code*-Ansätze, bei denen Tests vollständig in einer allgemeinen Programmiersprache wie Python geschrieben werden. Frameworks wie Selenium und Pytest bieten dabei maximale Flexibilität, erfordern aber entsprechende Programmierkenntnisse. Der Übergang von Low-Code zu Pro-Code ist inhaltlich des Kerns dieser Arbeit.

= Strukturanalyse
== Katalon Projektstruktur

Ein Katalon Studio Projekt besteht, aus dem Blickwinkel des IDE-Benutzers, unter Anderem aus Tests, einem "Object Repository", globalen Variablen in Profilen, testeigenen Variablen, eingebundenen Test-Daten. Diese werden in einer hierarchischen Ordnerstruktur gespeichert, die von der IDE verwaltet wird. 
//Hier sollte eine Abbildung der Katalon Projektstruktur eingefügt werden, um die hierarchische Organisation und die Abhängigkeiten zwischen den verschiedenen Komponenten zu verdeutlichen.

=== Elementare Ordner und Dateien
==== Test Cases & Variablen

Die Testskripte in Katalon sind in @groovy geschrieben, einer dynamischen Sprache, die auf der @jvm läuft. Sie werden mit einer Vielzahl von eingebauten Keywords und Funktionen geliefert, die speziell für Testautomatisierung entwickelt wurden. Variablen können sowohl global als auch lokal definiert werden, wobei globale Variablen in Profilen gespeichert sind und in allen Tests zugänglich sind.
//Bild eines Tests

==== Object Repository

Das @object-repository ist ein zentrales Element in der Katalon Umgebung, das das Speichern von "@ui"-Elementen ermöglicht. Es speichert die Eigenschaften von HTML-Elementen, die während der Testausführung verwendet werden. Dafür kann der Benutzer die Elemente mit einem Tool das Katalon Studio bereitstellt auf der Webseite auswählen und im Object Repository generieren lassen. Diese Elemente können in verschiedenen Tests wiederverwendet werden, was die Wartung und Skalierbarkeit der Tests erleichtert.

==== Globale Variablen & Profile

Jede/r User/in kann in Katalon eigene globale Variablen definieren, die in verschiedenen Test Cases verwendet werden können. Diese Variablen werden in Profilen gespeichert, welche unterschiedliche Benutzende oder Umgebungen repräsentieren können. Profile ermöglichen es, Tests in verschiedenen Konfigurationen auszuführen, ohne den Testcode selbst ändern zu müssen.
Hat ein Profil die Variable "URL" mit dem Wert "https://staging.example.com" und ein anderes Profil die gleiche Variable mit dem Wert "https://production.example.com", kann der Test in beiden Umgebungen ausgeführt werden, indem einfach das entsprechende Profil ausgewählt wird.

==== Testdaten & Einbindung

Katalon kann Testdaten aus verschiedenen Quellen, wie Excel-Dateien, CSV-Dateien oder Datenbanken einbinden. Diese Testdaten können in den Testskripten referenziert werden, um die Tests mit unterschiedlichen Eingabewerten auszuführen.

==== Custom Keywords

Benutzer/Innen können eigene Methoden, sogenannte "Custom Keywords" erstellen, die in mehreren Test Cases wiederverwendet werden können. Diese Keywords werden in Groovy geschrieben und ermöglichen es, komplexere Logik für Tests zu nutzen und diese wiederverwendbar zu machen.

=== Verschachtelungen in der Katalon Struktur

Alle Dateien und Ordner die man in der Katalon @ide erstellt, werden durch den Viewport übersichtlich dargestellt.
Sobald man sich die Ordnerstruktur eines Katalon-Projekts jedoch außerhalb der @ide anschaut, erkennt man, dass die Testskripte nicht nur eine einzelne Datei sind, wie im Programmieren üblich. 

==== Verschachtelung der Test Cases

Ein "Test Case" besteht in Katalon aus mehreren Dateien, die zusammenarbeiten. Folgt man der Katalon-Ordnerstruktur im Explorer unter "Test Cases", so wie sie in der @ide zu sehen ist landet man bei einer .tc-Datei. Öffnet man diese, erkennt man schnell, dass es sich dabei um eine umbenannte .xml-Datei handelt. Sie enthält Meta-Daten, wie eine Beschreibung, den Testnamen, Tags, Kommentare, eine GUID und die eigentlichen Werte der Test-eigenen Variablen. Es gibt keine offensichtliche Referenz auf die eigentliche Testlogik. Diese ist in einer weiteren Datei gespeichert. Um sie zu finden muss man den Ordner "Scripts" öffnen, dann den Pfad des "Test Cases" spiegeln. Dort befindet sich ein Ordner der den Testnamen trägt und dieser enthält dann eine .groovy-Datei, die den Namen "Script" kombiniert mit einer zufälligen Nummer trägt. Die Nummer steht in keiner Verbindung zu der .tc-Datei. In dieser .groovy-Datei befindet sich dann die eigentliche Testlogik. Greift der Test auf eine Variable zu, wird im Skript der "rohe" Name der Variable ausgeschrieben. "Roh" bedeutet, dass der Name im Code keinen Datentyp hat und auf nichts im Test verweist. Die Variable wird im Test weder deklariert, noch initialisiert.

==== Verschachtelung der Globalen Variablen

Wenn der Test eine Globale Variable verwendet, zeigt sich dies im Code als "GlobalVariable.VARIABLENNAME". Der Wert der Variable ist nicht im Skript zu finden sondern in der Profil-Datei mit der Endung .glbl, die im Ordner "Profiles" gespeichert ist. Diese Datei ist ebenfalls eine .xml-Datei und enthält die Variablen als Eintrag in einer "GlobalVariableEntity" - ein Eintrag der die Variable beschreibt. Diese Einträge enthalten den tatsächlichen Wert und Meta-Daten, bestehend aus einer Beschreibung, dem Variablennamen, dem Datentyp und einem Boolean der beschreibt ob der Wert "protected" ist. Ist er "protected", wird der Wert als sensibel behandelt und in der @ui und bei der Bearbeitung nur mit dem Stern-Charakter maskiert angezeigt. /*In "Logs" werden die Werte dann auch nicht angezeigt. In der .glbl-Datei ist der Wert jedoch unverschlüsselt und im Klartext zu sehen.*/

==== Verschachtelung der Testdaten

Sobald man mit Katalon Studio ein Dateiformat mit Daten einbinden möchte, erstellt Katalon Studio eine .dat-Datei im Ordner "Data Files" die den gleichen Namen wie die eingebundene Datei trägt. Die Datei enthält ebenfalls XML-Strukturen, nur ein paar Meta-Daten enthalten. Unter anderem den Pfad zur eingebundenen Datei, die Dateiart, ggf. die Trenzeichen und ob der Pfad Projektintern oder -extern ist. Die eigentlichen Daten sind nicht in der .dat-Datei enthalten, sondern in der eingebundenen Datei.

==== Verschachtelung der Custom Keywords

Der Großteil der "Custom Keywords"-Logik wird im Ordner "Keywords" und selbst erstellten Unterordnern gespeichert, und ist in @groovy in der Form "KlassenName.groovy" geschrieben. Diese Skripte enthalten die eigentlichen Klassen und Methoden die in den Tests aufgerufen werden. 
Im Ordner "Libs" gibt es die "CustomKeywords.groovy"-Datei. Diese definiert statische Weiterleitungen mit dem gleichen Namen wie die Klassen im Ordner "Keywords". Diese Methoden rufen die eigentlichen Methoden in den Klassen auf und machen sie dadurch in jedem Test aufrufbar.

== Selenium/Pytest Projektstruktur

//Abbildung klassischer Selenium/Pytest Projektstruktur
Ein Projekt, das Selenium und Pytest für die Testautomatisierung nutzt, ist im Gegensatz zu Katalon nicht an eine proprietäre Projektstruktur gebunden. Pytest erwartet nur eine nachvollziehbare Dateiorganisation durch Konventionen, gültige Python-Module und eine Konfiguration im Projektwurzelverzeichnis, der "root", in Form einer pyproject.toml oder pytest.ini@pytest_configuration. In einem reinen Testprojekt enthält das Repository dabei keinen  Anwendungscode, sondern ausschließlich Testfälle, gemeinsam genutzte Hilfsmodule, Konfigurationsdateien und Testdaten. Typischerweise existiert ein zentrales "tests"-Verzeichnis, das bei wachsender Projektgröße weiter in Teilbereiche der zu testenden Anwendung gegliedert wird, beispielsweise in UI-Tests und API-Tests@pytest_good_practices. Das aus Python-Paketprojekten bekannte src-Layout ist in diesem Fall nicht zwingend erforderlich. Laut Python Packaging User Guide dient das src-Layout vor allem dazu, importierbaren Anwendungscode klar von der Projekt-root zu trennen@pypa_src_layout.

=== Testskripte & Variablen

Die eigentlichen Testfälle folgen den von Pytest vorgesehenen Namenskonventionen wie test_NAME.py oder NAME_test.py@pytest_good_practices. Anders als bei Katalon besteht ein Testfall dabei in der Regel aus genau einer Python-Datei, in der die Testlogik direkt lesbar ist. Wiederverwendbare Browser-Interaktionen, Element-Selektoren oder Methoden können in separate Hilfsmodule ausgelagert werden. Diese heißen oft "Helper"- oder "Utility"-Funktionen.

Variablen werden in einem solchen Projekt nicht über proprietäre Profil- oder Metadateien verwaltet, sondern über normale Python-Programmierstrukturen. Typisch sind Parametrisierungen in den Testfunktionen, Rückgabewerte von Fixtures, Umgebungsvariablen oder externe Konfigurationsdateien. Dadurch bleibt nachvollziehbar, woher ein Wert stammt und an welcher Stelle er in den Test eingebunden wird.

=== Testdaten & Einbindung

Testdaten werden häufig in einem eigenen Verzeichnis wie z. B. "data", "resources" oder "testdata" abgelegt und dann bei Bedarf direkt von den Tests oder von Hilfsmodulen eingelesen. Dabei kann es sich beispielsweise um JSON-, CSV-, XML- oder Excel-Dateien handeln, jedoch ist praktisch jedes Format nutzbar. Im Unterschied zu Katalon entsteht hierbei keine zusätzliche proprietäre Metadatei, die nur einen Verweis auf die eigentliche Datenquelle enthält. Stattdessen sind Dateipfade, Ladeverhalten und Weiterverarbeitung unmittelbar im Python-Code oder in den zugehörigen Hilfsfunktionen sichtbar.

=== Pytest Fixtures & Konfiguration

Eine zentrale Rolle in Pytest nimmt die Datei conftest.py ein. Die dort definierten @fixture[s] sind wiederverwendbare Testkomponenten und stehen allen Tests automatisch zur Verfügung und müssen nicht explizit importiert werden@pytest_fixtures. Auf diese Weise lassen sich gemeinsam genutzte Setups, etwa die Erstellung eines WebDriver-Objekts, Logins, temporäre Verzeichnisse oder standardisierte Testdaten, an einer gemeinsamen Stelle sammeln.

Die allgemeine Projektkonfiguration liegt typischerweise im root-Verzeichnis des Repositories. Dort können unter anderem Testpfade, Standardoptionen für den Testlauf oder Marker definiert werden@pytest_configuration. 

Für ein reines Selenium/Pytest-Testprojekt ergibt sich damit eine vergleichsweise schlanke Struktur aus Testskripten, gemeinsam genutzten Fixtures, optionalen Hilfsmodulen und separaten Testdaten. Im Vergleich zur Katalon-Struktur sind sowohl die Pfade als auch die Abhängigkeiten zwischen Testlogik, Konfiguration und Daten deutlich direkter ablesbar.

= Konzeption der Migrationspipeline

Eine ursprüngliche Idee, als die Aufgabe der Befreiung aus dem Katalon-Ökosystem aufkam, war es, ein Selenium/Pytest-Projekt zu schreiben, das Katalon-Tests direkt lesen und ausführen kann. Diese Idee wurde nach Rücksprache mit anderen Entwicklern jedoch schnell verworfen, da die proprietären Formate und die Katalon-spezifische Logik zu komplex waren, um sie direkt in einem Open-Source-Framework auszuführen. Stattdessen wurde ein Ansatz gewählt, der die Katalon-Testlogik in eine neue, offene Struktur transformiert. Durch diese komplette Trennung von Katalon-Strukturen konnten Wartbarkeit und Erweiterbarkeit gesichert werden.
Für den nächsten Ansatz wurde erst eine kleine Pipeline gebaut, die versuchte, häufig vorkommende Methoden zu übersetzen. Dieser Ansatz zeigte sehr schnell, dass die Katalon-Struktur im Hintergrund der @ide viel komplexer und verschachtelter ist, als es auf den ersten Blick scheint. Mit der Zeit entwickelten sich erst Regex-basierte Methoden zum erkennen aller Methoden, dann Weitere zum Erkennen von Pfaden zu "Test Objects", dann zum Erkennen von Variablen und schließlich zum Erkennen von Globalen Variablen und deren Werten. Mit der Zeit entstand so eine großläufige Migrationspipeline, die die zentralen Aspekte einer Katalon-Struktur erkennt, diese Transformiert und in einer neuen Selenium/Pytest-Struktur abspeichert.

== Architekturüberblick

Die Migrationspipeline ist als modulares System entworfen, das auf folgenden Kernkomponenten basiert:

1. *Katalon Project Parser* — Scannt und extrahiert alle Projektkomponenten (Test Cases, Object Repository, Variablen, Testdaten)
2. *Transformation Engine* — Wendet Regex-basierte Transformationsregeln auf Groovy-Syntax an
3. *Mapping & Validation Engine* — Mappt Katalon-Datentypen auf Python-Äquivalente und validiert die Integrität
4. *Python Code Generator* — Synthetisiert gültiges Python-Selenium-Pytest-Code aus transformierten Strukturen
5. *Asset Publisher* — Schreibt alle generierten Dateien in eine korrekte Selenium/Pytest-Projektstruktur

Diese Pipeline gewährleistet, dass jedes Element eines Katalon-Projektes systematisch und wartbar transformiert wird.

== Transformationsstrategien

Die Migration erfolgt auf drei Ebenen:

=== Syntaktische Transformation: Groovy → Python
Die Groovy-Syntax wird durch Regex-Pattern-Matching in Python-Syntax überführt. Beispiele:

- Groovy String-Interpolation `"${variable}"` → Python f-Strings `f"{variable}"`
- Groovy Class Initializers `new ClassName()` → Python Constructor `ClassName()`
- Groovy Method Calls mit optionalem Receiver → Python Attribute Access `obj.method(args)`
- Groovy Closures `{ x -> x * 2 }` → Python Lambda Functions `lambda x: x * 2`
- Katalon-spezifische Methoden wie `WebUI.click(testObject)` → Selenium WebDriver API `driver.find_element(By.ID, "id").click()`

=== Semantische Transformation: Katalon Objects → Selenium Locators
Das Katalon @object-repository speichert Testobjekte als XML-Strukturen mit verschachtelten Eigenschaften. Diese werden in "@locator"-Strategien für Selenium überführt:

- Katalon Properties (id, name, xpath, css) → Selenium By-Strategien (`By.ID`, `By.XPATH`, `By.CSS_SELECTOR`)
- Mehrschichtige Objekthierarchien → Flache Locator-Listen mit Parent-Child-Referenzen
- Dynamische Property-Substitution → Runtime Variable Substitution in Pytest Fixtures

=== Strukturelle Transformation: Projektlayout
Die hierarchische Katalon-Struktur wird in eine flache, standardisierte Python-Struktur transformiert:

```
Katalon Structure:        →  Selenium/Pytest Structure:
├── Tests/               →  tests/
├── Object Repository/   →  tests/locators/
├── Profiles/            →  tests/config/
└── Data Files/          →  tests/data/
```

== Transformations-Algorithmus

Der zentrale Transformations-Algorithmus arbeitet nach folgendem Schema:

1. *Reconnaissance Phase* — Scanne alle Katalon-Dateien und stelle ein Inventar zusammen
2. *Extraction Phase* — Parse XML/JSON Strukturen mittels Regex und DOM-Parsing
3. *Mapping Phase* — Ordne Katalon-Semantik auf Selenium-Semantik
4. *"@transpilation Phase"* — Überführe "@groovy" nach Python mittels "@regex"-Pattern-Matching
5. *Validation Phase* — Validiere, dass alle Referenzen aufgelöst wurden
6. *Generation Phase* — Schreibe Python-Dateien in das Zielverzeichnis
7. *Verification Phase* — Führe Syntax-Checks und Import-Validierungen durch

== Regex-basierte Transformation

Das Werkzeug nutzt "@regex[s]" zur Transformation von "@groovy"-Syntax. Ein Beispiel-Pattern für Katalon WebUI-Befehle:

```
Pattern:   WebUI\.(\w+)\(([^,]+),\s*(.+?)\)
Replacement: selenium_action("$1", locator="$2", args=$3)
```

Dies transformiert `WebUI.click(testObject, [timeout: 3])` zu einer äquivalenten Python-Selenium-Aufrufen, die über eine Wrapper-Funktion abstrahiert werden.

== Datenfluss durch die Pipeline

#figure(
  rect(width: 100%, height: 100pt, stroke: 1pt + gray, fill: rgb("#f7fafc"))[
    #set align(center + horizon)
    [Katalon Project] → [Parser: Extract] → [Transformer: Groovy→Python] → [Mapper: Objects→Locators] → [Generator: Write Code] → [Output: Pytest Structure]
  ],
  caption: [Vereinfachter Datenfluss durch die Migrationspipeline. Jede Phase produziert Intermediate Representations, die in die nächste Phase fließen.],
) <fig-dataflow>

= Implementierung des Prototyps

Die Implementierung des Migrations-Werkzeugs erfolgte in Python und nutzt eine modulare Architektur, die in eigenständige, testbare Komponenten aufgeteilt ist. Das Tool ist auf Erweiterbarkeit ausgelegt und folgt Best-Practice-Patterns für Python-Projekte.

== Projektstruktur des Migrations-Tools

Das Tool wird mit der folgenden Modularisierung organisiert:

```
migration-tool/
├── src/
│   ├── translation/
│   │   ├── CreateTest.py      # Haupteinstiegspunkt für Test-Generierung
│   │   ├── WriteTest.py       # Datei-Schreiber für Python-Test-Dateien
│   │   └── __init__.py
│   ├── utils/
│   │   ├── parse_katalon_input.py    # Katalon-Projekt-Parser
│   │   ├── xml2json.py               # XML↔JSON Konvertierung
│   │   ├── katalon_helpers.py        # Katalon-spezifische Utilities
│   │   ├── helper_functions.py       # Allgemeine Utility-Funktionen
│   │   ├── block_comment_skipper.py  # Comment-Handling für Parsing
│   │   └── base_test.py              # Test-Basis-Klasse für Pytest
│   ├── variables/                    # Katalon-Test-Daten (JSON-Format)
│   └── data/                         # Rohe Katalon-Projektdaten
├── tests/                            # Pytest Test-Suite
├── main.py                           # Kommandozeilen-Interface
└── pyrightconfig.json               # Python Type-Checking
```

== Kernmodule und Verantwortlichkeiten

=== parse_katalon_input.py — Katalon-Projekt-Parser
Dieses Modul liest das Katalon-Projekt vom Dateisystem ein und extrahiert alle relevanten Komponenten:

- Scannt `Tests/` Verzeichnis nach `.tc` Dateien (Katalon Test Cases)
- Parst `Object Repository/` XML-Strukturen
- Extrahiert globale Variablen aus `.glbl` Profile-Dateien
- Mappt Test-Daten-Referenzen auf entsprechende JSON/CSV-Dateien

Das Modul gibt eine strukturierte Python-Repräsentation aus (z.B. als Dictionary oder Dataclass), die für die nächste Pipeline-Phase zugänglich ist.

=== xml2json.py — Format-Konvertierung
Katalon speichert Objekt-Repositories und Test-Daten im XML-Format. Dieses Modul konvertiert:

- Katalon `.rs` (Repository) XML-Dateien in JSON-Strukturen für einfacheres Parsing
- Verschachtelte XML-Hierarchien in flache JSON-Objekt-Listen
- Erhält alle Metadaten (Eigenschafts-Namen, Werte, Typen)

Beispiel:
```xml
<WebElementProperties>
  <isSelected>false</isSelected>
  <matchCondition>equals</matchCondition>
  <name>id</name>
  <type>Main</type>
  <value>user-email</value>
</WebElementProperties>
```
wird zu:
```json
{
  "property": {"name": "id", "value": "user-email", "type": "Main"}
}
```

=== katalon_helpers.py — Katalon-Spezifische Transformationen
Enthält alle WebUI-Methoden-Mappings und Katalon-zu-Selenium Transformationen:

```python
KATALON_SELENIUM_MAPPING = {
    'WebUI.click': 'driver.find_element(...).click()',
    'WebUI.setText': 'driver.find_element(...).send_keys(...)',
    'WebUI.delay': 'time.sleep(...)',
    'WebUI.verifyElementPresent': 'assert driver.find_element(...)',
    # ... weitere Mappings
}
```

Dieses Modul enthält auch Regex-Pattern-Definitionen zur Transformation:

- Pattern für Groovy String-Interpolation: `r'\$\{([^}]+)\}'` → f-String Variablen
- Pattern für Katalon WebUI-Methoden: `r'WebUI\\.(\w+)\\('` → Lokalisierungs- und Interaktions-Befehle
- Pattern für Groovy Closures: `r'\\{\\s*\\w+\\s*->.*\\}'` → Python Lambda-Funktionen

=== CreateTest.py — Test-Generierungs-Engine
Dies ist die zentrale Transformations-Engine. Sie orchestriert die Pipeline:

1. *Parse Phase*: `parse_katalon_input()` aufrufen
2. *Transform Phase*: Groovy-Groovy nach Python Transformationen anwenden
3. *Map Phase*: Katalon Objects auf Selenium Locators mappen
4. *Generate Phase*: Python Test-Dateien synthetisieren
5. *Write Phase*: In Ausgabe-Verzeichnis schreiben

```python
def migrate_test_case(katalon_test, object_repository, global_variables):
    # 1. Parse Katalon Test Structure
    groovy_code = katalon_test['script']
    
    # 2. Transform Groovy → Python
    python_code = transform_groovy_to_python(groovy_code)
    
    # 3. Map Katalon Objects → Selenium Locators
    locators = map_katalon_objects(object_repository)
    
    # 4. Generate Test Class
    pytest_code = generate_pytest_code(python_code, locators)
    
    return pytest_code
```

=== WriteTest.py — Datei-Schreiber
Schreibt die generierten Python-Dateien in eine korrekt strukturierte Pytest-Projektstruktur:

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
    
    def find_element(self, locator_dict):
        """Wraps Selenium find_element with Katalon-style locators"""
        strategy = locator_dict.get('strategy')
        value = locator_dict.get('value')
        return self.driver.find_element(STRATEGY_MAP[strategy], value)
```

== Regex-Transformations-Engine

Der Kern der Transformation sind Regex-Patterns, die folgende Transformationen durchführen:

=== Pattern 1: WebUI-Methoden-Mapping
```python
pattern = r'WebUI\.(\w+)\(([^,]+),\s*(.+?)\)'
# Transform: WebUI.click(findTestObject('Object/ID'), [timeout: 5])
# Result: driver.find_element(By.ID, "element_id").click()
```

=== Pattern 2: Groovy String-Interpolation
```python
pattern = r'\$\{(\w+)\}'
# Transform: "User: ${username}" → f"User: {username}"
```

=== Pattern 3: Test-Objekt-Referenzen
```python
pattern = r'findTestObject\(\'([^\']+)\'\)'
# Transform: findTestObject('Login/UsernameField') 
# Result: self.locators['Login']['UsernameField']
```

=== Pattern 4: Globale Variablen
```python
pattern = r'GlobalVariable\.(\w+)'
# Transform: GlobalVariable.environment → config.environment
```

== Fehlerbehandlung und Validierung

Das Tool führt mehrere Validierungsphasen durch:

1. *Syntax-Validierung*: Python AST-Parsing auf generiertem Code
2. *Referenz-Auflösung*: Prüfung, dass alle findTestObject() Aufrufe in dem OR existieren
3. *Typ-Konsistenz*: Prüfung, dass Variablen-Zuweisungen konsistent sind
4. *Import-Validierung*: Prüfung, dass alle erforderlichen Python-Module verfügbar sind

Bei Fehlern generiert das Tool aussagekräftige Fehlermeldungen mit:
- Datei und Zeilennummer
- Kontext (umgebender Code)
- Lösungsvorschlag

== Konfiguration und Erweiterbarkeit

Das Tool wird über eine Konfigurationsdatei (`migration_config.json`) konfiguriert:

```json
{
  "katalon_project_path": "./data/katalon_project",
  "output_path": "./output/selenium_project",
  "browser": "chrome",
  "base_url": "https://app.example.com",
  "timeout": 10,
  "headless": false,
  "custom_mappings": {
    "CustomKeyword.myMethod": "custom_lib.my_method"
  }
}
```

Dies ermöglicht:
- Keine Code-Änderungen für verschiedene Projekte nötig
- Custom WebDriver-Konfiguration
- Project-spezifische Mappings
- Verschiedene Ausgabe-Ziele

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