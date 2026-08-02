# Thesis: Design and Evaluation of an Automated Migration Tool from Katalon Groovy Tests to Selenium-Pytest

---

## Title Page

**Konstantin Lucius Regenhardt**

### Design and Evaluation of an Automated Migration Tool from Katalon Groovy Tests to Selenium-Pytest

Bachelor's Thesis submitted in partial fulfillment of the requirements for the degree of **Bachelor of Science (B.Sc.) in Environmental Informatics**  
at Department 2 (School of Engineering - Energy and Information)  
Faculty of Engineering and Computer Science  
of the **University of Applied Sciences (HTW) Berlin**  

* **First Supervisor:** Prof. Dr. Jochen Wittmann  
* **Second Supervisor (Co-Examiner):** Ankit Kumar  
* **Date of Submission:** August 2nd, 2026  

---

## Kurzzusammenfassung / Abstract

### Kurzzusammenfassung (German)
Proprietäre Low-Code-Plattformen wie Katalon ermöglichen einen schnellen Einstieg in die Testautomatisierung, können bei wachsender Projektgröße jedoch zu starker Herstellerabhängigkeit und hohen Folgekosten führen. Diese Arbeit entwickelt und evaluiert eine automatisierte Migrationspipeline, die Katalon-Projekte in eine offene Python-Testumgebung mit Selenium und Pytest überführt. Der entwickelte Prototyp verarbeitet Katalon-Testskripte sowie zugehörige Projektartefakte wie Object Repository, Variablen und Konfigurationsdateien und erzeugt daraus eine ausführbare Zielstruktur. 

In der Evaluation des Beispielprojekts wurden 7 von 10 Testskripten automatisch übersetzt (70%), während 3 Fälle als Restlücke manuell nachbearbeitet werden müssen. Alle Object-Repository-Dateien wurden erfolgreich nach JSON überführt, und die strukturelle Integrität des Zielprojekts wurde durch die fehlerfreie Erkennung der generierten Tests bestätigt. Die Ergebnisse zeigen, dass der Ansatz den manuellen Migrationsaufwand deutlich reduziert und einen praktikablen Ausstiegspfad aus proprietären Testökosystemen bietet, auch wenn komplexe Sonderfälle derzeit noch nicht vollständig automatisiert abgedeckt werden.

### Abstract (English)
Proprietary low-code platforms like *Katalon* enable a fast initial entry point into test automation, but as project size scales, they can lead to strong vendor lock-in and high follow-up costs. This thesis designs and evaluates an automated migration pipeline that transfers Katalon projects into an open Python testing environment using Selenium and Pytest. The developed prototype processes Katalon test scripts as well as associated project artifacts such as the Object Repository, variables, and configuration files, generating an executable target structure. 

In the evaluation of the sample project, **7 out of 10 test scripts were automatically translated (70%)**, while 3 cases remained as gaps requiring manual post-processing. All Object Repository files were successfully migrated to JSON, and the structural integrity of the target project was confirmed by the error-free detection of the generated tests. The results demonstrate that this approach significantly reduces the manual migration effort and offers a viable exit pathway from proprietary testing ecosystems, even though complex edge cases are not yet fully covered by automation.

---

## Glossary (Abkürzungs- und Begriffsverzeichnis)

* **API (Application Programming Interface):** A defined interface through which software components communicate with each other. Selenium provides an API through which tests programmatically control the browser.
* **Assertions:** Verification expressions in test code that expect a condition to evaluate to true. If the condition is not met, the test fails and marks the corresponding location as an error.
* **Branches:** Parallel development lines in a Git repository that allow independent changes to be made to the same project and merged later.
* **Build-Time:** The process execution period during the run of the migration tool. In contrast to *Runtime* (the time of test execution), all transformations, conversions, and code generations take place during Build-Time. In this project, Build-Time encompasses all pipeline modules (`test_suite_translator`, `test_transpiler`, `test_assembler`, etc.) that perform a one-time conversion of a Katalon project into a Selenium/Pytest project.
* **CI (Continuous Integration):** A software development principle where code changes are regularly integrated into a shared repository and automatically built and tested. Automated test suites are a core tool in the CI process.
* **CLI (Command Line Interface):** A text-based user interface through which users control programs by entering commands.
* **Compiler:** A program that analyzes the source code of a programming language and checks for errors or translates it into another form. In this work, the term compiler refers to the static type analyzer *Pyright*, which examines Python files for type and import errors prior to execution.
* **Delimiter:** A separator or boundary character that marks the beginning, end, or structure of an expression. In the context of Regular Expressions, a special character such as a dot is treated as a literal character through escaping (e.g., `\.`) and loses its special regex meaning.
* **Pytest Fixture:** A mechanism in Pytest that defines reusable test preconditions and postconditions. Fixtures are declared in the `conftest.py` file and are automatically available to all tests in the project without needing explicit imports. Typical applications include creating a WebDriver object or setting up test data.
* **Framework:** A reusable structural skeleton made of libraries, rules, and conventions that structures the development of a specific type of software. In this work, Katalon and Selenium/Pytest serve as frameworks for test automation.
* **Git:** A distributed version control system for tracking changes in source code and files. Git enables, among other things, commit histories, parallel development branches, and the merging of changes.
* **GitHub:** A web-based platform for managing Git repositories with features for collaboration, pull requests, issues, and CI/CD integrations.
* **Groovy:** A dynamically typed scripting language that runs on the JVM and is fully interoperable with Java. Katalon Studio uses Groovy as the scripting language for test scripts. In this work, Groovy code is translated into Python using regex transformation.
* **GUID (Globally Unique Identifier):** A nearly globally unique identifier used to identify objects or entries.
* **HTML (HyperText Markup Language):** A standardized markup language for structuring web content. HTML describes the structure of elements such as forms, buttons, tables, and text areas, which automated UI tests access.
* **IDE (Integrated Development Environment):** A software application that provides developers with a comprehensive environment for software development. Typically, it includes a code editor, a debugger, build tools, and often a graphical project browser. Katalon Studio is such an IDE specifically designed for test automation.
* **Interpreter:** A program that executes source code step-by-step at runtime without compiling it entirely into machine code beforehand. Python is typically executed via an interpreter.
* **JVM (Java Virtual Machine):** A runtime environment that enables platform-independent execution of Java bytecode. Groovy, the scripting language of Katalon Studio, runs on the JVM.
* **Key-Value Pairs:** A data structure in which values are mapped to a unique key. In this thesis, selectors and their associated strategies are frequently described as key-value pairs.
* **Locator:** An expression with which Selenium identifies an HTML element on a webpage. Common locator strategies are ID, CSS selector, XPath, and Name. Katalon stores locators in the *Object Repository*; during migration, they are converted into Selenium-compatible `By` strategies.
* **Low-Code:** A development approach where applications and processes are created using highly abstracted, mostly graphical building blocks. Manual programming effort is lower, though extensibility and control are often limited when dealing with complex requirements.
* **Match:** A successful match of a regular expression pattern with a part of the input text. When a regex pattern finds a text segment that matches the defined rule, this detected area is called a "Match". A match typically also contains *Capture Groups* that store sub-information of the pattern.
* **Object Repository:** A central data structure in Katalon Studio that stores all Test Objects (e.g., buttons, input fields) along with their localization strategies. Each object contains properties such as XPath, CSS selector, or ID, which Selenium uses to identify the element in the DOM of the web application.
* **Parsing:** The process in which text or code is converted into a structured format so that components like classes, methods, and parameters can be selectively processed further.
* **PoC (Proof of Concept):** A prototype or feasibility study demonstrating that a concept or idea is practically feasible. In this work, PoC refers to the initial implementation of a migration script to verify feasibility.
* **Pro-Code:** A development approach where solutions are fully implemented in a general-purpose programming language. It requires more implementation effort but offers high flexibility, transparency, and adaptability.
* **Pytest:** A widely used Python testing framework for structuring, executing, and evaluating automated tests. In this work, Pytest serves as a test runner and organizational framework for the migrated Selenium tests.
* **Python:** A widely used, interpreted programming language with clear syntax and a large ecosystem. In this work, Python serves as the target language of the migration and as the foundation for executing the generated Selenium/Pytest tests.
* **RCP (Rich Client Platform):** A framework provided by Eclipse for developing modular desktop applications based on plug-ins.
* **Regex (Regular Expression):** A formal expression used to describe string patterns. In this thesis, regular expressions are used to transform Groovy syntax into Python syntax.
* **Regression Test:** A test to verify whether already existing and previously functioning software functionality still works correctly after changes. Regression tests are typically executed again after code adjustments to detect unintended side effects early.
* **Repository:** A version-controlled archive for source code and associated files, typically managed with a version control system like Git. In this thesis, repository refers to both the source Katalon project and the generated target Selenium/Pytest project as independent, versionable entities.
* **Runtime:** The point in time when the generated tests are executed. In contrast to Build-Time (during migration), the migrated Selenium/Pytest tests are actually executed during Runtime. The files stored in `src/runtime/` (`base_test.py`, `katalon_helpers.py`) are used during this phase and are not part of the migration process.
* **Selenium:** An open-source framework for automating web browsers. In this work, Selenium is used in combination with Pytest as the execution environment for the migrated tests.
* **Spy Web Utility:** A tool in Katalon Studio for capturing and creating Test Objects directly from a running web application. Selectors such as XPath, CSS, or attributes are read and stored in the Object Repository.
* **SUT (System Under Test):** The system being tested—in this work, the web application to which the automated Selenium tests are applied.
* **Test Object:** An object defined in Katalon Studio that represents an HTML element on a webpage. Test Objects contain information such as name, description, and locator. They are stored in the Object Repository and referenced in test scripts.
* **Transpilation:** The process of automatically translating source code from one programming language to another. Unlike compilation, the level of abstraction is preserved. In this thesis, transpilation refers to translating Groovy test scripts to Python.
* **UI (User Interface):** The user interface of an application through which users interact with the system. In the context of this work, UI refers to the graphical interface validated by automated tests.
* **Vendor Lock-in:** The technical or economic dependence of a company on a single vendor, which makes a transition to alternatives difficult or expensive. In the context of this work, Vendor Lock-in refers to the binding to Katalon Studio through proprietary file formats and licensed features.
* **WebDriver:** A standardized API (W3C standard) through which programs can programmatically control a web browser. Selenium WebDriver is the reference implementation and forms the basis of all tests generated in this work.
* **XML (Extensible Markup Language):** A text-based, hierarchical data format for the structured description of information. In this work, several Katalon file types are interpreted as XML and converted into open target formats.

