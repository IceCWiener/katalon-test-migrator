//#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "glossarium/glossarium.typ": make-glossary, register-glossary, print-glossary, gls, glspl

// Helpers
#let buildMainHeader(mainHeadingContent) = {
  [
    #align(center, smallcaps(mainHeadingContent))
    #line(length: 100%)
  ]
}

#let buildSecondaryHeader(mainHeadingContent, secondaryHeadingContent) = {
  [
    #smallcaps(mainHeadingContent)  #h(1fr)  #emph(secondaryHeadingContent) 
    #line(length: 100%)
  ]
}

// To know if the secondary heading appears after the main heading
#let isAfter(secondaryHeading, mainHeading) = {
  let secHeadPos = secondaryHeading.location().position()
  let mainHeadPos = mainHeading.location().position()
  if (secHeadPos.at("page") > mainHeadPos.at("page")) {
    return true
  }
  if (secHeadPos.at("page") == mainHeadPos.at("page")) {
    return secHeadPos.at("y") > mainHeadPos.at("y")
  }
  return false
}


#let getHeader(title: str) = {
  context {
    let loc = here()
    // Find if there is a level 1 heading on the current page
    let headingsOnPage = query(heading.where(level: 1)).filter(headIt => {
      headIt.location().page() == loc.page()
    })
    let currentPageHeading = if headingsOnPage.len() > 0 { headingsOnPage.first() } else { none }
    
    if currentPageHeading != none {
      return buildMainHeader(currentPageHeading.body)
    }
    
    // If no heading on current page, find the last previous level 1 heading
    let allHeadings = query(heading.where(level: 1)).filter(headIt => {
      headIt.location().page() < loc.page()
    })
    let lastMainHeading = if allHeadings.len() > 0 { allHeadings.last() } else { none }
    
    if lastMainHeading != none {
      return buildMainHeader(lastMainHeading.body)
    }
    
    return []
  }
}

// Page templates

