#import "template.typ": project

#show: project.with(
  thesisKindDE: "Bachelorarbeit",
  thesisExaminationDE: "Bachelorprüfung",
  titleDE: "Entwurf und Evaluation eines automatisierten Migrationswerkzeugs von Katalon-Groovy-Tests zu Selenium-Pytest",
  abstractDE: [
    Proprietäre Low-Code-Plattformen wie Katalon ermöglichen einen schnellen Einstieg in die Testautomatisierung, können bei wachsender Projektgröße jedoch zu starker Herstellerabhängigkeit und hohen Folgekosten führen. Diese Arbeit entwickelt und evaluiert eine automatisierte Migrationspipeline, die Katalon-Projekte in eine offene Python-Testumgebung mit Selenium und Pytest überführt. 
    Der entwickelte Prototyp verarbeitet Katalon-Testskripte sowie zugehörige Projektartefakte wie Object Repository, Variablen und Konfigurationsdateien und erzeugt daraus eine ausführbare Zielstruktur. In der Evaluation des Beispielprojekts wurden 7 von 10 Testskripten automatisch übersetzt (70%), während 3 Fälle als Restlücke manuell nachbearbeitet werden müssen. Alle Object-Repository-Dateien wurden erfolgreich nach JSON überführt, und die strukturelle Integrität des Zielprojekts wurde durch die fehlerfreie Erkennung der generierten Tests bestätigt. 
    Die Ergebnisse zeigen, dass der Ansatz den manuellen Migrationsaufwand deutlich reduziert und einen praktikablen Ausstiegspfad aus proprietären Testökosystemen bietet, auch wenn komplexe Sonderfälle derzeit noch nicht vollständig automatisiert abgedeckt werden.
  ],
  keywordsDE: "",
  author: "Konstantin Lucius Regenhardt",
  language: "de",
  studyCourseName: "Umweltinformatik",
  submissionDate: "02.08.2026",
  departmentDE: "Fachbereich 2",
  departmentEN: "",
  facultyDE: "Fakultät Technik und Informatik",
  facultyEN: "",
  university: "Hochschule für Technik und Wirtschaft Berlin",
  firstSupervisor: "Prof. Dr. Jochen Wittmann",
  secondSupervisor: "Ankit Kumar",
  )

#pagebreak()

// ==========================================
// MAIN BODY (Numbered in Arabic Numerals: 1, 2, 3...)
// ==========================================
= Einleitung <kap-einleitung>
== Motivation <sec-motivation>

Automatisiertes Testen ist eine zentrale Komponente moderner Software-Qualitätssicherung. In vielen Teams werden Testautomatisierungs-Frameworks eingesetzt, um Regressionstests zu beschleunigen und das Vertrauen in Veröffentlichungen zu stärken@katalon_website. Anfangs nutzte unser Team Katalon Studio als IDE um neben der Entwicklung einer internen Geschäftssoftware auch eine grundlegende Testinfrastruktur aufzubauen. Im Laufe der Zeit wuchs die Infrastruktur stark an und umspannte den Großteil der Software.

Da sich die Anforderungen des Projekts weiterentwickelten, benötigte das Team fortgeschrittenere Automatisierungs-Techniken, wie automatisiertes Berechnen von Datums-Einträgen und eine tiefere Kontrolle über die Testausführung und das Debugging. In dieser Phase traten erste Blockaden auf: Erweiterte Funktionen, die im Programmieren als elementar gesehen werden, erforderten zusätzliche Lizenzen, was erhebliche Kosten verursachte und die Skalierung der Infrastruktur einschränkte. Dies kristallisierte sich schnell als ein blockierendes Problem heraus da die Preise in keinem Verhältnis zu den Leistungen standen und über längere Zeit nicht tragbar waren. Als Lösungsansatz wurde eine Migration zu einem Open-Source Projekt vorgeschlagen. 

Angesichts der erheblichen bestehenden Investitionen in eine Katalon-basierte Test-Umgebung war ein vollständiges Neuschreiben der aller gesammelten Tests von Grund auf, nicht machbar. Deswegen wurde ein Migrationsansatz als @poc untersucht, um die zuvor erstellten Tests und alles Zugehörige zu erhalten und gleichzeitig den Übergang zu einer offenen und erweiterbaren Open-Source Struktur zu ermöglichen.

== Problemstellung <sec-problemstellung>

Das Kernproblem das in dieser Arbeit behandelt wird, ist die Frage wie ein bestehendes Katalon Projekt beim Wechsel in eine lizenzunabhängige Open-Source Umgebung beibehalten und wiederverwendet werden kann. Eine manuelle Migration von Katalon Tests zu @selenium und @pytest Tests ist relativ zeitaufwendig und bei einer großen Testmenge wird dies praktisch unerreichbar. Das liegt daran, dass neben der reinen Skriptübersetzung auch noch eine Menge an zusätzlichen Abhängigkeiten und Konfigurationen berücksichtigt werden müssen. Ein Katalon Projekt besteht nicht nur aus Testskripten, sondern auch aus einer Vielzahl von Teilen wie dem "Objekt-Repository", testexterne Variablen-Definitionen, Profilen und Datenabhängigkeiten. Diese sind jeweils in proprietären Formaten gespeichert, in ihrer Funktionsweise verschleiert und müssten manuell "ausgegraben" und zusammengeführt werden.
Eine manuelle Migration würde daher nicht nur die Übersetzung von Groovy nach Python erfordern, sondern auch die Rekonstruktion aller Teile der Projektstruktur und ihre Anpassung an die Open-Source-Frameworks.

Die technische Herausforderung liegt nicht nur in der syntaktischen Konvertierung des Testcodes, sondern in der End-to-End-Transformation eines kompletten Testautomatisierungsprojekts in ein ausführbares und skalierbares alternatives Format.

== Ziel & Aufbau der Arbeit <sec-ziel-aufbau>

Das Ziel dieser Arbeit ist es, einen automatisierten Migrator zu entwerfen, zu implementieren und zu evaluieren, der Katalon-basierte Testprojekte in eine ausführbare Python-Projektstruktur überführt. Um dieses Ziel zu erreichen wird in dieser Arbeit zuerst die Struktur eines Katalon Projektes und die eines Python Projektes analysiert. Dann wird Stück für Stück ein Migrationsalgorithmus entworfen, der die proprietären Formate des einen, in offen nutzbare Formate des anderen transformiert. Anschließend wird ein Prototyp implementiert, der die Migration automatisiert und die Testlogik so weit wie möglich erhält. Die Evaluation konzentriert sich dabei auf vier Kernfragen: Wie viel des Quellprojekts wird automatisch übersetzt, wie hoch ist der tatsächliche Automatisierungsgrad, in welchem Umfang ist das resultierende Python-Projekt funktional äquivalent zum Katalon-Ausgangsprojekt und welche Fälle bleiben unübersetzt und erfordern manuelle Nacharbeit.

= Grundlagen <kap-grundlagen>
== Automatisiertes Testen <sec-automatisiertes-testen>

Softwaretests sind ein grundlegender Bestandteil der Qualitätssicherung in der Softwareentwicklung. Ihr Ziel ist es, sicherzustellen, dass ein System korrekt funktioniert und definierte Anforderungen erfüllt. Dabei unterscheidet man grob zwischen manuellen und automatisierten Tests.

Bei manuellen Tests, auch @regression-test genannt, führt eine Person die Testschritte selbst aus und bewertet das Ergebnis@istqb_glossary. Dieser Ansatz ist bei kleinen, seltenen oder exemplarischen Überprüfungen gut nutzbar, jedoch skaliert dessen Zeitaufwand schnell. Mit wachsender Softwarekomplexität steigt der Zeitaufwand für manuelle Tests bei vollständiger Abdeckung stark an, da die Anzahl möglicher Kombinationen mit der Anzahl von Eingabeparametern exponentiell wächst@nist_sp800_142[S. 34, S. 37].

Automatisiertes Testen bezeichnet das Ausführen von Tests mit Hilfe von Testskripten, die von einem Computer ausgeführt werden. Die Skripte definieren Eingaben, Aktionen und erwartete Ergebnisse. Einer der größten Vorteile davon, gegenüber manuellen Tests ist die Frequenz. Man kann sie beliebig oft und sehr konsistent durchführen. Die sich dadurch ergebende Geschwindigkeit erlaubt es große Mengen an Tests effizient in Form von Test-Suites abzuarbeiten. Nach Codeänderungen kann dadurch zum Beispiel schnell überprüft werden ob bestehende Funktionalität noch korrekt arbeitet. Dazu kann man automatisierte Tests direkt in CI/CD-Pipelines einbinden und so in den regulären Entwicklungsprozess integrieren@chittala2024cicd[S. 884].

Für webbasierte Anwendungen hat sich dabei der @selenium @webdriver als weit verbreitetes Werkzeug etabliert. Der @webdriver ist ein standardisiertes @api, über das die Testskripte einen Browser programmatisch steuern. Klicks, Formulareingaben und Navigationsbefehle werden direkt an den Browser gesendet, als ob ein Nutzer sie manuell ausführen würde@selenium_webdriver.

== Low-Code-Plattformen im Testbereich <sec-low-code-testbereich>
@low-code[Low-Code]-Plattformen sind Entwicklungsumgebungen, die komplexe technische Operationen durch grafische Oberflächen und vorgefertigte Bausteine abstrahieren. Im Bereich der Testautomatisierung bieten sie einen niedrigschwelligen Einstieg: Tests können über eine GUI aufgezeichnet oder aus einem Katalog von vordefinierten Aktionen zusammengestellt werden, ohne tiefgehende Programmierkenntnisse vorauszusetzen.