---

## Table of Contents

* **List of Abbreviations and Glossary** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . V
* **List of Figures** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  IX
* **List of Tables** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  X

**1 Introduction** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  1
* 1.1 Motivation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  1
* 1.2 Problem Statement . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  1
* 1.3 Objectives & Structure of the Thesis . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  2

**2 Fundamentals** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  2
* 2.1 Automated Testing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  2
* 2.2 Low-Code Platforms in Testing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  3
* 2.3 Vendor Lock-in with Proprietary Platforms . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  3
* 2.4 Fundamentals of Regular Expressions (Regex) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  4

**3 Structural Analysis** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  5
* 3.1 Katalon Project Structure . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  5
    * 3.1.1 Test Cases and Test-Specific Variables . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  5
    * 3.1.2 Object Repository and Test Objects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  6
    * 3.1.3 Global Variables and Profiles . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  7
    * 3.1.4 Test Data and Integration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  7
    * 3.1.5 Custom Keywords . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  7
* 3.2 Nesting in the Katalon Structure . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  8
    * 3.2.1 Nesting of Test Cases and their Variables . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  8
    * 3.2.2 Nesting of the Object Repository and Test Objects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  9
    * 3.2.3 Nesting of Global Variables . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  9
    * 3.2.4 Nesting of Test Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
    * 3.2.5 Nesting of Custom Keywords . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
* 3.3 Python Project Structure . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
    * 3.3.1 Test Scripts and Variables . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
    * 3.3.2 Object Repository and Test Objects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
    * 3.3.3 Test Data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
    * 3.3.4 Python Configuration . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13

**4 Conceptual Design of the Migration Pipeline** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
* 4.1 Background . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
* 4.2 Architecture Overview . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
* 4.3 Transpilation of Test Cases . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
* 4.4 Adoption of Supplementary Structures . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
* 4.5 Limitations of the Migration Pipeline . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18

**5 Implementation** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
* 5.1 Tech Stack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
    * 5.1.1 Python . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
    * 5.1.2 Selenium and Pytest . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
    * 5.1.3 Git Versioning and GitHub . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
* 5.2 Project Structure of the Migrator . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
* 5.3 Execution of the Migration Pipeline (Umsetzung der Migrationspipeline) . . . . . . . . . . . . . . . . . . . . . 20
    * 5.3.1 Transpilation of the Test Cases . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
* 5.4 Limitations of the Implementation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28

**6 Evaluation** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
* 6.1 Evaluation Criteria (Evaluationskriterien) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
* 6.2 Migration Results (Migrationsergebnis) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
* 6.3 Structural Integrity (Strukturelle Integrität) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
* 6.4 Code Quality: Before-After Comparison . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
* 6.5 Effort Comparison . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32

**7 Conclusion & Future Work (Fazit und Ausblick)** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  33
**8 Appendix (Anhang)** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  35
* 8.1 Regex Patterns of Transpilation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
* 8.2 Katalon Project Structure . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
**Bibliography** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
**Declaration of Authorship** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39

---

## List of Figures

* **Figure 1:** Top: A pattern to detect Katalon click calls. Bottom: Explanations of the individual pattern parts (visualized with regex101 [1]) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4
* **Figure 2:** Left: The Test Cases filesystem. Right: A Test Case containing test logic that first opens the "All Users" window, then searches for the user "David Kim", highlights him, and finally verifies his details . . . . . . . . . . . . 6
* **Figure 3:** Left: The folded filesystem of the Object Repository. Names marked in blue were generated by the Integrated Development Environment's (IDE) native AI. Right: A Test Object describing the properties of an HTML element . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 6
* **Figure 4:** Left: View of the profiles in the filesystem. Right: A profile defining the Global Variables `URL`, `USERNAME1`, and `PASSWORD1`. The `PASSWORD1` variable is marked "protected" so that its value in the IDE is only displayed masked . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
* **Figure 5:** Left: View of the test data in the filesystem. Right: A test dataset from the file `users.dat` . . . . . . . 7
* **Figure 6:** Overview diagram of the migration pipeline from a Katalon project to an executable Python project. Represented are the main phases: Initialization, Test Transpilation, Adoption of supplementary structures, and the provision of the final project structure with content . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
* **Figure 7:** Detailed activity diagram of the transpilation workflow of a Katalon test to a Python test. Illustrated are reading, filtering, extracting, parsing, transforming, generating, and assembling test logic . . . . . . . . . 17
* **Figure 8:** Through the `katalon_lines_pattern` pattern, three separate regex matches with three groups each for class, method, and parameters are extracted from a block of Katalon lines (visualized with regex101) . . . . . . 25
* **Figure 9:** During the parsing phase, the `fto_as_param_pat` pattern detects the `findTestObject()` method as the first parameter if followed by a comma, allowing them to be split (visualized with regex101) . . . . . . . . . 26
* **Figure 10:** The `fto_param_str_pattern` pattern extracts the `findTestObject()` method with the string argument required for the transformation (visualized with regex101) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
* **Figure 11:** Console snippet of the migration highlighting 7 successful and 3 failed test translations . . . . . 29
* **Figure 12:** Comparison of test execution: top shows all tests running in the initial Katalon project, bottom shows the execution of the generated Python project. The discrepancy corresponds to the 3 untranslated test cases . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
* **Figure 13:** Comparison of the `filter_for_admins` test case: top shows the original Katalon script in Groovy, bottom shows the resulting Python test in the target project . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32

