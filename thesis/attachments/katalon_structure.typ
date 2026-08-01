Die folgende Abbildung zeigt die vollständige Dateistruktur des Katalon Projekts, wie sie außerhalb der @ide im Filesystem vorliegt — inklusive aller in den vorangehenden Abschnitten beschriebenen Verschachtelungen:

//TODO: Diese große Struktur unten als Anhang mitgeben und hier nur darauf hinweisen.
#figure(
  text(size: 0.9em)[
  ```
  sample-website-katalon-tests/
  │
  ├── Test Cases/                           - Katalon IDE zeigt diese Ansicht
  │   ├── Users/
  │   │   ├── filter_for_admins.tc         - .tc = XML Meta-Datei (Beschreibung, Variable)
  │   │   ├── search_for_david_kim.tc      - KEINE Testlogik enthalten!
  │   │   └── show_active_viewers.tc
  │   └── Menus/
  │       └── navigation_bar.tc
  │
  ├── Scripts/                              - Echte Testlogik (außer IDE verborgen)
  │   ├── Users/
  │   │   ├── filter_for_admins/
  │   │   │   └── Script1781348815820.groovy  - Zufällige Nummer! (!)
  │   │   ├── search_for_david_kim/
  │   │   │   └── Script1781447000826.groovy  - Entspricht search_for_david_kim.tc
  │   │   └── show_active_viewers/
  │   │       └── Script...groovy
  │   └── Menus/
  │       └── navigation_bar/
  │           └── Script...groovy
  │
  ├── Object Repository/                   - Lokalisierungsstrategien (Selektoren)
  │   ├── All_Users/
  │   │   ├── view_all_users_btn.rs        - .rs = XML Objekt (XPath, CSS, ID...)
  │   │   ├── search_input.rs
  │   │   ├── roles_dropdown.rs
  │   │   ├── status_dropdown.rs
  │   │   ├── user_row.rs
  │   │   └── user_row_view_btn.rs
  │   └── Nav_Bar/
  │       └── ...weitere Test Objects
  │
  ├── Profiles/                            - Globale Variablen nach Umgebung
  │   └── default.glbl                     - .glbl = XML (GlobalVariableEntity Einträge)
  │
  ├── Data Files/                          - Externe Testdaten-Referenzen
  │   └── users.dat                        - .dat = XML Meta (verweist auf echte Datei)
  │
  ├── Keywords/                            - Custom Methoden/Helper
  │   ├── data/
  │   └── TESTER.groovy                    - Groovy Klasse mit eigenen Methoden
  │
  ├── Libs/
  │   └── CustomKeywords.groovy            - Statische Weiterleitungen zu Keywords
  │
  └── Plugins/, Test Listeners/, ...
  ```],
  caption: [Katalon Projektstruktur: Komplexe Verschachtelung und Format-Vielfalt (.tc, .groovy, .rs, .glbl, .dat, .xml)],
)<fig-katalon-input-structure>

Diese Struktur verdeutlicht die Komplexität, die eine Migration bewältigen muss. Besonders auffällig ist die Vielfalt der Dateiformate: Obwohl Dateien wie .tc, .rs, .glbl und .dat alle auf XML basieren, tragen sie proprietäre Endungen, die ihren Inhalt verschleiern. Hinzu kommt, dass ein einziger Test aus zwei getrennten Dateien in zwei verschiedenen Ordnern besteht — die Metadaten liegen in Test Cases/, die eigentliche Testlogik in Scripts/. Die Verbindung zwischen ihnen ist dabei nur indirekt über den Pfad herstellbar: Scripts/Users/filter_for_admins/Script1781348815820.groovy gehört zu Test Cases/Users/filter_for_admins.tc. Erschwerend kommt hinzu, dass die Script-Dateien zufällig generierte Nummern im Namen tragen, die keinerlei Rückschlüsse auf den zugehörigen Test Case erlauben.