Diese Eigenschaft macht @low-code[Low-Code]-Tools attraktiv für Teams die wenig Programmierkenntnisse haben. Mit wachsender Anforderungskomplexität stoßen auch sie oft schnell an Grenzen@sahay2020lowcode. Individuelle Logik, die über vorgefertigte Bausteine hinausgeht, ist dabei schwer oder gar nicht umsetzbar. Da die Testlogik eng an die Plattform gebunden ist, lässt sie sich zudem schlecht in externe Versionskontrollsysteme integrieren. Skalierbarkeit und Anpassbarkeit bleiben durch das Plattformmodell begrenzt.

Im Gegensatz dazu stehen sogenannte @pro-code[Pro-Code]-Ansätze, bei denen Tests vollständig in einer allgemeinen Programmiersprache wie Python geschrieben werden. Frameworks wie @selenium und @pytest bieten dabei maximale Flexibilität, erfordern aber entsprechende Programmierkenntnisse. Dabei sind diese Frameworks alle Open-Source, also kostenlos, öffentlich zugänglich und transparent. Der Übergang von @low-code[Low-Code] zu @pro-code[Pro-Code] ist inhaltlich des Kerns dieser Arbeit.
//TODO: Vielleicht Bild von Low-Code UI einfügen

== @vendor-lock-in bei proprietären Plattformen <sec-vendor-lock-in>

//TODO: weitere Quellen hinzufügen, keine Bulletpoints, vendor-lock in als Referenz markieren
@vendor-lock-in beschreibt die Abhängigkeit eines Nutzers oder einer Organisation von einem bestimmten Anbieter, sodass ein Wechsel zu einer Alternative mit erheblichem Aufwand oder hohen Kosten verbunden ist@shapiro1998information. Diese Abhängigkeit entsteht häufig durch proprietäre Dateiformate, plattformspezifische Programmiersprachen oder @api, die außerhalb des jeweiligen Ökosystems nicht verwendet werden können.

Im Bereich der Testautomatisierung zeigt sich Vendor Lock-in beispielsweise dann, wenn:
- Testskripte in einer plattformeigenen Skriptsprache verfasst sind und nicht ohne Weiteres auf andere Frameworks übertragen werden können,
- interne Datenstrukturen wie Objekt-Repositorys oder Profil-Konfigurationen in proprietären Formaten gespeichert sind,
- bestimmte Funktionen nur in kostenpflichtigen Lizenzstufen verfügbar sind.

Die Konsequenz ist, dass Teams entweder rasant steigende Lizenzkosten akzeptieren müssen oder bei einem Plattformwechsel einen erheblichen Teil ihrer bisherigen Arbeit verlieren. 
Für das in dieser Arbeit beschriebene Projekt manifestierte sich dieses Problem in Form von grundlegenden Entwicklungsfunktionen, wie das Debugging über die @cli, die teurere Lizenzpakete erforderten, was wiederum die langfristige Nutzung der Plattform sehr teuer machte. //TODO: Hier Quelle für Katalon Pricing, und/oder Anekdote an anderer Stelle einfügen

== Grundlagen zu @regex <sec-regex-grundlagen>

Der Migrator verwendet @regex, um wiederkehrende Muster im Groovy-Quelltext automatisiert zu erkennen. Nach Friedl sind Regular Expressions eine formale Sprache zur Beschreibung von Textmustern@friedl2006regex. Das bedeutet ein Muster wird definiert, auf Text angewendet und liefert bei Übereinstimmung ein @match.

Hier zum Beispiel das Erkennen von Katalon-Klickaufrufen:

#figure(
  grid(
    rows: 2,
    image("img/Regex/regex101_katalon_click.png"),
    image("img/Regex/regex101_katalon_click_expl.png")
  ),
  caption: [Oben: Erst ein Muster zum erkennen von Katalon-Klickaufrufen. Unten: Die Erklärung der einzelnen Bestandteile des Musters (Visualisierung und Validierung mit Regex101@regex101).],
)<fig-regex-grundlagen-beispiel>

Das Muster "`WebUI\.click\((.*)\)`" findet alle Zeilen die "`WebUI.click(...)`" enthalten, erstellt ein @match für jede Übereinstimmung und extrahiert den Inhalt der Klammern als Gruppe. Dieser extrahierte Teil kann anschließend in einen @selenium Methodenaufruf eingeführt werden. Spezifisch wird zuerst nach der Buchstabenreihenfolge "`WebUI.click(`" gesucht. Dabei wird ein Backslash-@delimiter "`\`" vor dem Punkt "`.`", genutzt damit dieser seine eigentliche Funktion in der Regex-Sprache verliert und nur als Punkt interpretiert wird. Der gleiche @delimiter kommt danach für die Klammern ins Spiel. Darauf folgt direkt noch eine Klammer ohne Delimiter welche die Eröffnung einer Gruppe signalisiert. In der Gruppe wird nach einem Punkt "`.`" gesucht, das heißt ein Vorkommen eines beliebigen Zeichens außer Satzenden. Der Stern "`*`" kopiert die Funktion des vorherigen Zeichens kein mal oder beliebig oft. Dann schließt sich zuerst die Gruppe durch eine Klammer "`)`" und dann endet das Muster mit einer delimitierten schließenden Klammer "`)`".
In der eigentlichen Pipeline werden dafür mehrere Muster kombiniert um alles Geschriebene in Tests wie Klassen, Methoden und Parameter systematisch zu zerlegen.
Für die Entwicklung und Visualisierung dieser Muster wurde Regex101 genutzt@regex101. Die dort iterativ verfeinerten Ausdrücke wurden anschließend in Python überprüft, damit sie mit der tatsächlichen Laufzeitumgebung des Migrators konsistent bleiben.

= Strukturanalyse <kap-strukturanalyse>
== Katalon Projektstruktur <sec-katalon-projektstruktur>
//TODO: Die Bilder sollten aus der Katalon Studio IDE stammen

//TODO: OR markierer setzen, Beschreibung erweitern, Abbildung einfügen, Quellen für Katalon Studio und Katalon Test Suite Management, weitere Ordner beschreiben
Katalon Studio ist eine proprietäre Testautomatisierungsplattform, die technisch auf der Eclipse @rcp aufbaut@katalon_rcp_413. Eclipse ist eine klassische @ide für Java-Entwicklung. 
Ein Katalon Studio Projekt besteht, aus dem Blickwinkel des Benutzers aus "Test Cases", einem "Object Repository", "Global Variables" in Profilen, testeigenen Variablen und eingebundenen Testdaten. Diese werden in einer hierarchischen Ordnerstruktur gespeichert, die komplett von der IDE verwaltet wird. 
Hier werden die wichtigsten Ordner und Dateien eines Katalon-Projekts beschrieben und alle die für dieses Projekt relevant sind. 

=== Test Cases und testeigene Variablen <subsec-test-cases-variablen>

Die Testskripte in Katalon sind in @groovy geschrieben, einer dynamischen Sprache, die auf der @jvm läuft. Sie werden mit einer Vielzahl von eingebauten Keywords und Funktionen geliefert, die speziell für Testautomatisierung entwickelt wurden. Variablen können sowohl global als auch lokal definiert werden, wobei globale Variablen in Profilen gespeichert sind und in allen Tests zugänglich sind. Testeigene Variablen werden im jeweiligen Test definiert und sind nur innerhalb dieses Tests verfügbar.
#figure(
  grid(
    columns: 2,
    image("img/Katalon Studio/test_cases_file_system.png"),
    image("img/Katalon Studio/search_for_dk_var_marker.png", ),
  ),
  caption: [Links: Das Dateisystem der Test Cases. Rechts: Ein Test Case mit Testlogik die erst das Fenster "All Users" öffnet, dann nach dem User "David Kim" sucht, diesen markiert und danach dessen Details verifiziert.]
)<fig-katalon-test-case>

=== Object Repository und Test Objects <subsec-object-repository-test-objects>
//TODO: Um Test Objects erweitern
Das @object-repository ist ein zentrales Element in der Katalon Umgebung, das das Speichern von "@ui"-Elementen ermöglicht. Es speichert die Eigenschaften von @html Elementen, die während der Testausführung verwendet werden. Dafür können die User die Elemente mit der @spy-web-utility, die Katalon Studio bereitstellt, auf der Webseite auswählen und im Object Repository generieren lassen@katalon_spy_web_utility. Diese "Test Objects" können in verschiedenen Tests wiederverwendet werden.
#figure(
  grid(
    columns: 2,
    image("img/Katalon Studio/object_repository_file_system.png", ),
    image("img/Katalon Studio/test_object.png"),
  ),
  caption: [Links: Das Dateisystem des Object Repository aufgefaltet. Blau markierte Namen wurden mit Unterstützung der @ide eigenen AI generiert. Rechts: Ein Test Object das die Eigenschaften eines @html Elements beschreibt.]
)<fig-katalon-object-repository>
//TODO: Markierungen für Glossar hinzufügen

=== Global Variables und Profile <subsec-global-variables-profile>