---

## List of Tables

* **Table 1:** Migration Results: The majority of the components were automatically transferred; for test scripts, a remaining gap of 3 untranslated cases persists . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
* **Table 2:** Overview of the Regular Expression (Regex) patterns in the transpilation process . . . . . . . . . . . . . . . 35

---

## 1 Introduction

### 1.1 Motivation
Automated testing is a central component of modern software quality assurance. In many teams, test automation frameworks are adopted to accelerate regression testing and increase release confidence [2]. Initially, our team used Katalon Studio as an IDE to build a basic testing infrastructure alongside the development of internal business software. Over time, this infrastructure grew significantly and covered the majority of the software.

As project requirements evolved, the team needed more advanced automation workflows, such as automated date calculations and deeper control over test execution and debugging. At this stage, initial blocks emerged: advanced features that are considered elementary in programming required additional licenses, creating substantial costs and limiting the scalability of the infrastructure. This quickly crystallized as a blocker, as the prices were disproportionate to the services provided and were unsustainable over the long term. A migration to an open-source project was proposed as a solution.

Given the significant existing investment in a Katalon-based testing environment, rewriting all collected tests completely from scratch was not feasible. Therefore, a migration approach was investigated as a Proof of Concept (PoC) to preserve previously created tests and all associated assets while enabling the transition to an open and extensible open-source structure.

### 1.2 Problem Statement
The core problem addressed in this thesis is how to retain and reuse an existing Katalon project when moving to a license-independent open-source environment. A manual migration of Katalon tests to Selenium and Pytest is highly time-consuming and practically unattainable for a large volume of tests. This is because, besides pure script translation, a multitude of additional dependencies and configurations must be taken into account. 

A Katalon project consists not only of test scripts, but also of a variety of assets such as the "Object Repository", test-external variable definitions, profiles, and data dependencies. These are stored in proprietary formats, which are obfuscated in their functionality and must be manually "excavated" and merged. A manual migration would therefore not only require the translation of Groovy to Python, but also the reconstruction of all parts of the project structure and their adaptation to the open-source frameworks.

> **Technical Challenge:** The core engineering challenge lies in executing an end-to-end transformation of an entire test automation project into an executable, scalable, and license-free alternative format rather than simple syntax replacement.

### 1.3 Objectives & Structure of the Thesis
The objective of this thesis is to design, implement, and evaluate an automated migrator that converts Katalon-based test projects into an executable Python project structure.

To achieve this goal, this work first analyzes the structure of a Katalon project and that of a Python project. Then, a migration algorithm is designed step-by-step to transfer the proprietary formats of the former into the open formats of the latter. Subsequently, a prototype is implemented to automate the migration and preserve the test logic as much as possible. 

The evaluation concentrates on four core questions:
1. How much of the source project is automatically translated?
2. What is the actual degree of automation achieved?
3. To what extent is the resulting Python project functionally equivalent to the source Katalon project?
4. Which cases remain untranslated and require manual post-processing?

---

## 2 Fundamentals

### 2.1 Automated Testing
Software testing is a fundamental part of quality assurance in software development. Its goal is to ensure that a system functions correctly and meets defined requirements. A broad distinction is made between manual and automated testing.

In manual testing, also called regression testing, a person executes the test steps themselves and evaluates the result [3]. This approach is highly effective for small, infrequent, or exploratory checks; however, its time expenditure scales rapidly. With increasing software complexity, the time required for manual testing under full coverage increases exponentially because the number of possible combinations grows exponentially with the number of input parameters [4, p. 34, p. 37].

Automated testing refers to running tests using test scripts executed by a computer. The scripts define inputs, actions, and expected results. One of the greatest benefits over manual testing is frequency; they can be run as often and consistently as desired. 

The resulting execution speed allows large volumes of tests to be processed efficiently as test suites. After code changes, it can be quickly verified whether existing functionality still works correctly. Automated tests can also be integrated directly into CI/CD pipelines to become part of the regular development workflow [5, p. 884].

For web-based applications, Selenium WebDriver has established itself as a widely used tool. The WebDriver is a standardized API through which test scripts programmatically control a browser. Clicks, form inputs, and navigation commands are sent directly to the browser as if a user were performing them manually [6].

### 2.2 Low-Code Platforms in Testing
Low-code platforms are development environments that abstract complex technical operations through graphical user interfaces and pre-built components. In the field of test automation, they offer a low-barrier entry point: tests can be recorded via a GUI or assembled from a catalog of predefined actions without requiring deep programming knowledge.

This characteristic makes low-code tools attractive for teams with limited programming expertise. However, as requirement complexity grows, they often quickly reach their limits [7]:
* **Custom Logic** that goes beyond pre-built components is difficult or impossible to implement.
* **Test Logic** is tightly coupled to the platform and integrates poorly with external version control systems.
* **Scalability and Customizability** are limited by the platform model.

In contrast, so-called **Pro-Code** approaches involve writing tests entirely in a general-purpose programming language like Python. Frameworks like Selenium and Pytest offer maximum flexibility but require corresponding programming skills. These frameworks are open-source, meaning they are free, publicly accessible, and transparent. The transition from low-code to pro-code is the core focus of this thesis.

### 2.3 Vendor Lock-in with Proprietary Platforms
Vendor lock-in describes the dependence of a user or organization on a specific vendor, making a switch to an alternative costly or highly resource-intensive [8]. This dependence often arises from proprietary file formats, platform-specific programming languages, or APIs that cannot be used outside the vendor's ecosystem.

In test automation, vendor lock-in occurs, for example, when:
* Test scripts are written in a platform-native scripting language and cannot be easily transferred to other frameworks.
* Group of internal data structures like object repositories or profile configurations are stored in proprietary formats.
* Certain features are only available in paid licensing tiers.

Consequently, teams must either accept rapidly rising license fees or lose a significant portion of their previous work when changing platforms. For the project described in this thesis, this problem manifested in the form of basic development features—such as debugging via the CLI—requiring more expensive license packages, making long-term use of the platform highly expensive.

### 2.4 Fundamentals of Regular Expressions (Regex)
The migrator uses Regular Expressions (Regex) to recognize recurring patterns in the Groovy source text automatically. According to Friedl, regular expressions are a formal language used to describe text patterns [9]. This means a pattern is defined, applied to text, and yields a match upon agreement.

Here, for example, is the detection of Katalon click calls:

*(Refer to Figure 1/Abbildung 1 in the original PDF for the visual representation).*

The pattern `WebUI\.click\((.*)\)` finds all lines containing `WebUI.click(...)`, creates a match for each occurrence, and extracts the contents of the parentheses as a group. This extracted part can then be inserted into a Selenium method call. 

