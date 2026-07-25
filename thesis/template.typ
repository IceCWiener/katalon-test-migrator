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
      am Department #department \
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
  
  text(weight: "bold")[Stichworte]
  align(left)[#keyWordsDE]
  
  v(0.3cm)
  
  text(weight: "bold")[Kurzzusammenfassung]
  align(left)[#abstractDE]

  v(1.0cm)
  
  pagebreak(weak: true)
  
  // Repeat for English

  v(1.5cm)
  
  text(weight: "bold")[#author]
  
  v(0.3cm)
  
  text(weight: "bold")[Title of Thesis]
  align(left)[#titleEN]
  
  v(0.3cm)
  
  text(weight: "bold")[Keywords]
  align(left)[#keyWordsEN]
  
  v(0.3cm)
  
  text(weight: "bold")[Abstract]
  align(left)[#abstractEN]

  pagebreak(weak: true)
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
    Hiermit versichere ich, dass ich die vorliegende Arbeit ohne fremde Hilfe selbständig verfasst und nur die angegebenen Hilfsmittel benutzt habe. Wörtlich oder dem Sinn nach aus anderen Werken entnommene Stellen sind unter Angabe der Quellen kenntlich gemacht.
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
  (key: "ide",
  short: "IDE",
  long: "Integrated Development Environment",
  description: "Eine Software Anwendung, die Entwicklern eine umfassende Umgebung für die Softwareentwicklung bietet."
  ),
  (key: "ui",
  short: "UI",
  long: "User Interface",
  description: "Die Benutzerschnittstelle einer Anwendung, ueber die Nutzer mit dem System interagieren."
  ),
  (key: "poc",
  short: "PoC",
  long: "Proof of Concept",
  description: "Ein Prototyp oder eine Machbarkeitsstudie, die zeigt, dass ein Konzept oder eine Idee praktisch umsetzbar ist."
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
    titleEN: titleEN,
    keyWordsEN: keywordsEN,
    abstractEN: abstractEN
  )
  
  // Abkürzungsverzeichnis
  show: make-glossary
  register-glossary(entry-list)
  print-glossary(entry-list)

  // Table of contents.
  // HACK: Set the state to true , print heading to table of contents, set state to false
  outline(
    title: [Inhaltsverzeichnis], depth: 3, indent: auto)
  pagebreak()

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