//TODO: Markierungen und Eintrag für Test Cases im Glossar hinzufügen
User können in Katalon eigene globale Variablen definieren, die in allen Tests verwendet werden können. Diese Variablen werden in Profilen gespeichert, welche unterschiedliche User oder Umgebungen repräsentieren können. Profile ermöglichen es, Tests in verschiedenen Konfigurationen auszuführen, ohne den Testcode selbst ändern zu müssen.
Hat ein Profil zum Beispiel die Variable "URL" mit dem Wert `https://staging.example.com` und ein anderes Profil die gleiche Variable mit dem Wert `https://production.example.com`, kann ein Test, der die Variable nutzt in beiden Umgebungen ausgeführt werden. Dafür muss nur das entsprechende Profil ausgewählt wird.
#figure(
  grid(
    columns: 2,
    image("img/Katalon Studio/profiles_file_system.png"),
    image("img/Katalon Studio/profiles_staging_example_short.png"),
  ),
  caption: [Links: Ansicht der Profile im Dateisystem. Rechts: Ein Profil das die Global Variables URL, USERNAME1 und PASSWORD1 definiert. Die PASSWORD1 Variable ist als "protected" markiert, sodass ihr Wert in der @ide nur maskiert angezeigt wird.],
)<fig-katalon-profiles>

=== Testdaten und Einbindung <subsec-testdaten-einbindung>

Katalon kann Testdaten aus verschiedenen Quellen, wie Excel-Dateien, CSV-Dateien oder Datenbanken einbinden. Diese Testdaten können in den Testskripten referenziert werden, um die Tests mit unterschiedlichen Eingabewerten auszuführen.
#figure(
  grid(
    rows: 2,
    image("img/Katalon Studio/data_files.png"),
    image("img/Katalon Studio/data_files_users_dat.png"),
  ),
  caption: [Links: Ansicht der Testdaten im Dateisystem. Rechts: Ein Testdatensatz aus der Datei users.dat.],
)<fig-katalon-data-files>

=== Custom Keywords <subsec-custom-keywords>

User können eigene Strukturen, sogenannte "Custom Keywords" erstellen, die in mehreren Tests wiederverwendet werden können. Sie funktionieren wie selbst geschriebene Methoden in klassischen objekt-orientierten Programmiersprachen. Diese Methoden werden in Groovy geschrieben und ermöglichen es, komplexere Logik für Tests zu nutzen und diese wiederverwendbar zu machen. 

== Verschachtelungen in der Katalon Struktur <sec-verschachtelungen-katalon>
//TODO: Abbildungen für Verschachtelungen einfügen, die die Komplexität der Katalon-Struktur verdeutlichen. (figure von unten nutzen)
Alle Dateien und Ordner die man in der Katalon @ide erstellt, werden durch den Viewport übersichtlich dargestellt.
Sobald man sich die Ordnerstruktur eines Katalon Projekts jedoch außerhalb der @ide anschaut, erkennt man, dass die jegliche selbsterstelle Inhalte nicht nur jeweils eine einzelne Datei sind, wie im Programmieren üblich, sondern aus mehreren Dateien bestehen.

=== Verschachtelung der Test Cases und ihrer Variablen <subsec-verschachtelung-test-cases>

Ein "Test Case" besteht in Katalon aus mehreren Dateien, die zusammenarbeiten. Folgt man der Katalon-Ordnerstruktur im Explorer unter "Test Cases", so wie sie in der @ide zu sehen ist landet man bei einer .tc-Datei. Öffnet man diese, erkennt man schnell, dass es sich dabei um eine umbenannte .xml-Datei handelt. Sie enthält Meta-Daten, wie eine Beschreibung, den Testnamen, Tags, Kommentare, eine @guid und die eigentlichen Werte der testeigenen Variablen. Es gibt keine offensichtliche Referenz auf die eigentliche Testlogik. Diese ist in einer weiteren Datei gespeichert. Man würde annehmen die @guid hilft bei der Referenzierung der beiden Dateien, doch die Testskripte enthalten diese an keiner Stelle. Um sie zu finden muss man den Ordner "Scripts" öffnen, dann den Pfad des "Test Cases" spiegeln. Dort befindet sich ein Ordner der den Testnamen trägt und dieser enthält dann eine .groovy-Datei, die den Namen "Script" kombiniert mit einer zufälligen Nummer trägt. Die Nummer steht in keiner Verbindung zu der .tc-Datei. In dieser .groovy-Datei befindet sich dann die eigentliche Testlogik. Greift der Test auf eine Variable zu, wird im Skript der "rohe" Name der Variable ausgeschrieben. "Roh" bedeutet, dass der Name im Code keinen Datentyp hat und auf nichts im Test verweist. Die Variable wird im Test weder deklariert, noch initialisiert.

#figure(
  text(size: 0.9em)[
    ```
  sample-website-katalon-tests/
  │
  ├── Test Cases/                           
  │   ├── Users/
  │   │   ├── filter_for_admins.tc         
  │   │   ├── search_for_david_kim.tc      
  │   │   └── show_active_viewers.tc
  │   └── Menus/
  │       └── navigation_bar.tc
  │
  └── Scripts/                              
      ├── Users/
      │   ├── filter_for_admins/
      │   │   └── Script1781348815820.groovy  
      │   ├── search_for_david_kim/
      │   │   └── Script1781447000826.groovy  
      │   └── show_active_viewers/
      │       └── Script...groovy
      └── Menus/
          └── navigation_bar/
              └── Script...groovy
  
  ```
  ],
  caption: [Die Abbildung zeigt die Ordnerstruktur der Test Cases und der zugehörigen Testskripte aus der Perspektive des Dateisystems. Die .tc-Dateien enthalten Meta-Daten und die .groovy-Dateien die eigentliche Testlogik.],
)<fig-katalon-test-case-structure>

=== Verschachtelung vom Objekt Repository und der Test Objects <subsec-verschachtelung-object-repository>

Will ein Test ein "Test Object" verwenden, wird im Testskript der komplette Pfad zum Speicherort der .rs-Datei angegeben um diese aufzurufen. Die .rs-Datei enthält alle Selektoren und die Angabe  welcher davon als Hauptselektor verwendet werden soll. 

#figure(
  text(size: 0.9em)[
  ```
  sample-website-katalon-tests/
  │
  └── Object Repository/                   
      ├── All_Users/
      │   ├── view_all_users_btn.rs        
      │   ├── search_input.rs
      │   ├── roles_dropdown.rs
      │   ├── status_dropdown.rs
      │   ├── user_row.rs
      │   └── user_row_view_btn.rs
      └── Nav_Bar/
          └── ...weitere Test Objects

  ```],
  caption: [Die Abbildung zeigt das Objekt Repository und die Test Objects aus der Perspektive des Dateisystems. Die .rs-Dateien enthalten die Selektoren von HTML-Elementen.],
)<fig-katalon-object-repository-structure>

=== Verschachtelung der Globalen Variablen <subsec-verschachtelung-globale-variablen>

Wenn der Test eine globale Variable verwendet, zeigt sich dies im Code als "GlobalVariable.VARIABLENNAME". Der Wert der Variable ist nicht im Skript zu finden sondern in der Profil-Datei mit der Endung .glbl, die im Ordner "Profiles" gespeichert ist. Diese Datei ist ebenfalls eine .xml-Datei und enthält die Variablen als Eintrag in einer "GlobalVariableEntity" - ein Eintrag der die Variable beschreibt. Diese Einträge enthalten den tatsächlichen Wert und Meta-Daten, bestehend aus einer Beschreibung, dem Variablennamen, dem Datentyp und einem Boolean der beschreibt ob der Wert "protected" ist. Ist er "protected", wird der Wert als sensibel behandelt und in der @ui und bei der Bearbeitung nur mit dem Stern-Charakter maskiert angezeigt. In "Logs" werden die Werte dann auch nicht angezeigt. In der .glbl-Datei ist der Wert jedoch unverschlüsselt und im Klartext zu sehen. Je nach dem welches Profil in der @ide ausgewählt ist, wird die entsprechende .glbl-Datei geladen und die Variablenwerte werden im Test verwendet.

#figure(
  text(size: 0.9em)[
    ```
  sample-website-katalon-tests/
  │
  └── Profiles/ 
      ├── default.glbl              
      └── staging.glbl                    

  ```
  ],
  caption: [Die Abbildung zeigt die Ordnerstruktur der Profile aus der Perspektive des Dateisystems. Die .glbl-Dateien enthalten die Global Variables und deren Werte.],
)<fig-katalon-profiles-structure>

=== Verschachtelung der Testdaten <subsec-verschachtelung-testdaten>

Sobald man mit Katalon Studio ein Dateiformat mit Daten einbinden möchte, erstellt Katalon Studio eine .dat-Datei im Ordner "Data Files" die den gleichen Namen wie die eingebundene Datei trägt. Die Datei enthält ebenfalls XML-Strukturen, nur ein paar Meta-Daten enthalten. Unter anderem den Pfad zur eingebundenen Datei, die Dateiart, ggf. die Trenzeichen und ob der Pfad Projektintern oder -extern ist. Die eigentlichen Daten sind nicht in der .dat-Datei enthalten, sondern in der eingebundenen Datei.

#figure(
  text(size: 0.9em)[
    ```
  sample-website-katalon-tests/
  │
  └── Data Files/                          
      └── users.dat                        
  ```
  ],
  caption: [Die Abbildung zeigt die Ordnerstruktur der Testdaten aus der Perspektive des Dateisystems. Die .dat-Dateien enthalten Meta-Daten und verweisen auf die eigentlichen Testdaten.],
)<fig-katalon-data-files-structure>

=== Verschachtelung der Custom Keywords <subsec-verschachtelung-custom-keywords>