Specifically, the letter sequence `WebUI.click(` is searched first. A backslash delimiter `\` is used before the dot `.` so that it loses its special regex function and is interpreted only as a literal dot. The same delimiter is used for the parentheses. This is followed by an opening parenthesis without a delimiter, which signals the start of a group. Inside the group, a wildcard dot `.` is searched, meaning any character except line endings. The asterisk `*` replicates the function of the preceding character zero or more times (greedy matching). Then, the group closes with a parenthesis `)` and the pattern ends with an escaped closing parenthesis `)`. In the actual pipeline, several patterns are combined to systematically decompose everything written in tests, including classes, methods, and parameters.

---

## 3 Structural Analysis

### 3.1 Katalon Project Structure
Katalon Studio is a proprietary test automation platform built on the Eclipse Rich Client Platform (RCP) [10]. Eclipse is a classic Integrated Development Environment (IDE) for Java development. 

From a user's perspective, a Katalon Studio project consists of "Test Cases", an "Object Repository", "Global Variables" in profiles, test-specific variables, and integrated test data. These are stored in a hierarchical folder structure managed entirely by the IDE. Here, the most important folders and files of a Katalon project relevant to this migration are described.

#### 3.1.1 Test Cases and Test-Specific Variables
The test scripts in Katalon are written in Groovy, a dynamic language that runs on the Java Virtual Machine (JVM). They are supplied with a variety of built-in keywords and functions specifically developed for test automation. Variables can be defined both globally and locally; global variables are stored in profiles and are accessible in all tests. Test-specific variables are defined in the respective test and are only available within that test.

#### 3.1.2 Object Repository and Test Objects
The Object Repository is a central element in the Katalon environment that enables the storage of User Interface (UI) elements. It stores the properties of HTML elements used during test execution. 

Users can select elements on the website using the Spy Web Utility provided by Katalon Studio and generate them in the Object Repository [11]. These "Test Objects" can be reused across different tests.

#### 3.1.3 Global Variables and Profiles
Users in Katalon can define their own global variables to be used in various tests. These variables are stored in profiles, which can represent different users or environments. 

Profiles make it possible to run tests in various configurations without changing the test code itself. For example, if one profile contains the variable `URL` with the value `https://staging.example.com` and another profile has the same variable with the value `https://production.example.com`, the test can be run in both environments simply by selecting the appropriate profile.

#### 3.1.4 Test Data and Integration
Katalon can integrate test data from various sources, such as Excel files, CSV files, or databases. This test data can be referenced in the test scripts to run the tests with different input values.

#### 3.1.5 Custom Keywords
Users can create their own structures, so-called "Custom Keywords", which can be reused in multiple tests. They function like self-written methods in classic object-oriented programming languages. These methods are written in Groovy and allow for more complex logic to be incorporated into tests and made reusable.

---

### 3.2 Nesting in the Katalon Structure
All files and folders created in the Katalon IDE are clearly presented in the viewport. However, once you examine the folder structure of a Katalon project outside the IDE, you realize that any self-created content does not consist of a single file, as is standard in programming, but of multiple nested files.

#### 3.2.1 Nesting of Test Cases and their Variables
In Katalon, a "Test Case" consists of multiple files working together. If you follow the Katalon folder structure in Explorer under "Test Cases", as displayed in the IDE, you arrive at a `.tc` file. Opening this file reveals that it is a renamed `.xml` file. It contains metadata, such as a description, test name, tags, comments, a Globally Unique Identifier (GUID), and the actual values of the test-specific variables. 

There is no obvious reference to the actual test logic. This is stored in a separate file. One would assume the GUID helps in referencing the two files, but the test scripts do not contain this anywhere. To find it, one must open the "Scripts" folder and mirror the path of the "Test Case". There, you will find a folder bearing the test name, which contains a `.groovy` file named "Script" combined with a random number. This number has no relation to the `.tc` file. 

This `.groovy` file contains the actual test logic. If the test accesses a variable, the "raw" name of the variable is written in the script. "Raw" means that the name in the code has no data type and references nothing in the test. The variable is neither declared nor initialized in the test.

```text
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
**Listing 1:** This listing shows the folder structure of the Test Cases and the associated test scripts from the filesystem's perspective. The `.tc` files contain metadata, and the `.groovy` files contain the actual test logic.

---

#### 3.2.2 Nesting of the Object Repository and Test Objects
If a test wants to use a "Test Object", the complete path to the storage location of the `.rs` file is specified in the test script to call it. The `.rs` file contains all selectors and specifies which of them should be used as the primary selector.

```text
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
        └── ...other Test Objects
```
**Listing 2:** This listing shows the Object Repository and the Test Objects from the filesystem's perspective. The `.rs` files contain the selectors of HTML elements.

#### 3.2.3 Nesting of Global Variables
When a test uses a global variable, this appears in the code as `GlobalVariable.VARIABLE_NAME`. The value of the variable is not found in the script, but in the profile file with the extension `.glbl`, which is stored in the "Profiles" folder. This file is also an `.xml` file and contains the variables as entries in a `GlobalVariableEntity` describing the variable. 

These entries contain the actual value and metadata, consisting of a description, the variable name, the data type, and a boolean describing whether the value is "protected". If it is "protected", the value is treated as sensitive and is masked with asterisks in the UI and during editing. 

In "Logs", the values are then also not displayed. However, in the `.glbl` file, the value is unencrypted and visible in plain text. Depending on which profile is selected in the IDE, the corresponding `.glbl` file is loaded and the variable values are used in the test.

```text
sample-website-katalon-tests/
│
└── Profiles/ 
    ├── default.glbl 
    └── staging.glbl 
```
**Listing 3:** This listing shows the folder structure of the profiles from the filesystem's perspective. The `.glbl` files contain the Global Variables and their values.

#### 3.2.4 Nesting of Test Data
As soon as you want to integrate a data file format using Katalon Studio, the IDE creates a `.dat` file in the "Data Files" folder bearing the same name as the integrated file. This file also contains XML structures, but only holds some metadata, including the path to the integrated file, the file type, delimiters (if applicable), and whether the path is internal or external to the project. The actual data is not contained in the `.dat` file, but in the integrated file itself.

```text
sample-website-katalon-tests/
│
└── Data Files/ 
    └── users.dat 
```
**Listing 4:** This listing shows the folder structure of the test data from the filesystem's perspective. The `.dat` files contain metadata and point to the actual test data.

#### 3.2.5 Nesting of Custom Keywords
The majority of the "Custom Keywords" logic is stored in the "Keywords" folder and user-created subfolders, written in Groovy as `ClassName.groovy`. These scripts contain the actual classes and methods called in the tests. 

In the "Libs" folder, there is a `CustomKeywords.groovy` file. This defines static forwards with the same name as the classes in the "Keywords" folder. These methods call the actual methods in the classes, making them callable in every test.

```text
sample-website-katalon-tests/
│
├── Keywords/ 
│   ├── data/
│   └── TESTER.groovy 
│
└── Libs/
    └── CustomKeywords.groovy 