#let coverPage(
  thesisKind: "",
  author: "",
  title: "",
  departmentEN: "",
  departmentDE: "",
  facultyEN: "",
  facultyDE: "",
  coverPageColour: "#003CA0"
) = {
  // No page number
  set page(numbering: (..nums) => "")

  // Logo
  place(
    top+right,
    image("configuration/HTW_CMYK_noborders.png", width: 6cm)
  )

  // Thesis kind
  place(
    top + left,
    dx: 30mm, dy: 95mm,
    block(
      [
        #text(thesisKind, size: 22pt)
      ]
    )
  )

  // Author
  place(
    top + left,
    dx: 30mm, dy: 105mm,
    block(
      align(right)[#text(author, size: 14pt)]
    )
  )


  // Title
  place(
    top + left,
    dx: 30mm, dy: 125mm,
    block(
      [
        #block(align(left)[#text(title, size: 28pt, hyphenate: false)])
        #line(
          start:  (-10pt, 6pt), 
          end: (10mm, 6pt), 
          stroke: 1mm + rgb(coverPageColour),
        )
    ],
      width: 210mm-30mm-30mm-20mm,
    )
  )

  // English thesis just in english
  if departmentDE == "" [
    // English version
    #place(
      dx: 30mm,
      dy: 150mm,
      align(left)[
        _#facultyFullEN_ \
        Department _#departmentFullEN_
      ]
    )
  ] else [
    // German version
    #place(
      dx: 30mm,
      dy: 170mm,
      align(left)[
        #upper[#facultyDE] \
        Department #departmentDE
      ]
    )
    // English version alongside
    #place(
      dx: 30mm,
      dy: 185mm,
      align(left)[
        #facultyEN \
        Department #departmentEN
      ]
    )
  ]

  // HTW name in bottom right corner
  place(
    bottom + right,
    dx: 00mm, dy: -10mm,
    block(
      align(left)[
        #line(
          start:  (00pt, 6pt), 
          end: (10mm, 6pt), 
          stroke: 1mm + rgb(coverPageColour),
        )
        #upper[Hochschule für Technik\
        und Wirtschaft Berlin]\
        Berlin University of Applied Sciences
      ]
    )
  )

  pagebreak()
}
#let titlePage(
  author: "",
  title: "",
  thesisKindDE: "",
  thesisExaminationDE: "",
  thesisKindEN: "",
  thesisExaminationEN: "",
  studyCourseName: "",
  department: "",
  faculty: "",
  university: "",
  firstSupervisor: "",
  secondSupervisor: "",
  language: "en",
  submissionDate: ""
) = {
  // No page number
  set page(numbering: (..nums) => "")

  v(3cm)

  set text(size: 11pt, font: "Arial")
  set par(leading: 20pt)
  align(center)[#author]

  v(1.5cm)

  set text(size: 18pt)
  align(center)[#title]

  set text(size: 11pt, font: "Arial")
  set par(leading: 9pt)
  place(
    dx: 15mm,
    dy: 120mm,
    align(left)[
    #if language == "en" [
      #thesisKindEN submitted for examination in #thesisExaminationEN \
      in the study course _#studyCourseName _ \
      at the #department \
      at the #faculty \
      at #university \

      Supervisor: #firstSupervisor \
      Second Supervisor: #secondSupervisor

      Submitted on: #submissionDate
    ] else [
      #thesisKindDE eingereicht im Rahmen der #thesisExaminationDE \
      im Studiengang _#studyCourseName _ \
      im #department \
      der #faculty \
      der #university \
      \
      Betreuender Prüfer: #firstSupervisor \
      Zweitgutachter: #secondSupervisor \
      \
      Eingereicht am: #submissionDate
    ]
    
  ])

  pagebreak(weak: true)
}

#let abstractPage(
  author: "",
  titleDE: "",
  keyWordsDE: "",
  abstractDE: "",
  titleEN: "",
  keyWordsEN: "",
  abstractEN: ""
) = {
  set text(size: 11pt, font: "Arial")
  set par(leading: 9pt, justify: true)

  v(1.5cm)

  text(weight: "bold")[#author]
  
  v(0.3cm)
  
  text(weight: "bold")[Thema der Arbeit]
  align(left)[#titleDE]
  
  v(0.3cm)
  
  //text(weight: "bold")[Stichworte]
  align(left)[#keyWordsDE]
  
  v(0.3cm)
  
  text(weight: "bold")[Kurzzusammenfassung]
  align(left)[#abstractDE]

  v(1.0cm)
  
  pagebreak(weak: true)
  
  // Repeat for English

  // v(1.5cm)
  
  // text(weight: "bold")[#author]
  
  // v(0.3cm)
  
  // text(weight: "bold")[Title of Thesis]
  // align(left)[#titleEN]
  
  // v(0.3cm)
  
  // text(weight: "bold")[Keywords]
  // align(left)[#keyWordsEN]
  
  // v(0.3cm)
  
  // text(weight: "bold")[Abstract]
  // align(left)[#abstractEN]

  // pagebreak(weak: true)
}

// HACK: Am Ende der Arbeit ist die Selbstständigkeitserklärung, die so auch ins Inhaltsverzeichnis gehört. Sie selbst hat jedoch eine andere Überschrift.
#let divergentHeadingAppearanceState = state("", false)
#let divergentHeading(outlineAppearance, heading) = context if divergentHeadingAppearanceState.get() {
  outlineAppearance
} else {
  heading
}

#let statement() = {

  set text(size: 11pt, font: "Arial")
  set par(leading: 9pt, justify: true)

  v(1.5cm)

  set heading(numbering: none)
  [= #divergentHeading[Selbstständigkeitserklärung][Erklärung zur selbstständigen Bearbeitung] ]
    

  v(0.3cm)

  align(left)[
    Ich erkläre hiermit, dass
ich die vorliegende wissenschaftliche Arbeit selbständig und ohne unerlaubte Hilfe angefertigt habe,
ich andere als die angegebenen Quellen und Hilfsmittel nicht benutzt habe,
ich die den benutzten Quellen wörtlich oder inhaltlich entnommenen Stellen als solche kenntlich gemacht habe,
die Arbeit in gleicher oder ähnlicher Form noch keiner anderen Prüfbehörde vorgelegen hat.
  ]

  v(1.5cm)

  set grid.cell(inset: 1em)
  grid(
    columns: (1fr, 1fr, 2fr),
    stroke: (top: 0.6pt),
    gutter: 1em,
    align: center,
    "Ort", "Datum", "Unterschrift im Original"
  )

  pagebreak(weak: true)
}

// Glossary
#let entry-list = (
  // ── Abkürzungen ─────────────────────────────────────────────────
  (
    key: "ide",
    short: "IDE",
    long: "Integrated Development Environment",
    description: "Eine Software-Anwendung, die Entwicklern eine umfassende Umgebung für die Softwareentwicklung bietet. Typischerweise umfasst sie einen Code-Editor, Debugger, Build-Werkzeuge und oft eine grafische Projektansicht. Katalon Studio ist eine solche IDE, die speziell auf Testautomatisierung ausgelegt ist."
  ),
  (
    key: "key-value-paare",
    short: "Key-Value-Paare",
    description: "Eine Datenstruktur, in der Werte einem eindeutigen Schlüssel zugeordnet werden. In dieser Arbeit werden Selektoren und ihre zugehörigen Strategien häufig als Key-Value-Paare beschrieben."
  ),
  (
    key: "ui",
    short: "UI",
    long: "User Interface",
    description: "Die Benutzerschnittstelle einer Anwendung, über die Nutzer mit dem System interagieren. Im Kontext dieser Arbeit bezeichnet UI die grafische Oberfläche, die durch automatisierte Tests validiert wird."
  ),
  (
    key: "poc",
    short: "PoC",
    long: "Proof of Concept",
    description: "Ein Prototyp oder eine Machbarkeitsstudie, die zeigt, dass ein Konzept oder eine Idee praktisch umsetzbar ist. In dieser Arbeit bezeichnet PoC die erste Umsetzung eines Migrationsskripts zur Überprüfung der Machbarkeit."
  ),
  (
    key: "jvm",
    short: "JVM",
    long: "Java Virtual Machine",
    description: "Eine Laufzeitumgebung, die plattformunabhängige Ausführung von Java-Bytecode ermöglicht. Groovy, die Skriptsprache von Katalon Studio, läuft auf der JVM."
  ),
  (
    key: "ci",
    short: "CI",
    long: "Continuous Integration",
    description: "Ein Softwareentwicklungsprinzip, bei dem Code-Änderungen regelmäßig in ein gemeinsames Repository integriert und automatisch gebaut und getestet werden. Automatisierte Testsuiten sind ein zentrales Werkzeug im CI-Prozess."
  ),
  (
    key: "cli",
    short: "CLI",
    long: "Command Line Interface",
    description: "Eine textbasierte Benutzerschnittstelle, über die Nutzer Programme durch Eingabe von Befehlen steuern."
  ),
  (
    key: "rcp",
    short: "RCP",
    long: "Rich Client Platform",
    description: "Ein von Eclipse bereitgestelltes Framework zum Entwickeln modularer Desktop-Anwendungen auf Basis von Plug-ins."
  ),
  (
    key: "compiler",
    short: "Compiler",
    description: "Ein Programm, das Quellcode einer Programmiersprache analysiert und auf Fehler prüft oder in eine andere Form überführt. In dieser Arbeit bezeichnet Compiler den statischen Typ-Analysator Pyright, der Python-Dateien vor der Ausführung auf Typ- und Importfehler untersucht."
  ),
  (
    key: "interpreter",
    short: "Interpreter",
    description: "Ein Programm, das Quellcode zur Laufzeit schrittweise ausführt, ohne ihn vollständig vorab in Maschinencode zu übersetzen. Python wird typischerweise über einen Interpreter ausgeführt."
  ),
  (
    key: "python",
    short: "Python",
    description: "Eine weit verbreitete, interpretierte Programmiersprache mit klarer Syntax und großem Ökosystem. In dieser Arbeit dient Python als Zielsprache der Migration und als Grundlage für die Ausführung der generierten Selenium/Pytest-Tests."
  ),
  (
    key: "sut",
    short: "SUT",
    long: "System Under Test",
    description: "Das zu testende System — in dieser Arbeit die Webanwendung, auf die die automatisierten Selenium-Tests angewendet werden."
  ),
  (
    key: "api",
    short: "API",
    long: "Application Programming Interface",
    description: "Eine definierte Schnittstelle, über die Softwarekomponenten miteinander kommunizieren. Selenium stellt eine API bereit, über die Tests den Browser steuern."
  ),
  (
    key: "assertions",
    short: "Assertions",
    description: "Prüfausdrücke in Testcode, die erwarten, dass eine Bedingung wahr ist. Ist die Bedingung nicht erfüllt, schlägt der Test fehl und markiert die entsprechende Stelle als Fehler."
  ),
  (
    key: "framework",
    short: "Framework",
    description: "Ein wiederverwendbares Grundgerüst aus Bibliotheken, Regeln und Konventionen, das die Entwicklung einer bestimmten Art von Software strukturiert. In dieser Arbeit dienen Katalon und Selenium/Pytest als Frameworks für die Testautomatisierung."
  ),
  (
    key: "html",
    short: "HTML",
    long: "HyperText Markup Language",
    description: "Eine standardisierte Auszeichnungssprache zur Strukturierung von Webinhalten. HTML beschreibt den Aufbau von Elementen wie Formularen, Buttons, Tabellen und Textbereichen, auf die automatisierte UI-Tests zugreifen."
  ),
  (
    key: "xml",
    short: "XML",
    long: "Extensible Markup Language",
    description: "Ein textbasiertes, hierarchisches Datenformat zur strukturierten Beschreibung von Informationen. In dieser Arbeit werden mehrere Katalon-Dateitypen als XML interpretiert und in offene Zielformate überführt."
  ),
  (
    key: "regex",
    short: "Regex",
    long: "Regular Expression",
    description: "Ein formaler Ausdruck zur Beschreibung von Zeichenketten-Mustern. In dieser Arbeit werden Regular Expressions zur Transformation von Groovy-Syntax in Python-Syntax eingesetzt."
  ),
  (
    key: "parsing",
    short: "Parsing",
    description: "Der Prozess, bei dem Text oder Code in eine strukturierte Form überführt wird, sodass Bestandteile wie Klassen, Methoden und Parameter gezielt weiterverarbeitet werden können."
  ),
  (
    key: "repository",
    short: "Repository",
    description: "Ein versioniertes Archiv für Quellcode und zugehörige Dateien, typischerweise verwaltet mit einem Versionskontrollsystem wie Git. In dieser Arbeit bezeichnet Repository sowohl das Quell-Katalon-Projekt als auch das generierte Ziel-Selenium/Pytest-Projekt als eigenständige, versionierbare Einheiten."
  ),
  (
    key: "git",
    short: "Git",
    description: "Ein verteiltes Versionskontrollsystem zur Nachverfolgung von Änderungen an Quellcode und Dateien. Git ermöglicht unter anderem Commit-Historien, parallele Entwicklungszweige und das Zusammenführen von Änderungen."
  ),
  (
    key: "github",
    short: "GitHub",
    description: "Eine webbasierte Plattform zur Verwaltung von Git-Repositories mit Funktionen für Zusammenarbeit, Pull Requests, Issues und CI/CD-Integrationen."
  ),
  (
    key: "branches",
    short: "Branches",
    description: "Parallele Entwicklungszweige in einem Git-Repository, die unabhängige Änderungen am selben Projekt ermöglichen und später zusammengeführt werden können."
  ),
  // ── Fachbegriffe ────────────────────────────────────────────────
  (
    key: "build-time",
    short: "Build-Time",
    description: "Der Prozessablauf während der Ausführung des Migrationswerkzeugs. Im Gegensatz zu Runtime (dem Zeitpunkt der Testausführung) finden alle Transformationen, Konvertierungen und Code-Generierung während der Build-Time statt. In diesem Projekt umfasst die Build-Time alle Pipeline-Module (test_suite_translator, test_transpiler, test_assembler, etc.), die ein Katalon-Projekt einmalig in ein Selenium/Pytest-Projekt konvertieren."
  ),
  (
    key: "runtime",
    short: "Runtime",
    description: "Der Zeitpunkt der Ausführung der generierten Tests. Im Gegensatz zu Build-Time (während der Migration) werden während der Runtime die migrierten Selenium-Pytest-Tests tatsächlich ausgeführt. Die in src/runtime/ gespeicherten Dateien (base_test.py, katalon_helpers.py) werden während dieser Phase verwendet und sind nicht Bestandteil des Migrationsprozesses."
  ),
  (
    key: "object-repository",
    short: "Object Repository",
    description: "Eine zentrale Datenstruktur in Katalon Studio, die alle Test Objects (z. B. Schaltflächen, Eingabefelder) mit ihren Lokalisierungsstrategien speichert. Jedes Objekt enthält Eigenschaften wie XPath, CSS-Selektor oder ID, anhand derer Selenium das Element im DOM der Webanwendung identifiziert."
  ),
  (
    key: "spy-web-utility",
    short: "Spy Web Utility",
    description: "Ein Werkzeug in Katalon Studio zum Erfassen und Anlegen von Test Objects direkt aus einer laufenden Webanwendung. Dabei werden Selektoren wie XPath, CSS oder Attribute ausgelesen und im Object Repository gespeichert."
  ),
  (
    key: "fixture",
    short: "Pytest Fixture",
    description: "Ein Mechanismus in Pytest, der wiederverwendbare Test-Vorbedingungen und -Nachbedingungen definiert. Fixtures werden in der Datei conftest.py deklariert und stehen allen Tests im Projekt automatisch zur Verfügung, ohne explizit importiert werden zu müssen. Typische Anwendungen sind das Erstellen eines WebDriver-Objekts oder das Einrichten von Testdaten."
  ),
  (
    key: "locator",
    short: "Locator",
    description: "Ein Ausdruck, mit dem Selenium ein HTML-Element auf einer Webseite identifiziert. Gängige Locator-Strategien sind ID, CSS-Selektor, XPath und Name. Katalon speichert Locatoren im Object Repository; bei der Migration werden sie in Selenium-kompatible By-Strategien überführt."
  ),
  (
    key: "match",
    short: "Match",
    description: "Eine erfolgreiche Übereinstimmung eines Regular-Expression-Musters mit einem Teil des Eingabetextes. Wenn ein Regex-Muster einen Textbereich findet, der der definierten Regel entspricht, wird dieser erkannte Bereich als Match bezeichnet. Ein Match enthält typischerweise auch Capture Groups, die Teilinformationen des Musters speichern."
  ),
  (
    key: "delimiter",
    short: "Delimiter",
    description: "Ein Trenn- oder Begrenzungszeichen, das den Anfang, das Ende oder die Struktur eines Ausdrucks markiert. Im Kontext von Regular Expressions wird ein Sonderzeichen wie der Punkt durch Escaping (z. B. `\\.`) als literales Zeichen behandelt und verliert seine spezielle Regex-Bedeutung."
  ),
  (
    key: "guid",
    short: "GUID",
    long: "Globally Unique Identifier",
    description: "Eine nahezu weltweit eindeutige Kennung, die zur Identifikation von Objekten oder Einträgen verwendet wird."
  ),
  (
    key: "webdriver",
    short: "WebDriver",
    description: "Eine standardisierte API (W3C-Standard), über die Programme einen Webbrowser programmatisch steuern können. Selenium WebDriver ist die Referenzimplementierung und bildet die Grundlage aller in dieser Arbeit generierten Tests."
  ),
  (
    key: "selenium",
    short: "Selenium",
    description: "Ein Open-Source-Framework zur Automatisierung von Webbrowsern. In dieser Arbeit wird Selenium in Kombination mit Pytest als Ausführungsumgebung der migrierten Tests verwendet."
  ),
  (
    key: "pytest",
    short: "Pytest",
    description: "Ein weit verbreitetes Python-Testframework zur Strukturierung, Ausführung und Auswertung automatisierter Tests. In dieser Arbeit dient Pytest als Test-Runner und organisatorischer Rahmen für die migrierten Selenium-Tests."
  ),
  (
    key: "regression-test",
    short: "Regressionstest",
    description: "Ein Test zur Überprüfung, ob bereits vorhandene und zuvor funktionierende Software-Funktionalität nach Änderungen weiterhin korrekt arbeitet. Regressionstests werden typischerweise nach Codeanpassungen erneut ausgeführt, um unbeabsichtigte Seiteneffekte frühzeitig zu erkennen."
  ),
  (
    key: "groovy",
    short: "Groovy",
    description: "Eine dynamisch typisierte Skriptsprache, die auf der JVM läuft und vollständig mit Java interoperabel ist. Katalon Studio verwendet Groovy als Skriptsprache für Testskripte. In dieser Arbeit wird Groovy-Code mittels Regex-Transformation in Python übersetzt."
  ),
  (
    key: "vendor-lock-in",
    short: "Vendor Lock-in",
    description: "Die technische oder wirtschaftliche Abhängigkeit eines Unternehmens von einem einzelnen Anbieter, die einen Wechsel zu Alternativen erschwert oder verteuert. Im Kontext dieser Arbeit bezeichnet Vendor Lock-in die Bindung an Katalon Studio durch proprietäre Dateiformate und lizenzpflichtige Funktionen."
  ),
  (
    key: "low-code",
    short: "Low-Code",
    description: "Ein Entwicklungsansatz, bei dem Anwendungen und Prozesse mit stark abstrahierten, meist grafischen Bausteinen erstellt werden. Der manuelle Programmieraufwand ist geringer, dafür sind Erweiterbarkeit und Kontrolle bei komplexeren Anforderungen oft eingeschränkt."
  ),
  (
    key: "pro-code",
    short: "Pro-Code",
    description: "Ein Entwicklungsansatz, bei dem Lösungen vollständig in einer allgemeinen Programmiersprache umgesetzt werden. Er erfordert mehr Implementierungsaufwand, bietet dafür aber hohe Flexibilität, Transparenz und Anpassbarkeit."
  ),
  (
    key: "transpilation",
    short: "Transpilation",
    description: "Der Prozess der automatischen Übersetzung von Quellcode einer Programmiersprache in eine andere. Im Unterschied zur Kompilation bleibt das Abstraktionsniveau erhalten. In dieser Arbeit bezeichnet Transpilation die Übersetzung von Groovy-Testskripten nach Python."
  ),
  (
    key: "test-object",
    short: "Test Object",
    description: "Ein in Katalon Studio definiertes Objekt, das ein HTML-Element auf einer Webseite repräsentiert. Test Objects enthalten Informationen wie Name, Beschreibung und Locator. Sie werden im Object Repository gespeichert und in Testskripten referenziert."
  )
)

#let project(
  thesisKindDE: "Bachelorarbeit",
  thesisExaminationDE: "Bachelorprüfung",
  thesisKindEN: "",
  thesisExaminationEN: "",
  titleDE: "Per Anhalter durch die Galaxis",
  titleEN: "Hitchhiker's Guide to the Galaxy",
  abstractDE: [],
  abstractEN: [],
  keywordsDE: "",
  keywordsEN: "",
  author: "Douglas Adams",
  language: "de",
  studyCourseName: "Bachelor of Science Computer Science",
  submissionDate: "31.12.2038",
  departmentDE: "Informatik",
  departmentEN: "Computer Science",
  facultyDE: "Fakultät Technik und Informatik",
  facultyEN: "Faculty of Engineering and Computer Science",
  university: "Hochschule für Angewandte Wissenschaften Hamburg",
  firstSupervisor: "Prof. Dr. Ford Prefect",
  secondSupervisor: "Prof. Dr. Zaphod Beeblebrox",
  body
) = {
  // Change stuff from here
  let coverPageColour = "#003CA0";
  let textColour = "#000000"
  let spaceBetweenParagraphs = 1.5em
  let spaceBetweenLines = 1em
  // Set the document's basic properties.
  set document(author: author, title: titleDE)
  set page(margin: (y: 2cm, inside: 3cm, outside: 2cm), numbering: "I")
  set text(rgb(coverPageColour), font: "Arial", lang: language)
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")
  
  // Set page numbering to ouside
  set page(footer: context {
    let (n,) = counter(page).get()
    set align(if calc.even(here().page()) { left } else { right })
    counter(page).display(page.numbering)
  })

  // No accidental empty pages
  set pagebreak(weak: true)

  // Front page

  // coverPage(
  //   thesisKind: thesisKindDE,
  //   author: author,
  //   title: titleDE,
  //   departmentEN: departmentEN,
  //   departmentDE: departmentDE,
  //   facultyEN: facultyEN,
  //   facultyDE: facultyDE,
  //   coverPageColour: coverPageColour
  // )
  set text(rgb(textColour), font: "Open Sans", size: 11pt)

  // Title page
  titlePage(
    author: author,
    title: titleDE,
    thesisKindDE: thesisKindDE,
    thesisExaminationDE: thesisExaminationDE,
    thesisKindEN: thesisKindEN,
    thesisExaminationEN: thesisExaminationEN,
    studyCourseName: studyCourseName,
    department: departmentDE,
    faculty: facultyDE,
    university: university,
    firstSupervisor: firstSupervisor,
    secondSupervisor: secondSupervisor,
    language: language,
    submissionDate: submissionDate
  )

  // Abstract page.

  abstractPage(
    author: author,
    titleDE: titleDE,
    keyWordsDE: keywordsDE,
    abstractDE: abstractDE,
  )
  

  // Abkürzungs- und Begriffsverzeichnis
  show: make-glossary
  register-glossary(entry-list)
  
  // Table of contents.
  // HACK: Set the state to true , print heading to table of contents, set state to false
  outline(
    title: [Inhaltsverzeichnis], depth: 3, indent: auto)
  pagebreak()
  heading(level: 1, numbering: none, outlined: true)[Abkürzungs- und Begriffsverzeichnis]
  print-glossary(entry-list, show-all: true)
  pagebreak(weak: true)

  // Abbildungsverzeichnis & Tabellenverzeichnis auch im Inhaltsverzeichnis anzeigen
  show outline: set heading(outlined: true)
  outline(
    title: [Abbildungsverzeichnis],
    target: figure.where(kind: image),
  )

  pagebreak()

  outline(
    title: [Tabellenverzeichnis],
    target: figure.where(kind: table),
  )

  pagebreak()

  // Main body.
  set text(rgb(textColour), font: "Arial", size: 11pt)
  set page(numbering: "1", number-align: center)
  set par(justify: true, leading: spaceBetweenLines, spacing: spaceBetweenParagraphs)
  set page(header: getHeader(title: titleDE))
  counter(page).update(1)
  body

  // Anhang -> Kein Header, keine Nummerierung, neue Seite
  pagebreak()
  set page(header: [])

  bibliography("references.bib", style: "ieee", title: "Quellenverzeichnis")

  pagebreak()

  statement()
}