Der Großteil der "Custom Keywords"-Logik wird im Ordner "Keywords" und selbst erstellten Unterordnern gespeichert, und ist in @groovy in der Form "KlassenName.groovy" geschrieben. Diese Skripte enthalten die eigentlichen Klassen und Methoden die in den Tests aufgerufen werden. 
Im Ordner "Libs" gibt es die "CustomKeywords.groovy"-Datei. Diese definiert statische Weiterleitungen mit dem gleichen Namen wie die Klassen im Ordner "Keywords". Diese Methoden rufen die eigentlichen Methoden in den Klassen auf und machen sie dadurch in jedem Test aufrufbar.

#figure(
  text(size: 0.9em)[
    ```
  sample-website-katalon-tests/
  │
  ├── Keywords/                          
  │   ├── data/
  │   └── TESTER.groovy                    
  │
  └── Libs/
      └── CustomKeywords.groovy            
  ```
  ],
  caption: [Die Abbildung zeigt die Ordnerstruktur der Custom Keywords aus der Perspektive des Dateisystems. Die .groovy-Dateien im Keywords-Ordner enthalten die Logik der Klassen und Methoden, die in den Tests aufgerufen werden. Im Libs-Ordner befindet sich die CustomKeywords.groovy-Datei, die statische Weiterleitungen zu den Klassen im Keywords-Ordner definiert.],
)<fig-katalon-keywords-structure>


/*Diese Struktur verdeutlicht die Komplexität, die eine Migration bewältigen muss. Besonders auffällig ist die Vielfalt der Dateiformate: Obwohl Dateien wie .tc, .rs, .glbl und .dat alle auf XML basieren, tragen sie proprietäre Endungen, die ihren Inhalt verschleiern. Hinzu kommt, dass ein einziger Test aus zwei getrennten Dateien in zwei verschiedenen Ordnern besteht — die Metadaten liegen in Test Cases/, die eigentliche Testlogik in Scripts/. Die Verbindung zwischen ihnen ist dabei nur indirekt über den Pfad herstellbar: Scripts/Users/filter_for_admins/Script1781348815820.groovy gehört zu Test Cases/Users/filter_for_admins.tc. Erschwerend kommt hinzu, dass die Script-Dateien zufällig generierte Nummern im Namen tragen, die keinerlei Rückschlüsse auf den zugehörigen Test Case erlauben.*/

== Python Projektstruktur <sec-python-projektstruktur>

Ein Projekt, das @selenium und @pytest für die Testautomatisierung nutzt, ist im Gegensatz zu Katalon nicht an eine proprietäre Projektstruktur gebunden. Pytest erwartet nur eine nachvollziehbare Dateiorganisation durch Konventionen, gültige Python-Module und eine Konfiguration im Projektwurzelverzeichnis, der "root", in Form einer pyproject.toml oder pytest.ini@pytest_configuration. In einem reinen Testprojekt enthält das Repository dabei keinen  Anwendungscode, sondern ausschließlich Tests, gemeinsam genutzte Hilfsmodule, Konfigurationsdateien und Testdaten. Typischerweise existiert ein zentrales "tests"-Verzeichnis, das bei wachsender Projektgröße weiter in Teilbereiche der zu testenden Anwendung gegliedert wird, beispielsweise in UI-Tests und API-Tests@pytest_good_practices. Das aus Python-Paketprojekten bekannte src-Layout ist in diesem Fall nicht zwingend erforderlich. Laut Python Packaging User Guide dient das src-Layout vor allem dazu, importierbaren Anwendungscode klar von der Projekt-root zu trennen@pypa_src_layout.
Da dieses Python Projekt in Abhängigkeit zur Katalon Struktur steht, wird die ursprüngliche Katalon Struktur in der Python Struktur wiedergespiegelt. Das src-Layout wird genutzt um die Katalon Strukturen von den üblichen Python Strukturen zu trennen.

=== Testskripte und Variablen <subsec-testskripte-variablen>

Die eigentlichen Testfälle folgen den von Pytest vorgesehenen Namenskonventionen wie test_NAME.py oder NAME_test.py@pytest_good_practices. Anders als bei Katalon besteht ein Testfall dabei in der Regel aus genau einer Python-Datei, in der die Testlogik direkt lesbar ist. Wiederverwendbare Element-Selektoren oder Methoden können in separate Hilfsmodule ausgelagert werden. Diese heißen oft "Helper"- oder "Utility"-Funktionen.

Variablen werden in einem solchen Projekt normalerweise nicht über proprietäre Profil- oder Metadateien verwaltet, sondern über normale Python-Programmierstrukturen. Typisch sind Variablen direkt in einem Testskript oder werden in einer zentralen Konfigurationsdatei definiert. Dadurch bleibt nachvollziehbar, woher ein Wert stammt und an welcher Stelle er in den Test eingebunden wird.

Da Katalon Studio die Variablen in eigenen Dateien speichert und sie mithilfe eines Pfades aufruft, muss der Migrator die gleiche Struktur erstellen, um die Tests unverändert ausführen zu können. Es wird der Ordner "variables" angelegt der die Struktur der Test Cases mit Variablen wiederspiegelt. In den Unterordnern werden die Variablen in Python-Klassen gespeichert, die jeweils alle Variablen des Tests enthalten. Die Klassen werden dann in den Tests importiert und die Variablen können aufgerufen werden.

#figure(
  text(size: 0.9em)[
  ```
  sample-website-selenium-tests/                    
  │
  └── src/
      ├── __init__.py
      ├── tests/                                   
      │   ├── Users/
      │   │   ├── test_filter_for_admins.py        
      │   │   ├── test_search_for_david_kim.py
      │   │   ├── test_show_active_viewers.py
      │   │   └── __init__.py
      │   ├── Menus/
      │   │   ├── test_navigation_bar.py
      │   │   └── __init__.py
      │   └── __init__.py
      |
      └── variables/                              
          ├── Users/
          │   ├── var_search_for_david_kim.py       
          │   └── __init__.py
          └── __init__.py
  ```],
  caption: [Die Abbildung zeigt die Struktur der Testskripte und der testeigenen Variablen im Zielprojekt. Die Tests sind in Python-Dateien organisiert, die den Testlogik enthalten. Die Variablen sind in separaten Python-Klassen gespeichert, die jeweils alle Variablen eines Tests enthalten.],
)<fig-selenium-output-structure-tests-variables>

=== Object Repository und Test Objects <subsec-python-object-repository>
So wie Testskripte und Variablen in der Python Struktur gespiegelt werden, werden auch das Object Repository und die Test Objects darin gespiegelt. Die Test Objects werden in JSON-Dateien gespeichert, die die gleichen Informationen enthalten wie die ursprünglichen .rs-Dateien. Die Struktur der Ordner und Unterordner wird beibehalten, sodass die Tests weiterhin auf die Test Objects zugreifen können, indem sie den Pfad zu den JSON-Dateien angeben.

#figure(
  text(size: 0.9em)[
  ```
  sample-website-selenium-tests/                    
  │
  └── src/
      ├── __init__.py
      └── object_repository/                        
          ├── All_Users/
          │   ├── view_all_users_btn.json           
          │   ├── search_input.json
          │   ├── roles_dropdown.json
          │   └── __init__.py
          ├── Nav_Bar/
          └── __init__.py
  ```],
  caption: [Die Abbildung zeigt die Struktur des Object Repositories und der "Test Objects"-Dateien die darin im JSON-Format gespeichert sind.],
)<fig-selenium-output-structure-object-repository>

=== Testdaten <subsec-python-testdaten>

Testdaten werden häufig in einem eigenen Verzeichnis wie z. B. "data", "resources" oder "testdata" abgelegt und dann bei Bedarf direkt von den Tests oder von Hilfsmodulen eingelesen. Dabei kann es sich beispielsweise um JSON-, CSV-, XML- oder Excel-Dateien handeln, jedoch ist praktisch jedes Format nutzbar. In diesem Fall wird ein "data"-Ordner angelegt, der die Testdaten aus Katalon direkt kopiert. Die Tests können dann auf die Daten zugreifen, indem sie den Pfad zu den Dateien angeben.

#figure(
  text(size: 0.9em)[
  ```
  sample-website-selenium-tests/                    
  │
  └── data/                                         
      └── users.csv                                
  ```],
  caption: [Die Abbildung zeigt die Struktur des "data"-Ordners, der die Testdaten im CSV-Format enthält.],
)<fig-selenium-output-structure-data>

=== Python Konfiguration <subsec-python-konfiguration>
Damit ein Python Projekt funktioniert muss es bestimmte Konventionen erfüllen. Dazu gehört, dass alle Verzeichnisse, die Python-Module enthalten sollen, eine \_\_init\_\_.py-Datei besitzen. Diese Dateien sind zwar leer, signalisieren dem Python-@interpreter jedoch, dass das Verzeichnis als Paket behandelt werden soll. In diesem Projekt werden sie in allen relevanten Verzeichnissen automatisch erstellt. 
Des weiteren wird eine README.md-Datei erstellt. Zum einen enthält sie Schritte zum Erstellen einer Pytest-Konfigurationsdatei, `.vscode/settings.json`. Zum anderen enthält diese Schritte zum Einrichten einer virtuellen Umgebung namens ".venv". Dort werden alle Abhängigkeiten installiert, die in der requirements.txt-Datei aufgelistet sind, die auch vom Migrator erstellt wird. Die Abhängigkeiten stehen als Liste in der requirements.txt-Datei und fungieren als Referenz aller notwendigen Python-Pakete, die für die Ausführung der Tests erforderlich sind.
Es wird eine pytest.ini-Datei erstellt, die die Konfiguration für Pytest enthält. Dort wird unter anderem der Pfad zu den Testskripten angegeben. 