```
**Listing 5:** This listing shows the folder structure of the Custom Keywords from the filesystem's perspective. The `.groovy` files in the Keywords folder contain the logic of the classes and methods called in the tests. In the Libs folder is the `CustomKeywords.groovy` file, which defines static forwards to the classes in the Keywords folder.

---

### 3.3 Python Project Structure
A project that uses Selenium and Pytest for test automation is, unlike Katalon, not bound to a proprietary project structure. Pytest only expects a traceable file organization through conventions, valid Python modules, and a configuration in the project root directory in the form of a `pyproject.toml` or `pytest.ini` [12]. 

In a pure test project, the repository contains no application code, but exclusively tests, shared helper modules, configuration files, and test data. Typically, there is a central `tests` directory, which is further subdivided into sections of the application under test (such as UI tests and API tests) as the project scales [13]. 

The `src` layout known from Python package projects is not mandatory in this case. According to the Python Packaging User Guide, the `src` layout primarily serves to clearly separate importable application code from the project root [14]. Since this Python project is dependent on the Katalon structure, the original Katalon structure is mirrored in the Python structure. The `src` layout is used to separate the Katalon structures from standard Python configurations.

#### 3.3.1 Test Scripts and Variables
The actual test cases follow the naming conventions provided by Pytest, such as `test_NAME.py` or `NAME_test.py` [13]. Unlike Katalon, a test case usually consists of exactly one Python file in which the test logic is directly readable. Reusable element selectors or methods can be factored out into separate helper modules. These are often called "helper" or "utility" functions.

Variables are normally not managed via proprietary profile or metadata files in such a project, but via standard Python programming structures. Typical patterns include variables directly in a test script or defined in a central configuration file. This makes it clear where a value comes from and where it is integrated into the test.

Since Katalon Studio stores variables in separate files and calls them using a path, the migrator must create the same structure to run the tests unchanged. A `variables` folder is created, mirroring the structure of the Test Cases with variables. In the subfolders, the variables are stored in Python classes that contain all the variables of the test. The classes are then imported into the tests, and the variables can be accessed.

```text
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
```
**Listing 6:** This listing shows the structure of the test scripts and test-specific variables in the target project. Tests are organized in Python files containing the test logic. Variables are stored in separate Python classes, each containing all variables of a test.

---

#### 3.3.2 Object Repository and Test Objects
Just as test scripts and variables are mirrored in the Python structure, the Object Repository and the Test Objects are mirrored within it. The Test Objects are stored in JSON files containing the same information as the original `.rs` files. The directory structure is preserved, so tests can continue to access the Test Objects by specifying the path to the JSON files.

```text
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
```
**Listing 7:** This listing shows the structure of the Object Repository and the "Test Objects" files stored inside it in JSON format.

#### 3.3.3 Test Data
Test data is often stored in a dedicated directory, such as `data`, `resources`, or `testdata`, and read directly by tests or helper modules as needed. These can be JSON, CSV, XML, or Excel files, but practically any format is usable. In this case, a `data` folder is created that copies the test data from Katalon directly. Tests can then access the data by specifying the path to the files.

```text
sample-website-selenium-tests/ 
│
└── data/ 
    └── users.csv 
