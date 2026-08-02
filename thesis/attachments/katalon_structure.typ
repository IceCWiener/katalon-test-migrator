== Katalon Projektstruktur <anh-katalon-struktur>

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
)<fig-katalon-input-structure>