#figure(
  text(size: 0.9em)[
  ```
  sample-website-selenium-tests/              
  │
  ├── data/                             
  ├── src/
  ├── .gitignore                                  
  ├── pytest.ini                                
  ├── README.md                                   
  └── requirements.txt                            
  ```],
  caption: [Übersicht über erstellten Konfigurationsdateien.],
)<fig-selenium-output-configuration>

= Konzeption der Migrationspipeline <kap-konzeption-migrationspipeline>
//TODO: Anekdote entfernen oder z. B. an den Anfang?
== Hintergrund <sec-hintergrund>
Als die Aufgabe der Migration des internen Testsystems auf ein anderes Ökosystem aufkam, war es ein erstes Konzept ein Python Projekt zu schreiben, das Katalon-Tests direkt lesen und ausführen kann. Diese Idee wurde nach Rücksprache mit anderen Entwicklern jedoch schnell verworfen, da die proprietären Formate und die Katalon-spezifische Logik zu komplex waren, um sie direkt in einem Open-Source-Framework auszuführen. Stattdessen wurde ein Ansatz gewählt, der die Katalon-Testlogik komplett in eine neue, erweiterbare und frei nutzbare Struktur transformiert. Durch diese komplette Trennung von Katalon-Strukturen sollte sichergestellt werden, dass in der Zukunft keine weiteren Probleme mit Abhängigkeiten zu Katalon mehr aufkommen. Die Tests sollten in der neuen Struktur direkt ausgeführt werden können, ohne dass Katalon Studio gebraucht würde falls beispielsweise neue Tests oder Elemente kreiert werden müssten.
Als erster Ansatz wurde eine kleine Pipeline gebaut mit der Aufgabe, häufig vorkommende Methoden zu übersetzen. Dieser Ansatz zeigte sehr schnell, dass die Katalon Struktur im Hintergrund der @ide viel komplexer und verschachtelter war, als es auf den ersten Blick schien. /*Mit der Zeit kristalisierten sich erst Regex-basierte Methoden zum Erkennen aller Katalon Funktions-Aufrufe, dann Weitere zum Erkennen von Pfaden zu @test-object[Test Objects]s, dann zum Erkennen von testeigenen Variablen und schließlich zum Erkennen von globalen Variablen und deren Werten. Mit der Zeit entstand so eine großläufige Migrationspipeline, die die zentralen Aspekte einer Katalon Struktur erkennt, diese transformiert und in einer neuen Python Struktur abspeichert.*/

== Architekturüberblick <sec-architekturüberblick>

Um die Komplexität zu zu bewältigen wird das Katalon Projekt strukturiert in seine Teile zerlegt. Ein _Vorteil_ der proprietären Struktur ist es, dass sie die Struktur vorgibt und berechenbar ist, was diese Art von Algorithmus erst möglich macht. 
Zuerst bekommt der Algorithmus die Pfade des Quell- und des Zielprojekts vom User übergeben. Anschließend werden rekursiv alle Dateien im Quellprojekt durchsucht und die relevanten Strukturen, wie "Test Case"-Ordner und das Object Repository werden im Zielprojekt als leere Ordner wiedergespiegelt. Die unveränderten Systempfade, die vom "root"-Verzeichnis zu den Dateien führen, sind dabei integral. 
Sind die Grundstrukturen somit initialisiert, werden Dateien aus der Quelle geöffnet bearbeitet. Zuerst werden die Test Cases aus der @groovy Programmiersprache in die @python Sprache transpiliert. Den genaueren Ablauf davon kann man im Kapitel @sec-transpilation-test-cases nachlesen. Anschließend werden die Test Objects, die globalen Variablen sowie die Testdaten gefunden, gelesen und übersetzt. Alle von ihnen enthalten @xml[XML]-Daten, haben jedoch unterschiedliche Dateiendungen. Die Test Objects werden dabei zu JSON-Dateien umgewandelt, die Global Variables in Python-Klassen und die Testdaten werden unverändert übernommen. Die testeigenen Variablen werden in einer Struktur gespeichert, die die der Test Cases exakt gleicht. Sie werden in Python-Klassen gespeichert und enthalten jeweils alle Variablen des entsprechenden Tests. Die Klassen werden dann in den Tests importiert.
Zuletzt werden Konfigurationsdateien und Hilfsdateien im Zielprojekt erstellt, damit dieses ohne größere Vorbereitungen ausführbar ist. Dazu zählen Laufzeithelfer, Testkonfigurationen, die List der Abhängigkeiten und Dokumentation.

#figure(
  image("diag/migration_pipeline_overview.svg", width: 100%),
  caption: [Übersichtsdiagramm der Migrationspipeline von einem Katalon Projekt zu einem ausführbaren Python Projekt. Dargestellt sind die Hauptphasen Initialisierung, Testtranspilation, Übernahme ergänzender Strukturen sowie die Bereitstellung der finalen Projektstruktur mit Inhalten.],
) <fig-migration-pipeline-overview>

== Transpilation der Test Cases <sec-transpilation-test-cases>

Der in der folgenden Abbildung dargestellte Transpilationsablauf folgt einer festen Abfolge von sieben Schritten. Zunächst wird die ursprüngliche Groovy-Datei eingelesen, damit ihr Inhalt als Rohtext verarbeitet werden kann. Anschließend werden Kommentare und Importzeilen entfernt, um den für die Migration relevanten Code zu isolieren. Im dritten Schritt werden daraus die eigentlichen Testzeilen extrahiert, also genau die Anweisungen, die für das Testverhalten maßgeblich sind. Diese Zeilen werden danach einzeln @parsing[geparst], sodass jede Anweisung in ihre grundlegenden Bestandteile wie Klassenbezug, Methodenname und Parameter zerlegt wird. Auf dieser strukturierten Grundlage folgt die Transformation der erkannten Methoden und Parameter in inhaltlich entsprechende Konstrukte der Zielumgebung. Daraus wird anschließend Python-Code erzeugt, der die zuvor identifizierte Testlogik in ausführbarer Form abbildet. Im letzten Schritt werden die generierten Codefragmente zu einem vollständigen Test zusammengesetzt und in die Zielstruktur überführt. Der gesamte Ablauf reduziert den ursprünglichen Groovy-Test damit schrittweise auf seine wesentliche Logik und überführt sie systematisch in ein Python-basiertes Testformat.

#figure(
  image("diag/transpile_flow_v4_2.png", width: 100%),
  caption: [Detailliertes Aktivitätsdiagramm des Transpilationsablaufs eines Katalon-Tests zu einem Python-Test. Dargestellt sind das Einlesen, Filtern, Extrahieren, @parsing[Parsen], Transformieren, Generieren und Zusammensetzen der Testlogik.],
) <fig-transpile-flow>

== Übernahme ergänzender Strukturen <sec-übernahme-strukturen>

Ein ausführbares Zielprojekt entsteht erst dann, wenn neben der Testlogik auch die zugehörigen Kontextstrukturen existieren. Deswegen müssen nach der Transpilation der Test Cases auch die ergänzenden Strukturen übernommen werden. Dazu gehören insbesondere Objektbeschreibungen aus dem Object Repository, Variablenquellen - global oder lokal, Testdaten sowie Laufzeit- und Konfigurationsdateien. Ohne diese Elemente wären viele erzeugte Tests zwar syntaktisch vorhanden, könnten aber nicht korrekt auf Selektoren, Daten oder Umgebungsparameter zugreifen.

Die Übernahme verfolgt deshalb das Ziel, die in Katalon verteilten Abhängigkeiten in eine offene und nachvollziehbare Zielstruktur zu überführen, ohne die semantische Bedeutung der Tests zu verlieren. Damit wird sichergestellt, dass nicht nur einzelner Code migriert wird, sondern ein konsistentes Testsystem entsteht, das im neuen Ökosystem unmittelbar weiterentwickelt und ausgeführt werden kann.

== Limitierungen der Migrationspipeline <sec-limitierungen>

Die Migrationspipeline ist darauf ausgelegt, die Kernfunktionen eines Katalon Projektes zu erkennen und in eine neue Struktur zu transformieren. Sie ist jedoch nicht in der Lage, alle möglichen Katalon-Funktionen und -Szenarien abzudecken. Insbesondere eigens geschriebene Custom Keywords, plattformspezifische Erweiterungen oder stark verschachtelte Testlogiken können zu Problemen führen. Auch Kommentare werden wegen geringer Relevanz vorerst vorweggelassen. Die Pipeline konzentriert sich auf die häufigsten Anwendungsfälle und bietet eine solide Grundlage für die Migration, erfordert jedoch möglicherweise manuelle Anpassungen für spezielle Anforderungen. Das Schreiben von Regex-basierter Übersetzung dieser komplexen Strukturen ist nicht unmöglich, wie andere Transpiler zeigen, doch für den Rahmen der ursprünglichen Aufgabe wäre dies zu zeitaufwändig gewesen.

= Implementierung <kap-implementierung> 

Dieses Kapitel beschreibt die technische Umsetzung des Migrationswerkzeugs: seine Ordnerstruktur, die Trennung zwischen Migrations- und Laufzeitcode sowie die Aufgaben der einzelnen Pipeline-Module.

== Techstack <sec-techstack>

=== Python <subsec-techstack-python>

Die grundlegende Programmiersprache des Migrators ist Python. Die Wahl fiel auf Python, weil sich die Sprache durch eine vergleichsweise geringe Syntaxkomplexität, gute Lesbarkeit und eine breite Unterstützung für Dateiverarbeitung und Texttransformation auszeichnet. Diese Eigenschaften sind für einen Prototypen geeignet, der große Mengen strukturierter Eingabedaten analysieren, transformieren und in neue Quelltexte überführen soll.