```
**Listing 8:** This listing shows the structure of the `data` folder, which contains the test data in CSV format.

#### 3.3.4 Python Configuration
For a Python project to work, it must meet certain conventions. This includes that all directories intended to contain Python modules must possess an `__init__.py` file. This empty file signals to the Python interpreter that the directory should be treated as a package. In this project, they are automatically created in all relevant directories. 

Furthermore, a `README.md` file is created. It contains instructions on creating a Pytest configuration file `.vscode/settings.json`, and steps to set up a virtual environment named `.venv`. Inside the virtual environment, all dependencies listed in the generated `requirements.txt` file are installed. 

These dependencies stand as a reference list of all necessary Python packages required to run the tests. A `pytest.ini` file is also created to hold Pytest configurations, specifying paths to the test scripts.

```text
sample-website-selenium-tests/ 
│
├── data/ 
├── src/
├── .gitignore 
├── pytest.ini 
├── README.md 
└── requirements.txt 
```
**Listing 9:** Overview of the generated configuration files.

---

## 4 Conceptual Design of the Migration Pipeline

### 4.1 Background
When the task of migrating the internal testing system to another ecosystem arose, an initial concept was to write a Python project that could directly read and execute Katalon tests. However, this idea was quickly discarded after consultation with other developers, as the proprietary formats and Katalon-specific logic were too complex to execute directly in an open-source framework. 

Instead, an approach was chosen that transforms the Katalon test logic completely into a new, extensible, and freely usable structure. Through this complete separation from Katalon structures, it was to be ensured that in the future, no further problems with dependencies on Katalon would arise. The tests should be able to be executed directly in the new structure without requiring Katalon Studio if, for example, new tests or elements needed to be created. 

As a first approach, a small pipeline was built with the task of translating frequently occurring methods. This approach quickly showed that the Katalon structure in the background of the IDE was much more complex and nested than it seemed at first glance.

### 4.2 Architecture Overview
To master the complexity, the Katalon project is structurally broken down into its parts. One advantage of the proprietary structure is that it dictates the layout and is predictable, which makes this type of algorithm possible in the first place. 

1. **Initialization:** First, the algorithm receives the paths of the source and target projects from the user. Subsequently, all files in the source project are recursively searched, and relevant structures, such as the "Test Case" folders and the Object Repository, are mirrored in the target project as empty folders. The unchanged system paths leading from the "root" directory to the files are integral to this.
2. **Test Transpilation:** Once the basic structures are initialized, files from the source are opened and processed. First, the Test Cases are transpiled from the Groovy programming language into the Python language. The more precise workflow of this can be read in Section 4.3.
3. **Adoption of Supplementary Structures:** Subsequently, the Test Objects, global variables, and test data are found, read, and translated. All of them contain Extensible Markup Language (XML) data but have different file extensions. The Test Objects are converted into JSON files, the Global Variables into Python classes, and the test data is copied over.
4. **Final Assembly:** Finally, configuration files and utility files are created in the target project so that it is executable without major preparations. These include runtime helpers, test configurations, the list of dependencies, and documentation.

*(Refer to Figure 6/Abbildung 6 in the original PDF for the overview diagram of the migration pipeline).*

---

### 4.3 Transpilation of the Test Cases
The transpilation process shown in Figure 7 follows a fixed sequence of seven steps:
1. **Read Groovy File:** The original Groovy file is read so its content can be processed as raw text.
2. **Filter Comments & Imports:** Comments and import lines are removed to isolate the code relevant to the migration.
3. **Extract Test Lines:** The actual test lines are extracted, representing exactly the instructions essential for test behavior.
4. **Parse Instructions:** These lines are parsed individually (Parsing), decomposing each instruction into its fundamental components (class reference, method name, and parameters).
5. **Transform Methods & Parameters:** The detected methods and parameters are transformed into semantically equivalent constructs of the target environment.
6. **Generate Python Code:** Valid Python-Selenium-Pytest code is generated, representing the previously identified test logic in executable form.
7. **Assemble Code Fragments:** The generated code fragments are assembled into a complete test and written to the target structure.

> **Key Takeaway:** The pipeline progressively reduces the original Groovy test to its essential logic and systematically transfers it into a Python-based test format.

*(Refer to Figure 7/Abbildung 7 in the original PDF for the detailed transpilation activity diagram).*

### 4.4 Adoption of Supplementary Structures
An executable target project only arises when, alongside the test logic, the associated context structures also exist. Therefore, after the transpilation of the Test Cases, the supplementary structures must also be adopted. These include, in particular, object descriptions from the Object Repository, variable sources (global or local), test data, as well as runtime and configuration files. Without these elements, many generated tests would indeed be syntactically present, but could not correctly access selectors, data, or environment parameters.

The adoption therefore pursues the goal of transferring the dependencies scattered throughout Katalon into an open and traceable target structure without losing the semantic meaning of the tests. This ensures that not only individual code is migrated, but a consistent testing system is created that can be directly developed and executed in the new ecosystem.

### 4.5 Limitations of the Migration Pipeline
The migration pipeline is designed to recognize the core functions of a Katalon project and transform them into a new structure. However, it is not capable of covering all possible Katalon functions and scenarios. 

In particular, self-written Custom Keywords, plattform-specific extensions, or highly nested test logics can lead to problems. Also, comments are temporarily skipped due to low relevance. The pipeline focuses on the most common use cases and provides a solid foundation for migration, but may require manual adjustments for specific requirements. 

Writing a regex-based translation of these complex structures is not impossible, as other transpilations show, but within the scope of the original task, this would have been too time-consuming.

---

## 5 Implementation

This chapter describes the technical implementation of the migration tool: its folder structure, the separation between migration and runtime code, as well as the tasks of the individual pipeline modules.

### 5.1 Tech Stack

#### 5.1.1 Python
The fundamental programming language of the migrator is Python. The choice fell on Python because the language is characterized by a comparatively low syntax complexity, excellent readability, and broad support for file processing and text transformation. These properties are highly suitable for a prototype designed to analyze, transform, and transfer large volumes of structured input data into new source texts.

#### 5.1.2 Selenium and Pytest
Selenium is an established and widely used open-source framework for web browser automation that supports a variety of browsers and platforms. It offers a robust API that makes it possible to control and test web applications. Pytest is another open-source framework known for its simple syntax, flexibility, and extensive functionality. It supports the creation of test cases, test suites, and offers a variety of plug-ins to extend functionality. Together they form a versatile, practical, and highly standard open-source tech stack for test automation.

#### 5.1.3 Git Versioning and GitHub
For versioning the source code, Git is used. The version control system enables traceable development of the tool since changes are historized, compared, and can be rolled back to earlier states if necessary. The integration with GitHub also facilitates central storage of the source code and documented further development of the project.

---

### 5.2 Project Structure of the Migrator
The following overview shows the relevant project structure of the migrator at the root level. The thesis directory is deliberately hidden to keep the focus on the technical working structure of the migration tool:

```text
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
```
**Listing 10:** Project structure of the migration tool on the "root" level (excluding the thesis folder & Continuous Integration (CI) pipeline) with separation between control logic, configuration files, and migration modules.

The structure separates control logic and migration modules clearly. In the project root, `main.py` orchestrates the entire workflow, while `README.md` documents its execution. The `src/` folder holds the functional components: `pipeline/` contains the transformation steps, `runtime/` holds the runtime templates for the target project, and `utils/` hosts shared utility functions. This separation minimizes coupling between modules and simplifies the targeted extension of individual pipeline building blocks.

---

### 5.3 Execution of the Migration Pipeline (Umsetzung der Migrationspipeline)
The migration pipeline consists of seven specialized modules. `main.py` calls the controlling functions that orchestrate the modules in the pipeline. Each module handles a clearly defined sub-step, thereby transitioning the Katalon structure into the target environment in a controlled manner.

For the robustness of the pipeline, erroneous or non-uniquely transformable test scripts are not discarded but stored separately in `src/unreadable_tests/`. This keeps the automated execution stable while problematic cases can be manually post-processed.

* `test_script_scanner.py` forms the entry point of the pipeline. The module recursively traverses the `Scripts/` folder of the Katalon project, filters `.groovy` files, and distributes each file to `test_transpiler.py` and `test_assembler.py`. The Katalon directory structure is mirrored inside `src/tests/`. Test scripts that are not fully translatable are saved under `src/unreadable_tests/`.
* `test_transpiler.py` performs the syntactic transformation. It applies the regex patterns documented in Table 2 to the scanned Groovy code, detects Katalon method calls, and translates them step-by-step into Python equivalents. The result is a list of transformed code lines.
* `test_assembler.py` builds a complete Python-Pytest test class from the transpiled lines. The script adds the required imports, creates a class structure with `BaseTest` inheritance in the constructor, and encapsulates the test logic in a `test_TESTNAME` method.
* `object_repo_converter.py` converts all `.rs` files in the `Object Repository/` folder from XML to JSON with the help of `xml_utils.py`. The internal `WebElementEntity` structure is preserved; only the file format changes. The result is saved under `src/object_repository/`.
* `global_vars_generator.py` reads `Profiles/default.glbl` (XML with `GlobalVariableEntity` entries) in the source directory and generates `src/profiles/global_variables.py`—a Python class `GlobalVariables` with class variables for global project values.
* `variables_extractor.py` reads the `.tc` metadata files of the Test Cases and extracts test-specific variables. For each test with variables, a dedicated Python file is generated under `src/variables/`, providing the variables as a Python class.
* `copy_runtime_files.py` concludes the migration. This script copies `base_test.py.template` and `katalon_helpers.py.template` into `src/runtime/` of the target project, removes the `.template` extension, and generates the configuration files `pytest.ini`, `requirements.txt`, `.gitignore`, and `README.md` in the project root.

#### 5.3.1 Transpilation of the Test Cases
The actual test transpilation is the core of the implementation. It begins by reading the Groovy file, removing irrelevant parts like comments and import lines, and subsequently reducing the code to the test-relevant `WebUI.` lines. These lines are parsed (Parsing), broken down into individual components, and translated step-by-step into Python structures. This produces an executable test from the original Katalon logic, matching its original behavior.

##### 5.3.1.1 Semantic Transformation: Katalon Test Object to Selenium Locators
The Katalon Object Repository stores test objects as `.rs` files, which internally are renamed XML files with a `WebElementEntity` structure. Each file describes an HTML element via a `selectorCollection` containing one or more localization strategies as key-value pairs (e.g., `BASIC`/`XPath` or `CSS`), as well as a `selectorMethod` field determining the preferred strategy.

During Build-Time, `object_repo_converter.py` converts these XML files into JSON format. The internal structure remains fully preserved and only the file format changes. The following example shows the transformation of the object file `view_all_users_btn`:

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
```

