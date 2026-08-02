== Regex-Muster der Transpilation <anh-regex-muster>
#show figure: set block(breakable: true)

#figure(
  table(
    columns: (auto, 2fr, 3fr, 2fr),
    inset: 8pt,
    align: (center, left, left, left),
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 { rgb("#e8f4f8") },
    [*\#*], [*Pattern Name*], [*Regex*], [*Zweck*],
    [1], [`comment_pattern`], [`/\\*[^*]*\\*+(?:[^/*][^*]*\\*+)*/`], [Block-Kommentare entfernen],
    [2], [`private_method_pat`], [`private void .*{\n[\s\w.\(\)=\"\,'\/\[+@\-\\];\<{}]*\n}`], [Private Methoden extrahieren],
    [3], [`katalon_lines_pattern`], [`\/\*|\/\/.+|\/\*.+|WebUI.+\n.+|WebUI.+|CustomKeywords.*`], [Relevante Zeilen filtern],
    [4], [`katalon_code_pattern`], [`(\w+)\.(\w+)\((.*)\)`], [Teilt Code in Klasse, Methode und Parameter],
    [5], [`fto_as_param_pat`], [`(findTestObject\(.*\))(?=,)`], [Erkennt findTestObject() als ersten Parameter mit Lookahead auf folgendes Komma],
    [6], [`ftd_as_param_pat`], [`(findTestData\(.*\))(?=,)`], [Erkennt findTestData() als ersten Parameter mit Lookahead auf folgendes Komma],
    [7], [`param_pattern`], [`,\s+(?=false)|(?!\]),\s(?=Fail.*)|(?<![a-zA-Z]),\s(?!\s)(?![a-zA-Z])|,\s(?=null)|,\s+(?=\[)`], [Parameter teilen, wenn mehrere vorhanden],
    [8], [`fto_param_str_pattern`], [`(findTestObject\(('.*').*\))`], [Extrahiert findTestObject() mit String-Argument zur Transformation],
    [9], [`ftd_param_str_pattern`], [`findTestData\(('.*').*\)\.getValue\((.+)\))`], [Extrahiert findTestData() mit String und getValue()-Argument],
    [10], [`GlobalVariable pattern`], [`GlobalVariable\.([A-Za-z_][A-Za-z0-9_]*)`], [Global Variablen normalisieren],
    [11], [`abn_test_pat`], [`String\s\w+\s=|if\(|TestObject\s\w+\s=`], [Custom Code erkennen],
  ),
  caption: [Regex-Muster die in der Transpilation verwendet werden.]
) <table-regex>