=== Selenium und Pytest <subsec-techstack-selenium-pytest>

@selenium ist ein etabliertes und weit verbreitetes Open-Source-Framework für Webbrowser-Automatisierung, das eine Vielzahl von Browsern und Plattformen unterstützt. Es bietet eine robuste API, die es ermöglicht, Webanwendungen zu steuern und zu testen. @pytest ist ein weiteres Open-Source-Framework, das für seine einfache Syntax, Flexibilität und umfangreiche Funktionalität bekannt ist. Es unterstützt die Erstellung von Testfällen, Test-Suites und bietet eine Vielzahl von Plugins zur Erweiterung der Funktionalität. Zusammen bilden sie einen vielseitigen und sehr praktikablen Techstack für die Testautomatisierung.
@selenium ist ein etabliertes und weit verbreitetes Open-Source-Framework für Webbrowser-Automatisierung, das eine Vielzahl von Browsern und Plattformen unterstützt. Es bietet eine robuste API, die es ermöglicht, Webanwendungen zu steuern und zu testen. @pytest ist ein weiteres Open-Source-Framework, das für seine einfache Syntax, Flexibilität und umfangreiche Funktionalität bekannt ist. Es unterstützt die Erstellung von Testfällen, Test-Suites und bietet eine Vielzahl von Plugins zur Erweiterung der Funktionalität. Zusammen bilden beide Werkzeuge einen praxistauglichen und im Open-Source-Umfeld etablierten Techstack für die Testautomatisierung.

=== Git als Versionierung und GitHub <subsec-techstack-git-github>

Zur Versionierung des Quellcodes wird Git verwendet. Das Versionskontrollsystem ermöglicht eine nachvollziehbare Entwicklung des Tools, da Änderungen historisiert, verglichen und bei Bedarf auf frühere Stände zurückgeführt werden können. Die Anbindung an @github erleichtert dazu die zentrale Ablage des Quellcodes und die dokumentierte Weiterentwicklung des Projekts.

== Projektstruktur des Migrators <sec-projektstruktur-migrator>
Die folgende Übersicht zeigt die relevante Projektstruktur des Migrators auf Wurzelebene. Der Thesis-Ordner wird dabei bewusst ausgeblendet, damit die technische Arbeitsstruktur des Migrationstools im Fokus bleibt:

#figure(
    ```
  katalon-test-migrator/
  ├── main.py
  ├── README.md
  ├── pyrightconfig.json
  ├── .gitignore
  └── src/
    ├── pipeline/
    │   ├── test_script_scanner.py
    │   ├── test_transpiler.py
    │   ├── test_assembler.py
    │   ├── object_repo_converter.py
    │   ├── global_vars_generator.py
    │   ├── variables_extractor.py
    │   ├── copy_runtime_files.py
    │   └── __init__.py
    ├── runtime/
    │   ├── base_test.py.template
    │   ├── katalon_helpers.py.template
    │   └── __init__.py
    └── utils/
      ├── file_utils.py
      ├── string_utils.py
      └── xml_utils.py
    ```,
  caption: [Projektstruktur des Migrationstools auf "root"-Ebene (ohne Thesis-Ordner & @ci[CI]-Pipeline) mit Trennung zwischen Steuerlogik, Konfigurationsdateien und Migrationsmodulen.],
)<fig-migrator-structure>

Die Struktur trennt Steuerlogik und Migrationsmodule klar voneinander. In der Projektwurzel orchestriert `main.py` den Gesamtablauf, während `README.md` die Ausführung dokumentiert. Im Ordner `src/` liegen die funktionalen Bausteine: `pipeline/` enthält die Transformationsschritte, `runtime/` die als Templates vorliegenden Laufzeithelfer für das Zielprojekt und `utils/` gemeinsam genutzte Hilfsfunktionen. Diese Aufteilung reduziert Kopplungen zwischen den Modulen und erleichtert die gezielte Erweiterung einzelner Pipeline-Bausteine.

== Umsetzung der Migrationspipeline <sec-implementierung-migrationspipeline>

Die Migrationspipeline besteht aus sieben spezialisierten Modulen. `main.py` ruft die steuernden Funktionen auf, die die Module in der Pipeline orchestrieren. Jedes Modul übernimmt einen klar abgegrenzten Teilschritt und überführt die Katalon-Struktur dadurch kontrolliert in die Zielumgebung.

Zur Robustheit der Pipeline werden fehlerhafte oder nicht eindeutig transformierbare Testskripte nicht verworfen, sondern separat in `src/unreadable_tests/` abgelegt. Dadurch bleibt der automatische Durchlauf stabil, während problematische Fälle gezielt manuell nachbearbeitet werden können.

*`test_script_scanner.py`* bildet den Einstiegspunkt der Pipeline. Das Modul durchläuft rekursiv den `Scripts/`-Ordner des Katalon-Projekts, filtert `.groovy`-Dateien und verteilt jede Datei an `test_transpiler.py` und `test_assembler.py`. Dabei wird die Katalon-Ordnerstruktur in `src/tests/` gespiegelt. Nicht vollständig übersetzbare Tests werden in `src/unreadable_tests/` abgelegt.

*`test_transpiler.py`* führt die syntaktische Transformation durch. Es wendet die in @table-regex dokumentierten @regex Muster auf den gescannten Groovy-Code an, erkennt Katalon-Methodenaufrufe und überführt sie schrittweise in Python-Äquivalente. Das Ergebnis ist eine Liste transformierter Codezeilen.

*`test_assembler.py`* baut aus den transpilierten Zeilen eine vollständige Python-Pytest-Testklasse. Das Skript ergänzt die benötigten Imports, erzeugt eine Klassenstruktur mit `BaseTest`-Vererbung im Constructor und kapselt die Testlogik in einer `test_TESTNAME`-Methode.

*`object_repo_converter.py`* konvertiert, mit Hilfe von `xml_utils.py`, alle `.rs`-Dateien im `Object Repository/`-Ordner von XML nach JSON. Die interne `WebElementEntity`-Struktur bleibt erhalten; lediglich das Dateiformat ändert sich. Das Ergebnis wird unter `src/object_repository/` abgelegt.

*`global_vars_generator.py`* liest im Quellverzeichnis `Profiles/default.glbl` (XML mit `GlobalVariableEntity`-Einträgen) und erzeugt daraus `src/profiles/global_variables.py`, also eine Python-Klasse `GlobalVariables` mit Klassenvariablen für globale Projektwerte.

*`variables_extractor.py`* liest die `.tc`-Metadateien der Test Cases und extrahiert testeigene Variablen. Für jeden Test mit Variablen wird eine eigene Python-Datei unter `src/variables/` erzeugt, die die Variablen als Python-Klasse bereitstellt.

*`copy_runtime_files.py`* schließt die Migration ab. Dieses Skript kopiert `base_test.py.template` und `katalon_helpers.py.template` in `src/runtime/` des Zielprojekts entfernt die Endung `.template` und erzeugt die Konfigurationsdateien `pytest.ini`, `requirements.txt`, `.gitignore` und `README.md` in der Projektwurzel.

=== Transpilation der Test Cases <subsec-transpilation-test-cases-impl>

Die eigentliche Testtranspilation ist der Kern der Implementierung. Sie beginnt mit dem Einlesen der Groovy-Datei, entfernt nicht relevante Bestandteile wie Kommentare und Importzeilen und reduziert den Code anschließend auf die testrelevanten `WebUI.`-Zeilen. Diese Zeilen werden @parsing[geparst], in einzelne Bestandteile zerlegt und Schritt für Schritt in Python-Strukturen überführt. Dadurch entsteht aus der ursprünglichen Katalon-Logik ein ausführbarer Test, dessen Aufbau dem ursprünglichen Verhalten entspricht.

==== Semantische Transformation: Katalon @test-object zu @selenium Locators <subsec-semantische-transformation>

Das Katalon @object-repository speichert Testobjekte als .rs-Dateien, die im Inneren umbenannte XML-Dateien mit einer `WebElementEntity`-Struktur sind. Jede Datei beschreibt ein @html Element über eine `selectorCollection`, die eine oder mehrere Lokalisierungsstrategien als @key-value-paare[Key-Value-Paare] enthält (z. B. BASIC/XPath oder CSS), sowie ein `selectorMethod`-Feld, das die bevorzugte Strategie bestimmt.

Während der @build-time konvertiert `object_repo_converter.py` diese XML-Dateien in das JSON-Format. Die interne Struktur bleibt dabei vollständig erhalten und nur das Dateiformat ändert sich. Das folgende Beispiel zeigt die Transformation der Objektdatei `view_all_users_btn`:

#figure(
  grid(
    rows: 2,
    row-gutter: 1.5em,
    ```xml
    <!-- Object Repository/All_Users/view_all_users_btn.rs (Katalon XML) -->
    <WebElementEntity>
      <name>view_all_users_btn</name>
      <selectorCollection>
        <entry>
          <key>BASIC</key>
          <value>//*[@id = 'hero-cta']</value>
        </entry>
      </selectorCollection>
      <selectorMethod>BASIC</selectorMethod>
    </WebElementEntity>
    ```,
    ```json
    // src/object_repository/All_Users/view_all_users_btn.json (generiertes JSON)
    {
      "WebElementEntity": {
        "name": "view_all_users_btn",
        "selectorCollection": {
          "entry": { "key": "BASIC", "value": "//*[@id = 'hero-cta']" }
        },
        "selectorMethod": "BASIC"
      }
    }
    ```
  ),
  caption: [Beispielhafte Transformation eines Katalon-Testobjekts von einer XML-basierten `.rs`-Datei in die entsprechende JSON-Darstellung im Zielprojekt.],
) <fig-object-repository-json-transformation>