```json
// src/object_repository/All_Users/view_all_users_btn.json (generated JSON)
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
**Listing 11:** Exemplary transformation of a Katalon Test Object from an XML-based `.rs` file into the corresponding JSON representation in the target project.

At Runtime in the target project, the helper function `find_katalon_test_object()` in `katalon_helpers.py` reads the JSON file, extracts `selectorMethod`, and searches for the matching value from the `selectorCollection`. It then locates the element via the Selenium API: using `By.CSS_SELECTOR` for CSS, and `By.XPATH` for all other strategies (including BASIC). The call in the generated test code remains structurally identical to the Katalon original:

**Katalon (Groovy):**
```groovy
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
```
**Generated Python Code:**
```python
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
```
**Listing 12:** Exemplary mapping of a Katalon `findTestObject()` call to the corresponding Selenium-based runtime helper in the generated Python test.

The generated test code itself has no knowledge of the localization strategy used, but only accesses the runtime helper `find_katalon_test_object()` and passes a path. The binding between test logic and element selector is preserved without changing the test input.

---

##### 5.3.1.2 Syntactic Transformation: Groovy to Python
The Groovy syntax is translated into Python syntax step-by-step via regex-supported pattern matching. The original Katalon calls are not only syntactically replaced but transferred into a format that is immediately executable within the generated Pytest structure. The following lines illustrate how typical WebUI calls, object accesses, and variable references are transformed:

```groovy
WebUI.verifyTextPresent('View All Users', false)
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
WebUI.setText(findTestObject('All_Users/search_input'), david)
WebUI.verifyTextPresent(GlobalVariable.user4name, false)
```

```python
assert 'View All Users' in self.driver.page_source
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').clear()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').send_keys(variables.david)
assert GlobalVariable.USER4NAME in self.driver.page_source
```
**Listing 13:** Exemplary syntactic transformation of several Katalon WebUI calls into executable Python test code within the generated Pytest structure.

The example shows three typical transformation types: page content assertions are converted into Python assertions, `findTestObject()` calls are mapped using runtime helpers to locate target objects, and variable accesses are bound to the Python structures created in the target project. Particularly relevant here is that path specifications and object identifiers are not discarded but transferred into a new access schema. This ensures that the binding between test logic and supplementary structures remains intact even after migration.

##### 5.3.1.2.1 Regex-based Transformation
The pipeline uses multiple coordinated patterns to translate Groovy test code step-by-step into an executable Python test format.

According to the conceptual diagram, this process begins by reading the original Groovy file. Then, comments and import lines are removed, leaving only the code relevant for transpilation. From this filtered code, the actual test lines are extracted. These test lines are then parsed and decomposed into their basic components such as class reference, method name, and parameters. 

Based on this, the transformation of detected methods and parameters into corresponding constructs of the target environment takes place. From the transformed building blocks, Python code is generated that represents the original test logic in a new form. Finally, the generated fragments are assembled into a complete test.

The following figures illustrate by way of example how individual patterns are utilized in parsing. In particular, it is shown how relevant test lines are first isolated and subsequently `findTestObject()` calls are recognized as independent parameter components. This makes it visible that the regex patterns do not work independently of each other, but form a sequential processing chain.

*(Refer to Figures 8, 9, and 10 in the original PDF for the regex matching views).*

A complete overview of the regex patterns used can be found in the Appendix in Section 8.1. There, the most important patterns, their regular expressions, and their respective purposes are summarized.

---

### 5.4 Limitations of the Implementation
The implemented pipeline is geared towards the standard cases observed in the project. It reliably processes typical Katalon structures but reaches its limits with non-standard Groovy constructs, unusually nested test flows, or project-specific Custom Keywords. Such cases require either supplementary rules or manual post-processing in the target project. Thus, the implementation deliberately remains focused on the most common migration paths rather than fully mapping every theoretically possible Katalon structure.

After presenting the implementation details, the following chapter examines the extent to which the pipeline actually achieves the expected migration goals in the sample project.

---

## 6 Evaluation

To evaluate the migration tool, the Katalon sample project `sample-website-katalon-tests` was used. It contains real end-to-end tests, an Object Repository, two global variable profiles, and an integrated CSV data file. The migration was performed on a Windows 11 machine with Python 3.13.0 and pytest 8.4.1.

### 6.1 Evaluation Criteria (Evaluationskriterien)
The evaluation of the prototype deliberately focuses on the basic functions of the migration pipeline and the core objectives formulated in this work.

In the migration results, we observe **which proportion of the relevant Katalon files was successfully transferred** into the target structure. Additionally, the degree of automation is evaluated, capturing which transformation steps run without manual intervention and which artifacts are fully generated automatically.

When examining the structural integrity, we investigate whether the generated Python project executes the original test logic in a comparable manner and whether the expected test cases are correctly provided.

Furthermore, code quality is measured, which encompasses the overall syntax, untranslated or partially translated cases, and their root causes.

Finally, the required effort is compared between a manual migration and utilizing the automated migration pipeline.

---

### 6.2 Migration Results (Migrationsergebnis)
Running the migrator (`python main.py`) yields the following results:

---

### Table 1: Migration Results Summary

| Component | Count | Description |
| :--- | :---: | :--- |
| **Translated Test Scripts** | 7 | 7 out of 10 `.groovy` files from `Scripts/` successfully translated |
| **Untranslatable Tests** | 3 | 3 tests could not be translated automatically |
| **Object Repository Files** | 10 | All `.rs` XML files converted to JSON |
| **Variable Files** | 1 | Test-specific variables extracted from `.tc` metadata files |
| **Runtime Files** | 2 | `base_test.py` and `katalon_helpers.py` copied to target |
| **Configuration Files** | 4 | `pytest.ini`, `requirements.txt`, `.gitignore`, `README.md` |
| **Data Files** | 1 | `users.csv` copied directly to target project |

> **Automation Rate:** Out of 10 existing test scripts, 7 were translated automatically, while 3 cases failed. This represents a **70% translation coverage for test scripts**, with a remaining manual gap of 30%.

*(Refer to Figure 11/Abbildung 11 in the original PDF for the migration console output screenshot).*

---

### 6.3 Structural Integrity (Strukturelle Integrität)
This step verifies whether the target project is fully importable and if the expected test cases are correctly provided.

After migration, the Python project was verified using `pytest --collect-only`—a native Pytest feature that scans all tests and checks the syntax. Pytest was able to import all generated files without errors and discover the 7 automatically generated tests:

```text
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
**Listing 14:** Console output of `pytest --collect-only` showing that all 7 automatically generated Python tests are recognized without errors.

*(Refer to Figure 12/Abbildung 12 in the original PDF for the side-by-side run execution comparison).*

---

### 6.4 Code Quality: Before-After Comparison
Using the `filter_for_admins` test as an example, the difference between the original and generated code can be demonstrated:

*(Refer to Figure 13/Abbildung 13 in the original PDF for the detailed visual comparison of the files).*

The boilerplate share drops from 18 to 7 import lines. The test logic is formulated in standard Python using pytest conventions and no longer requires proprietary Katalon keywords.

In the current state of the pipeline, all comments of the original code are stripped due to complexity reasons.

### 6.5 Effort Comparison
The automated migration of the sample project took less than one second and transferred 7 out of 10 test scripts directly into the target structure. For the remaining 3 failed cases, manual post-processing is required.

In contrast, a fully manual migration would have first required resolving the proprietary nesting among scripts, test cases, object definitions, profiles, and test data described in Section 3.2, before manually migrating 10 Groovy test scripts, 10 XML-based object files, and their associated variables/configuration structures individually into Python. 

The observation in testing literature—that manual review and transformation tasks scale strongly with an increasing number of cases and combination variety—holds true as complexity rises [4, p. 34, p. 37].

For the sample project evaluated here, even with a conservative project estimate, manual effort would fall in the **high single-digit to double-digit hour range**. The partial automation significantly reduces this effort, though it leaves targeted transformation and verification tasks open for the 3 untranslated test cases. As the test volume scales, the migrator's effort scales linearly, whereas manual effort increases disproportionately due to more complex cross-references between variables, objects, and data structures.

---

## 7 Conclusion & Future Work (Fazit und Ausblick)

This thesis describes the development of a migration tool that transfers Katalon projects into Python projects using Selenium and Pytest. The goal was to design, implement, and evaluate the tool. This objective arose from the need to migrate an extensive existing Katalon project base out of its proprietary environment into an open, extensible, and freely usable target environment.

Executing the prototype yields a Python project containing the majority of the imported test logic and surrounding test artifacts. In the sample project, **70% of the test scripts**, as well as all associated structures such as Test Objects, test data, and variables, are automatically and error-free transformed. The generated project is directly executable after minimal setup, though the remaining 30% of tests must be manually post-processed to be fully functional.

During evaluation, structural and syntactic integrity were verified. At the same time, it highlighted that not all cases are translated automatically. Custom-written logic, comments, and complex nestings quickly lead to script unreadability. Accordingly, the migration tool is not a complete replacement for manual migration but acts as a highly effective foundation to significantly reduce overall effort.

Overall, the work demonstrates that migrating Katalon projects into a Python testing environment using Selenium and Pytest is viable, even though not all cases can be resolved automatically yet.

For the future development of the tool, three main directions emerge:
1. **Expand built-in method coverage:** Add more Katalon-internal keyword methods to the list of translatable actions.
2. **Enhance Regex & Parsing rules:** Upgrade parsing robustly to process comments, deeper parameter list nestings, and custom-written variables, methods, and classes.
3. **Optimize Error Handling & Reporting:** Integrate error classification to categorize failed scripts and output detailed debug information, streamlining manual post-processing tasks.

---

## 8 Appendix (Anhang)

### 8.1 Regex Patterns of Transpilation
The following table summarizes the most important regex patterns used in the transpilation process of the migrator.

---