Zur @runtime im Zielprojekt liest die Hilfsfunktion `find_katalon_test_object()` in `katalon_helpers.py` die JSON-Datei ein, liest `selectorMethod` aus und sucht den passenden Wert aus der `selectorCollection`. Anschließend lokalisiert sie das Element über die @api von @selenium. Im Fall von `CSS` mit `By.CSS_SELECTOR`, bei allen anderen Strategien, einschließlich `BASIC`, mit `By.XPATH`. Der Aufruf im generierten Testcode bleibt dabei strukturell identisch zum Katalon-Original:

#figure(
  grid(
    rows: 2,
    row-gutter: 1.5em,
    ```groovy
    // Katalon (Groovy):
    WebUI.click(findTestObject('All_Users/view_all_users_btn'))
    ``` ,
    ```python
    # Generierter Python-Code:
    kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
    ```
  ),
  caption: [Beispielhafte Abbildung eines Katalon-`findTestObject()`-Aufrufs auf den entsprechenden Selenium-basierten Laufzeithelfer im generierten Python-Test.],
) <fig-find-test-object-transformation>

Der generierte Testcode hat selbst keine Kenntnis über die verwendete Lokalisierungsstrategie, sondern greift nur auf den Laufzeithelfer `find_katalon_test_object()` zu und übergibt einen Pfad. Die Bindung zwischen Testlogik und Element-Selektor bleibt erhalten, ohne dass sich die Testeingabe ändert.

==== Syntaktische Transformation: Groovy zu Python <subsec-syntaktische-transformation>

Die Groovy-Syntax wird durch Regex-gestützte Mustererkennung schrittweise in Python-Syntax überführt. Dabei werden die ursprünglichen Katalon-Aufrufe nicht nur syntaktisch ersetzt, sondern in eine Form überführt, die innerhalb der generierten Pytest-Struktur unmittelbar ausführbar ist. Die folgenden Zeilen zeigen beispielhaft, wie typische WebUI-Aufrufe, Objektzugriffe und Variablenreferenzen transformiert werden.

#figure(
  align(left)[
    #grid(
      rows: 2,
      row-gutter: 1.5em,
      ```groovy
      WebUI.verifyTextPresent('View All Users', false)
      WebUI.click(findTestObject('All_Users/view_all_users_btn'))
      WebUI.setText(findTestObject('All_Users/search_input'), david)
      WebUI.verifyTextPresent(GlobalVariable.user4name, false)
      ``` ,
      ```python
      assert 'View All Users' in self.driver.page_source
      kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
      kh.find_katalon_test_object(self.driver, 'All_Users/search_input').clear()
      kh.find_katalon_test_object(self.driver, 'All_Users/search_input').send_keys(variables.david)
      assert GlobalVariable.USER4NAME in self.driver.page_source
      ```
    )
  ],
  caption: [Beispielhafte syntaktische Transformation mehrerer Katalon-WebUI-Aufrufe in ausführbaren Python-Testcode innerhalb der generierten Pytest-Struktur.],
) <fig-groovy-python-syntax-transformation>

Das Beispiel zeigt drei typische Transformationsarten: @assertions[Assertions] auf Seiteninhalte werden in Python-Assertions überführt, `findTestObject()`-Aufrufe werden mithilfe der Laufzeithelfer zur Lokalisierung der Zielobjekte abgebildet, und Variablenzugriffe werden an die im Zielprojekt erzeugten Python-Strukturen angebunden. Besonders relevant ist dabei, dass Pfadangaben und Objektbezeichner nicht verworfen, sondern in ein neues Zugriffsschema übertragen werden. Dadurch bleibt die Bindung zwischen Testlogik und ergänzenden Strukturen auch nach der Migration erhalten.

===== Regex-basierte Transformation <subsubsec-regex-basierte-transformation>

Die Pipeline nutzt mehrere aufeinander abgestimmte Muster, um Groovy-Testcode schrittweise in ein ausführbares Python-Testformat zu überführen.

Im Sinne des Diagramms beginnt dieser Ablauf mit dem Einlesen der ursprünglichen Groovy-Datei. Danach werden Kommentare und Importzeilen entfernt, sodass nur der für die Transpilation relevante Code verbleibt. Aus diesem gefilterten Code werden im nächsten Schritt die eigentlichen Testzeilen extrahiert. Diese Testzeilen werden anschließend geparst und in ihre Grundbestandteile wie Klassenbezug, Methodenname und Parameter zerlegt. Auf dieser Grundlage folgt die Transformation erkannter Methoden und Parameter in entsprechende Konstrukte der Zielumgebung. Aus den transformierten Bausteinen wird danach Python-Code erzeugt, der die ursprüngliche Testlogik in neuer Form abbildet. Abschließend werden die generierten Fragmente zu einem vollständigen Test zusammengesetzt.

Die folgenden Abbildungen veranschaulichen exemplarisch, wie einzelne Muster im @parsing[Parsing] eingesetzt werden. Gezeigt wird insbesondere, wie relevante Testzeilen zunächst isoliert und anschließend `findTestObject()`-Aufrufe als eigenständige Parameterbestandteile erkannt werden. Dadurch wird sichtbar, dass die Regex-Muster nicht unabhängig voneinander arbeiten, sondern eine aufeinander aufbauende Verarbeitungskette bilden.
#figure(
    image("img/Regex/split_katalon_lines_vert.png", width: 100%),
  caption: [Durch das `katalon_lines_pattern`-Muster werden aus einem Block aus Katalon Zeilen, drei getrennte Regex-Matches mit jeweils drei Gruppen für Klasse, Methode und Parameter extrahiert (Visualisierung und Validierung mit Regex101).],
)<fig-split-katalon-lines>

#figure(
    image("img/Regex/get_fto_as_param_vert.png", width: 100%),
  caption: [Das `fto_as_param_pat`-Muster erkennt in der @parsing[Parsing-Phase] die findTestObject()-Methode als ersten Parameter, falls ein Komma folgt und ermöglicht es diese zu trennen (Visualisierung und Validierung mit Regex101).],
)<fig-get-fto-as-param>

#figure(
    image("img/Regex/get_fto_vert.png", width: 100%),
  caption: [Das `fto_param_str_pattern`-Muster extrahiert die findTestObject()-Methode mit dem String-Argument, das für die Transformation benötigt wird (Visualisierung und Validierung mit Regex101).],
)<fig-get-fto>

Eine vollständige Übersicht der verwendeten @regex Muster befindet sich im Anhang in Kapitel @anh-regex-muster. Dort sind die wichtigsten Muster, ihre regulären Ausdrücke und ihr jeweiliger Zweck zusammengefasst.

== Grenzen der Implementierung <sec-implementierung-grenzen>

Die implementierte Pipeline ist auf die im Projekt beobachteten Standardfälle ausgerichtet. Sie verarbeitet die typischen Katalon-Strukturen zuverlässig, stößt aber bei von der Norm abweichenden Groovy-Konstrukten, ungewöhnlich verschachtelten Testabläufen oder projektindividuellen Custom Keywords an Grenzen. Solche Fälle erfordern entweder ergänzende Regeln oder eine manuelle Nacharbeit im Zielprojekt. Damit bleibt die Implementierung bewusst fokussiert auf die häufigsten Migrationspfade, anstatt jede theoretisch mögliche Katalon-Struktur vollständig abzubilden.

Nach der Darstellung der Implementierungsdetails wird im folgenden Kapitel überprüft, in welchem Umfang die Pipeline die erwarteten Migrationsziele im Beispielprojekt tatsächlich erreicht.

= Evaluation <kap-evaluation>

Zur Evaluation des Migrationswerkzeugs wurde das Katalon-Beispielprojekt `sample-website-katalon-tests` verwendet. Es enthält reale End-to-End-Tests, ein Object Repository, zwei globale Variablen-Profile und eine eingebundene CSV-Datendatei. Die Migration wurde auf einem Windows-11-Rechner mit Python 3.13.0 und pytest 8.4.1 durchgeführt.

== Evaluationskriterien <sec-evaluationskriterien>

Die Bewertung des Prototyps orientiert sich bewusst an den Basisfunktionen der Migrationspipeline und den in dieser Arbeit formulierten Kernzielen.

Im Migrationsergebnis wird beobachtet welcher Anteil der relevanten Katalon-Dateien erfolgreich in die Zielstruktur überführt wurde. Zudem wird auch der Automatisierungsgrad bewertet. Dabei wird erfasst, welche Transformationsschritte ohne manuelle Eingriffe durchlaufen und welche Artefakte im automatischen Durchlauf vollständig erzeugt werden.

Bei der Prüfung der strukturellen Integrität wird untersucht, ob das erzeugte Python-Projekt die ursprüngliche Testlogik in vergleichbarer Weise ausführt und ob die erwarteten Testfälle korrekt bereitgestellt werden.

Anschließend wird die Codequalität bemessen. Dazu zählen der komplette Syntax, nicht oder nur teilweise übersetzte Fälle und deren Ursachen.

Als letztes wird der Aufwand zwischen manuellem Migrieren und der Nutzung der Migrationspipeline verglichen.

== Migrationsergebnis <sec-migrationsergebnis>

Die Ausführung des Migrators (`python main.py`) liefert folgendes Ergebnis:

#figure(
  table(
    columns: (3fr, 1fr, 2fr),
    inset: 8pt,
    align: (left, center, left),
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 { rgb("#e8f4f8") },
    [*Komponente*], [*Anzahl*], [*Beschreibung*],
    [Übersetzte Testskripte], [7], [7 von 10 .groovy-Dateien aus Scripts/ erfolgreich übersetzt],
    [Nicht übersetzbare Tests], [3], [3 Tests konnten nicht automatisch übersetzt werden],
    [Object Repository Dateien], [10], [Alle .rs XML-Dateien zu JSON konvertiert],
    [Variablen-Dateien], [1], [Testeigene Variablen aus .tc-Metadateien extrahiert],
    [Runtime-Dateien], [2], [base\_test.py und katalon\_helpers.py ins Ziel kopiert],
    [Konfigurations-Dateien], [4], [pytest.ini, requirements.txt, .gitignore, README.md],
    [Datendateien], [1], [users.csv direkt ins Ziel-Projekt kopiert],
  ),
  caption: [Migrationsergebnis: Der Großteil der Komponenten wurde automatisch überführt; bei den Testskripten verbleibt ein Rest von 3 nicht übersetzten Fällen.],
) <table-migration-result>

Von 10 vorhandenen Testskripten wurden 7 automatisch übersetzt, während 3 Fälle fehlschlugen. Damit liegt die Übersetzungsabdeckung für Testskripte bei *70%*, mit einem unübersetzen Rest von *30%*.

#figure(
  image("img/Evaluation/run_migration.png", width: 100%),
  caption: [Konsolenausschnitt der Migration mit 7 erfolgreichen und 3 fehlgeschlagenen Testübersetzungen.],
) <fig-eval-run-migration>

== Strukturelle Integrität <sec-strukturelle-integrität>

Hier wird geprüft ob das Zielprojekt vollständig importierbar ist und die erwarteten Testfälle korrekt bereitgestellt werden.

Nach der Migration wurde das Python-Projekt mit `pytest --collect-only` geprüft. Eine Pytest-native Funktion, die alle Tests durchsucht und den Syntax kontrolliert. Pytest konnte alle generierten Dateien fehlerfrei importieren und die 7 automatisch erzeugten Tests entdecken.

#figure(
  text(size: 0.9em)[
    ```
    collected 7 items

    src/tests/Menus/test_navigation_bar.py::Test_navigation_bar::test_navigation_bar
    src/tests/Users/test_filter_for_admins.py::Test_filter_for_admins::test_filter_for_admins
    src/tests/Users/test_search_for_david_kim.py::Test_search_for_david_kim::test_search_for_david_kim
    src/tests/Users/test_show_active_viewers.py::Test_show_active_viewers::test_show_active_viewers
    src/tests/Users/test_show_editors.py::Test_show_editors::test_show_editors
    src/tests/Users/test_verify_users_controls_visible.py::Test_verify_users_controls_visible::test_verify_users_controls_visible
    src/tests/Util/test_login.py::Test_login::test_login

    ========================= 7 tests collected in 0.46s =========================
    ```
  ],
  caption: [Konsolenausgabe von `pytest --collect-only`, die zeigt, dass alle 7 automatisch erzeugten Python-Tests fehlerfrei erkannt werden.],
) <fig-pytest-collect-only>

Die folgenden Screenshots zeigen die Testausführung aller Tests in Katalon Studio, mit 10 von 10 Erfolgen und die Testausführung im generierten Python-Projekt, mit 7 von 7 Erfolgen.

#figure(
  grid(
    rows: 2,
    gutter: 1em,
    image("img/Evaluation/katalon_all_tests.png"),
    image("img/Evaluation/python_all_tests.png"),
  ),
  caption: [Vergleich der Testausführung: oben alle Tests im Katalon-Ausgangsprojekt, unten die Ausführung im generierten Python-Projekt. Die Abweichung entspricht den 3 nicht automatisch übersetzten Fällen.],
) <fig-eval-katalon-python-all-tests>

== Codequalität: Vorher-Nachher-Vergleich <sec-codequalität-vergleich>

Am Beispiel des Tests `filter_for_admins` lässt sich der Unterschied zwischen ursprünglichem Katalon-Skript und generiertem Python-Test visuell nachvollziehen:

#figure(
  grid(
    rows: 2,
    gutter: 1em,
    image("img/Katalon Studio/filter_for_admins_script.png"),
    image("img/Python Projekt/filter_for_admins.png"),
  ),
  caption: [Vergleich des Tests `filter_for_admins`: oben das ursprüngliche Katalon-Skript in Groovy, unten der daraus generierte Python-Test im Zielprojekt.],
) <fig-filter-for-admins-code-comparison>

Der Boilerplate-Anteil sinkt von 18 auf 7 Importzeilen. Die Testlogik ist in standardmäßigem Python mit pytest-Konventionen formuliert und benötigt keine proprietären Katalon-Keywords mehr.

Im derzeitigen Stand der Pipeline werden alle Kommentare des ursprünglichen Codes aus Gründen der Komplexität entfernt. 

== Aufwandsvergleich <sec-aufwandsvergleich>
//TODO: Quantitative Arbeitszeit mit einbeziehen, was wenn ein Test 500 Zeilen lang ist usw.

Die automatisierte Migration des Beispielprojekts dauerte unter einer Sekunde und überführte 7 von 10 Testskripten direkt in die Zielstruktur. Für die verbleibenden 3 fehlgeschlagenen Fälle ist eine manuelle Nacharbeit erforderlich. Eine vollständig manuelle Migration hätte dagegen zunächst die in Kapitel @sec-verschachtelungen-katalon beschriebenen proprietären Verschachtelungen zwischen Skripten, Test Cases, Objektdefinitionen, Profilen und Testdaten auflösen müssen, bevor anschließend 10 Groovy-Testskripte, 10 XML-basierte Objektdateien sowie die zugehörigen Variablen- und Konfigurationsstrukturen einzeln in Python überführt werden könnten. Dass ein solcher manueller Aufwand mit wachsender Komplexität schnell ansteigt, deckt sich mit der in der Testliteratur beschriebenen Beobachtung, dass manuelle Prüf- und Transformationsaufgaben bei steigender Fallzahl und Kombinationsvielfalt stark skalieren@nist_sp800_142[S. 34, S. 37].

Für das hier betrachtete Beispielprojekt ist deshalb selbst bei konservativer Projektschätzung von einem manuellen Aufwand im hohen einstelligen bis zweistelligen Stundenbereich auszugehen. Die Teilautomatisierung reduziert diesen Aufwand deutlich, lässt aber für die 3 nicht übersetzten Testfälle weiterhin gezielte Transformations- und Prüfaufgaben offen. Mit wachsender Testanzahl skaliert der Migrator im Wesentlichen linear, während der manuelle Aufwand durch zusätzliche Querbezüge zwischen Variablen, Objekten und Datenstrukturen überproportional zunimmt.

//= Diskussion <kap-diskussion>

// TODO

= Fazit und Ausblick <kap-fazit-ausblick>

Die Arbeit beschreibt die Entwicklung eines Migrationswerkzeugs, das Katalon-Projekte in Python-Projekte mit Selenium und Pytest überführt. Ziel war es, das Tool zu entwerfen, zu implementieren und zu evaluieren. Dieses Ziel ergab sich aus der Aufgabe, eine umfangreiche bestehende Katalon-Projektbasis aus ihrer proprietären Umgebung in eine offene, erweiterbare und kostenlos nutzbare Zielumgebung zu überführen.

Die Ausführung des Prototyps ergibt ein Python-Projekt, das den Großteil der eingeführten Testlogik samt umgebender Testartefakte enthält. Im Beispielprojekt werden 70% der Testskripte sowie alle dazugehörigen Strukturen wie Test Objects, Testdaten und Variablen fehlerfrei automatisch transformiert. Das erzeugte Projekt ist nach minimalem Setup direkt ausführbar. Die restlichen 30% müssen jedoch manuell nachbearbeitet werden, um vollständig nutzbar zu sein.

In der Evaluation werden insbesondere die strukturelle und syntaktische Integrität überprüft. Zugleich macht sie deutlich, dass nicht alle Fälle übersetzt werden. Eigens geschriebene Logik, Kommentare und komplexere Verschachtelungen führen schnell zur Unlesbarkeit des Testskripts. Demnach ist das Migrationstool kein vollständiger Ersatz für eine manuelle Migration, aber eine wirksame Grundlage zur deutlichen Reduktion des Aufwands.

Insgesamt zeigt die Arbeit, dass die Migration von Katalon-Projekten in eine Python-Testumgebung mit Selenium und Pytest machbar ist, auch wenn nicht alle Fälle automatisch abgedeckt werden können.

Für die Weiterentwicklung des Tools ergeben sich drei zentrale Richtungen. Erstens kann die Abdeckung erhöht werden, indem weitere Katalon Studio-interne Keyword-Methoden in die Liste der übersetzbaren Methoden aufgenommen werden. Zweitens können die Regex-Muster und Parsing-Regeln erweitert werden, um Kommentare, tiefere Verschachtelungen in Parameterlisten sowie eigens erstellte Variablen, Methoden und Klassen robuster zu verarbeiten. Auch Programmierschleifen und weitere Code-Konstrukte könnten in die Übersetzung aufgenommen werden. Dazu kann die Fehlerklassifikation und -behandlung verbessert werden, etwa durch eine Kategorisierung nicht übersetzter Skripte und eine detailliertere Fehlerausgabe, um die manuelle Nacharbeit gezielter und schneller durchführen zu können.

#pagebreak()
= Anhang <kap-anhang>

#include "attachments/regex_muster.typ"
#include "attachments/katalon_structure.typ"