### Table 2: Overview of the Regular Expression (Regex) Patterns in the Transpilation Process

| # | Pattern Name | Regex | Purpose |
| :--- | :--- | :--- | :--- |
| **1** | `comment_pattern` | `/\*[^*]*\*+(?:[^/*][^*]*\*+)*/` | Remove block comments |
| **2** | `private_method_pat` | `private void .*{\n[\s\w.\(\)=\"\,\'\/\[+@\-\]\\;\<{}]*\n}` | Extract private methods |
| **3** | `katalon_lines_pattern` | `\/\*\|\/\/.+\|\/\*.+\|WebUI.+\n.+\|WebUI.+\|CustomKeywords.*` | Filter relevant code lines |
| **4** | `katalon_code_pattern` | `(\w+)\.(\w+)\((.*)\)` | Decomposes code into Class, Method, Parameter |
| **5** | `fto_as_param_pat` | `(findTestObject\(.*\))(?=,)` | Detects `findTestObject()` as the first parameter with positive lookahead for a comma |
| **6** | `ftd_as_param_pat` | `(findTestData\(.*\))(?=,)` | Detects `findTestData()` as the first parameter with positive lookahead for a comma |
| **7** | `param_pattern` | `,\s+(?=false)\|(!\]),\s(?=Fail.*)\|(?<![a-zA-Z]),\s(?!\s)(?![a-zA-Z])\|,\s(?=null)\|,\s+(?=\[)` | Split parameters when multiple are present |
| **8** | `fto_param_str_pattern`| `(findTestObject\(('.*').*\))` | Extracts `findTestObject()` with string argument for transformation |
| **9** | `ftd_param_str_pattern`| `findTestData\(('.*').*\)\.getValue\((.+)\))` | Extracts `findTestData()` with string and `getValue()` argument |
| **10**| `GlobalVariable_pattern`| `GlobalVariable\.([A-Za-z_][A-Za-z0-9_]*)` | Normalize global variables |
| **11**| `abn_test_pat` | `String\s\w+\s=\|if\(|TestObject\s\w+\s=` | Detect custom user code |

---

### 8.2 Katalon Project Structure
The following filesystem tree illustrates the nested nature of the original source Katalon project layout:

```text
sample-website-katalon-tests/
│
├── Test Cases/                  - Katalon IDE shows this view
│   ├── Users/
│   │   ├── filter_for_admins.tc - .tc = XML Metadata File (Description, Variables)
│   │   ├── search_for_david_kim.tc - Contains NO test logic!
│   │   └── show_active_viewers.tc
│   └── Menus/
│       └── navigation_bar.tc
│
├── Scripts/                     - Real test logic (hidden outside IDE)
│   ├── Users/
│   │   ├── filter_for_admins/
│   │   │   └── Script1781348815820.groovy - Random number! (!)
│   │   ├── search_for_david_kim/
│   │   │   └── Script1781447000826.groovy - Corresponds to search_for_david_kim.tc
│   │   └── show_active_viewers/
│   │       └── Script...groovy
│   └── Menus/
│       └── navigation_bar/
│           └── Script...groovy
│
├── Object Repository/           - Localization strategies (Selectors)
│   ├── All_Users/
│   │   ├── view_all_users_btn.rs - .rs = XML Object (XPath, CSS, ID...)
│   │   ├── search_input.rs
│   │   ├── roles_dropdown.rs
│   │   ├── status_dropdown.rs
│   │   ├── user_row.rs
│   │   └── user_row_view_btn.rs
│   └── Nav_Bar/
│       └── ...other Test Objects
│
├── Profiles/                    - Global variables by environment
│   └── default.glbl             - .glbl = XML (GlobalVariableEntity Entries)
│
├── Data Files/                  - External test data references
│   └── users.dat                - .dat = XML Metadata (points to real file)
│
├── Keywords/                    - Custom methods/helpers
│   ├── data/
│   └── TESTER.groovy            - Groovy class with custom methods
│
├── Libs/
│   └── CustomKeywords.groovy    - Static forwards to keywords
│
└── Plugins/, Test Listeners/, ...
```

---

## Bibliography (Quellenverzeichnis)

* **[1]** regex101, "regex101: build, test, and debug regular expressions". Accessed: July 31, 2026. [Online]. Available: `https://regex101.com/`
* **[2]** Katalon, Inc., "Katalon \| The AI Platform for Software Quality". Accessed: July 21, 2026. [Online]. Available: `https://katalon.com/`
* **[3]** International Software Testing Qualifications Board, "ISTQB Glossary". Accessed: July 22, 2026. [Online]. Available: `https://glossary.istqb.org/`
* **[4]** D. R. Kuhn, R. N. Kacker, and Y. Lei, "Practical Combinatorial Testing", NIST Special Publication 800–142, 2010. doi: `10.6028/NIST.SP.800-142`.
* **[5]** S. Chittala, "Enhancing Developer Productivity Through Automated CI/CD Pipelines: A Comprehensive Analysis", *International Journal of Computer Engineering and Technology (IJCET)*, Vol. 15, No. 5, pp. 882–891, 2024, doi: `10.5281/zenodo.13929524`.
* **[6]** Selenium Contributors, "WebDriver \| Selenium". Accessed: July 30, 2026. [Online]. Available: `https://www.selenium.dev/documentation/webdriver/`
* **[7]** A. Sahay, A. Indamutsa, D. Di Ruscio, and A. Pierantonio, "Supporting the Understanding and Comparison of Low-Code Development Platforms", in *Proceedings of the 46th Euromicro Conference on Software Engineering and Advanced Applications (SEAA)*, IEEE, 2020, pp. 171–178. doi: `10.1109/SEAA51224.2020.00036`.
* **[8]** C. Shapiro and H. R. Varian, *Information Rules: A Strategic Guide to the Network Economy*. Boston: Harvard Business School Press, 1998.
* **[9]** J. E. Friedl, *Mastering Regular Expressions*, 3rd ed. Sebastopol, CA: O'Reilly Media, 2006.
* **[10]** devalex88, "Katalon Studio 8 with Eclipse RCP 4.13 - Miscellaneous - Katalon Community". Accessed: July 31, 2026. [Online]. Available: `https://forum.katalon.com/t/katalon-studio-8-with-eclipse-rcp-4-13/36808`
* **[11]** Katalon Docs, "Spy Web utility in Katalon Studio \| Katalon Docs". Accessed: July 31, 2026. [Online]. Available: `https://docs.katalon.com/katalon-studio/record-and-spy/webui-record-and-spy-utilities/spy-web-utility-in-katalon-studio`
* **[12]** pytest development team, "Pytest Documentation: Configuration". Accessed: July 24, 2026. [Online]. Available: `https://docs.pytest.org/en/stable/reference/customize.html`
* **[13]** pytest development team, "Pytest Documentation: Good Integration Practices". Accessed: July 24, 2026. [Online]. Available: `https://docs.pytest.org/en/stable/explanation/goodpractices.html`
* **[14]** Python Packaging Authority, "Python Packaging User Guide: src layout vs flat layout". Accessed: July 24, 2026. [Online]. Available: `https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/`

---

## Declaration of Authorship (Erklärung zur selbstständigen Bearbeitung)

I hereby declare that I have written the present thesis independently and without external assistance, and that I have used no other sources and aids than those indicated. All passages taken literally or in spirit from other works have been marked as such, indicating the sources.

$$\text{Berlin, 02.08.2026}$$

$$\text{___________________________} \quad \text{___________________________} \quad \text{___________________________}$$  
$$\text{Place} \qquad\qquad\qquad\quad \text{Date} \qquad\qquad\qquad\quad \text{Original Signature}$$
