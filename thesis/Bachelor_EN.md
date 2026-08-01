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
* **Second Supervisor:** Prof. Dr. Zaphod Beeblebrox  
* **Date of Submission:** August 1st, 2026  

---

## Kurzzusammenfassung / Abstract

### Kurzzusammenfassung (German)
In der Softwareentwicklung bieten proprietäre Low-Code-Plattformen wie Katalon einen schnellen Einstieg in die Testautomatisierung. Mit steigender Projektkomplexität führen diese jedoch häufig zu einem massiven Kostenanstieg durch unflexible Lizenzmodelle für fortgeschrittene Funktionen. Da die Testlogik und Datenobjekte in proprietären Formaten gespeichert sind, stehen Nutzer vor dem Dilemma, entweder hohe Gebühren zu zahlen oder den Verlust der bisherigen Entwicklungsarbeit bei einem Plattformwechsel hinzunehmen. 

Ziel dieser Bachelorarbeit ist die Entwicklung eines programmatischen Migrationspfades von Katalon zu einer Open-Source-Alternative, geschrieben in Selenium. Dabei soll die manuelle Neuerstellung der Test-Suites durch eine automatisierte Transformations-Pipeline ersetzt werden, um die bisherige Arbeit nicht zu verlieren. Es wird ein Migrations-Algorithmus entworfen, der auf Regular Expressions und Python-Methoden basiert. Dieser scannt die proprietären Strukturen, übersetzt die bestehende Testlogik von Groovy nach Python und bildet die internen Datenobjekte sowie Referenzdateien auf eine neue, Open-Source Projektstruktur im Selenium Framework ab. 

Das Ergebnis ist ein funktionsfähiger Prototyp eines Migrations-Tools. Dieses Tool ermöglicht den Transfer von Test-Suiten in ein erweiterbares Open-Source-Projekt. Dabei bleibt die Integrität der Tests gewahrt und die Abhängigkeit von Lizenzgebühren wird vollständig eliminiert. Die Arbeit zeigt auf, wie durch automatisierte Code-Migration und -Transformation der Wechsel von proprietären „Low-Code“ zu Open-Source „Pro-Code“ gelingen kann. Die Ergebnisse bieten Nutzern eine gute Möglichkeit für den Ausstieg aus proprietären Test-Ökosystemen.

### Abstract (English)
In software development, proprietary low-code platforms like *Katalon* offer a fast initial entry point into test automation. However, as project complexity scales, these systems frequently lead to a massive escalation of costs due to inflexible licensing frameworks. This thesis addresses this "Vendor Lock-In" problem by establishing an automated transformation pipeline that migrates test suites from closed Katalon structures into an open-source, flexible framework written in Python using Selenium.

A core migration algorithm based on Python execution logic and Regular Expressions (Regex) handles the automated parsing of proprietary formats, translations of test scripts from *Groovy* to *Python*, and mapping of object repositories. The evaluation showcases a fully functional prototype that successfully eliminates license fee dependencies while completely preserving test suite runtime integrity.

---

## Glossary (Abkürzungs- und Begriffsverzeichnis)

* **API (Application Programming Interface):** A defined interface through which software components communicate with each other. Selenium provides an API through which tests programmatically control the browser.
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
* **Locator:** An expression with which Selenium identifies an HTML element on a webpage. Common locator strategies are ID, CSS selector, XPath, and Name. Katalon stores locators in the *Object Repository*; during migration, they are converted into Selenium-compatible `By` strategies.
* **Match:** A successful match of a regular expression pattern with a part of the input text. When a regex pattern finds a text segment that matches the defined rule, this detected area is called a "Match". A match typically also contains *Capture Groups* that store sub-information of the pattern.
* **Object Repository:** A central data structure in Katalon Studio that stores all Test Objects (e.g., buttons, input fields) along with their localization strategies. Each object contains properties such as XPath, CSS selector, or ID, which Selenium uses to identify the element in the DOM of the web application.
* **PoC (Proof of Concept):** A prototype or feasibility study demonstrating that a concept or idea is practically feasible. In this work, PoC refers to the initial implementation of a migration script to verify feasibility.
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

* **List of Abbreviations and Glossary** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . IV
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
* 5.3 Pipeline Modules in Detail . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
* 5.4 Transformation Process (Transformationsablauf) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
    * 5.4.1 Semantic Transformation: Katalon Test Object to Selenium Locators . . 20
    * 5.4.2 Syntactic Transformation: Groovy to Python . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22

**6 Evaluation** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
* 6.1 Migration Results . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
* 6.2 Structural Integrity . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
* 6.3 Code Quality: Before-After Comparison . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
* 6.4 Effort Comparison . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29

**7 Discussion** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
**8 Conclusion & Future Work** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
**Bibliography** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
**Declaration of Authorship** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32

---

## List of Figures

* **Figure 1:** Top: A pattern to detect Katalon click calls. Bottom: Explanations of the individual pattern parts (visualized with regex101 [1]) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4
* **Figure 2:** Left: The Test Cases filesystem. Right: A Test Case containing test logic that first opens the "All Users" window, then searches for the user "David Kim", highlights him, and finally verifies his details . . . . . . . . . . . . 6
* **Figure 3:** Left: The folded filesystem of the Object Repository. Names marked in blue were generated by the Integrated Development Environment's (IDE) native AI. Right: A Test Object describing the properties of an HTML element . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 6
* **Figure 4:** Left: View of the profiles in the filesystem. Right: A profile defining the Global Variables `URL`, `USERNAME1`, and `PASSWORD1`. The `PASSWORD1` variable is marked "protected" so that its value in the IDE is only displayed masked . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
* **Figure 5:** Left: View of the test data in the filesystem. Right: A test dataset from the file `users.dat` . . . . . . . 7
* **Figure 6:** Overview diagram of the migration pipeline from a Katalon project to an executable Python project. Represented are the main phases: Initialization, Test Transpilation, Adoption of supplementary structures, and the provision of the final project structure with content . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
* **Figure 7:** Detailed activity diagram of the transpilation workflow of a Katalon test to a Python test. Illustrated are reading, filtering, extracting, parsing, transforming, generating, and assembling test logic . . . . . . . . . 17
* **Figure 8:** Through the `katalon_lines_pattern` pattern, three separate regex matches with three groups each for class, method, and parameters are extracted from a block of Katalon lines . . . . . . . . . . . . . . . . . . . . . . . . . . 23
* **Figure 9:** During the parsing phase, the `fto_as_param_pat` pattern detects the `findTestObject()` method as the first parameter if followed by a comma, allowing them to be split . . . . . . . . . . . . . . . . . . . . . . . . . . 24
* **Figure 10:** The `fto_param_str_pattern` pattern extracts the `findTestObject()` method with the string argument required for the transformation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25

---

## List of Tables

* **Table 1:** Overview of the Regular Expression (Regex) patterns in the transpilation process . . . . . . . . . . . . . . . 26
* **Table 2:** Migration Results: All components of the Katalon project were successfully transferred . . . . . . . . . . 27

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
The objective of this thesis is to design, implement, and evaluate an automated migrator that converts Katalon-based test projects into a Python project structure.

To achieve this goal, this work first analyzes the structure of a Katalon project and that of a Python project. Then, a migration algorithm is designed step-by-step to transfer the proprietary formats of the former into the open formats of the latter. Subsequently, a prototype is implemented to automate the transformation and ensure test integrity. Finally, the results are evaluated and discussed to assess the effectiveness of the migration process.

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
* Internal data structures like object repositories or profile configurations are stored in proprietary formats.
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

From a user's perspective, a Katalon Studio project consists of "Test Cases", an "Object Repository", "Global Variables" in profiles, test-specific variables, and integrated test data. These are stored in a hierarchical folder structure managed entirely by the IDE. Here, the most important folders and files of a Katalon-projekts relevant to this migration are described.

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
For a Python project to work, it must meet certain conventions. This includes that all directories intended to contain Python modules must possess an `__init__.py` file. Although these files are empty, they signal to the Python interpreter that the directory should be treated as a package. In this project, they are automatically created in all relevant directories. 

Furthermore, a `README.md` file is created. On one hand, it contains steps to create a Pytest configuration file `.vscode/settings.json`. On the other hand, it contains steps to set up a virtual environment named `.venv`. There, all dependencies listed in the `requirements.txt` file (also created by the migrator) are installed. 

The dependencies stand as a list in the `requirements.txt` file and act as a reference for all necessary Python packages required to run the tests. A `pytest.ini` file is created, which contains the configuration for Pytest. There, among other things, the path to the test scripts is specified.

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
The transpilation process shown in Figure 7 follows a fixed sequence of seven steps. First, the original Groovy file is read so its content can be processed as raw text. Subsequently, comments and import lines are removed to isolate the code relevant for the migration. In the third step, the actual test lines are extracted from it—meaning exactly those instructions essential for test behavior. 

These lines are then parsed individually, so that each instruction is decomposed into its basic components such as class reference, method name, and parameters. On this structured basis, the transformation of the recognized methods and parameters into semantically equivalent constructs of the target environment follows. 

From this, Python code is subsequently generated, representing the previously identified test logic in executable form. In the last step, the generated code fragments are assembled into a complete test and transferred to the target structure. The entire process thus progressively reduces the original Groovy test to its essential logic and systematically transfers it into a Python-based test format.

*(Refer to Figure 7/Abbildung 7 in the original PDF for the detailed transpilation activity diagram).*

### 4.4 Adoption of Supplementary Structures
An executable target project only arises when, alongside the test logic, the associated context structures also exist. Therefore, after the transpilation of the Test Cases, the supplementary structures must also be adopted. These include, in particular, object descriptions from the Object Repository, variable sources (global or local), test data, as well as runtime and configuration files. Without these elements, many generated tests would indeed be syntactically present, but could not correctly access selectors, data, or environment parameters.

The adoption therefore pursues the goal of transferring the dependencies scattered throughout Katalon into an open and traceable target structure without losing the semantic meaning of the tests. This ensures that not only individual code is migrated, but a consistent testing system is created that can be directly developed and executed in the new ecosystem.

### 4.5 Limitations of the Migration Pipeline
The migration pipeline is designed to recognize the core functions of a Katalon project and transform them into a new structure. However, it is not capable of covering all possible Katalon functions and scenarios. 

In particular, self-written Custom Keywords, platform-specific extensions, or highly nested test logics can lead to problems. The pipeline focuses on the most common use cases and provides a solid foundation for migration, but may require manual adjustments for specific requirements. 

Writing a regex-based translation of these complex structures is not impossible, as other transpilations show, but within the scope of the original task, this would have been too time-consuming.

---

## 5 Implementation

This chapter describes the technical implementation of the migration tool: its folder structure, the separation between migration and runtime code, as well as the tasks of the individual pipeline modules.

### 5.1 Tech Stack

#### 5.1.1 Python
The fundamental programming language of the migrator is Python. It was chosen because, on one hand, Python is an easily usable and understandable language, particularly suited for rapid prototyping due to its minimal syntax complexity. On the other hand, I had already used Python extensively for other projects in the past, including a project on automated testing. In this former project, I had my first contact with Selenium and Pytest, which had a significant impact on the decision to reuse them. The decision was not made, however, without weighing the technical currency and actual advantages of both frameworks.

#### 5.1.2 Selenium and Pytest
Selenium is an established and widely used open-source framework for web browser automation that supports a variety of browsers and platforms. It offers a robust API that makes it possible to control and test web applications. Pytest is another open-source framework known for its simple syntax, flexibility, and extensive functionality. It supports the creation of test cases, test suites, and offers a variety of plug-ins to extend functionality. Together they form a versatile and highly practical tech stack for test automation.

#### 5.1.3 Git as Versioning and GitHub
For versioning the source code, Git is used. It is a widely used version control system that allows tracking changes in the code, storing them clearly in connection with GitHub, and falling back on older versions if necessary. Particularly helpful is the possibility to create dedicated "Branches", which allows developers in a team to follow independent development lines. 

Since this project was developed alone, this was not the main reason for use, but rather the history to document the development. GitHub also allows storing the source code in a central repository accessible from anywhere, making the code globally available.

---

### 5.2 Project Structure of the Migrator
The tool is divided into the following logical folder structure:

```text
src/
├── pipeline/                   # Build-Time: Migration Pipeline
│   ├── test_script_scanner.py  # Orchestration: Scans Katalon scripts
│   ├── test_transpiler.py      # Groovy to Python transpilation
│   ├── test_assembler.py       # Pytest code generation
│   ├── object_repo_converter.py# Object Repository XML to JSON conversion
│   ├── global_vars_generator.py# Global Variables profile generator
│   ├── variables_extractor.py  # Test Case variables to Python
│   ├── copy_runtime_files.py   # Copies runtime files + generates config
│   └── __init__.py
│
├── runtime/                    # Runtime: Copied to target project
│   ├── base_test.py            # Selenium WebDriver Base Class
│   ├── katalon_helpers.py      # Katalon-compatible WebDriver helpers
│   └── __init__.py
│
└── utils/                      # Build-Time Utilities
    ├── file_utils.py           # File operations + variable extraction
    ├── string_utils.py         # Identifier normalization
    ├── xml_utils.py            # Generic XML to JSON conversion
    └── __init__.py
```
**Listing 10:** Directory structure of the migration tool with separation between Build-Time and Runtime.

The structure separates responsibilities: `pipeline/` performs the entire transformation during Build-Time, `runtime/` bundles the dependencies to be copied to the target project, and `utils/` provides shared utility functions.

#### 5.2.1 Build-Time vs. Runtime
For the migrator to function, a distinction must be made between Build-Time and Runtime code. *Build-Time* refers to the execution of the migrator itself. *Runtime*, on the other hand, refers to the later point in time when the generated tests are executed in the target project using Selenium.

The files in the `src/runtime/` folder are not part of the migration pipeline; they are only needed in the target project. They contain Selenium WebDriver dependencies that are not installed at the time of migration. If they were kept as standard Python files in the repository, the compiler would report import errors when analyzing the migrator project. 

Deswegen tragen die Runtime-Dateien die Endung `.template` und werden vom Compiler ignoriert. `copy_runtime_files.py` kopiert sie während der Build-Time in das Ziel-Projekt und entfernt dabei die Endung automatisch.

---

### 5.3 Pipeline-Module im Detail
Die Migrationspipeline besteht aus sechs spezialisierten Modulen, die nacheinander von `main.py` aufgerufen werden. Jedes Modul ist für genau eine Transformation verantwortlich.

* `test_script_scanner.py` ist der Einstiegspunkt der Pipeline. Es durchläuft rekursiv den `Scripts/`-Ordner des Katalon-Projekts, filtert `.groovy`-Dateien heraus und delegiert jede Datei an `test_transpiler.py` und `test_assembler.py`. Dabei wird die Ordnerstruktur des Katalon-Projekts in der Zielstruktur `src/tests/` gespiegelt. Tests, die nicht vollständig übersetzbar sind, werden in `src/unreadable_tests/` abgelegt.
* `test_transpiler.py` führt die eigentliche syntaktische Transformation durch. Es wendet die in Tabelle 1 dokumentierten Regex Muster auf den Groovy-Code an, erkennt Katalon-Methodenaufrufe und übersetzt sie schrittweise in Python-Äquivalente. Das Ergebnis ist eine Liste von bereits transformierten Code-Zeilen.
* `test_assembler.py` nimmt die transpilierten Zeilen und baut daraus eine vollständige Python-Pytest-Testklasse zusammen. Es fügt die notwendigen Imports hinzu (`pytest`, `selenium`, `katalon_helpers`, `base_test`, `global_variables`), erzeugt die Klassenstruktur mit `BaseTest`-Vererbung und verpackt die Testlogik in eine `test_`-Methode.
* `object_repo_converter.py` konvertiert alle `.rs`-Dateien im `Object Repository/`-Ordner von XML nach JSON. Die interne `WebElementEntity`-Struktur bleibt erhalten; lediglich das Dateiformat ändert sich. Das Ergebnis wird unter `src/object_repository/` abgelegt.
* `global_vars_generator.py` liest `Profiles/default.glbl` (eine XML-Datei mit `GlobalVariableEntity`-Einträgen) und erzeugt daraus `src/profiles/global_variables.py` — eine Python-Klasse `GlobalVariables` mit Klassenvariablen für jede globale Variable des Katalon-Projekts.
* `variables_extractor.py` liest die `.tc`-Metadateien der Test Cases und extrahiert testeigene Variablen. Für jeden Test mit Variablen wird eine eigene Python-Datei unter `src/variables/` erzeugt, die die Variablen als Python-Klasse bereitstellt.
* `copy_runtime_files.py` schließt die Migration ab: Es kopiert `base_test.py.template` und `katalon_helpers.py.template` in `src/runtime/` des Ziel-Projekts (mit Endungs-Entfernung) und generiert die Konfigurationsdateien `pytest.ini`, `requirements.txt`, `.gitignore` und `README.md` im Wurzelverzeichnis.

---

### 5.4 Transformationsablauf

#### 5.4.1 Semantische Transformation: Katalon Test Object zu Selenium Locators
Das Katalon Object Repository speichert Testobjekte als `.rs`-Dateien — umbenannte XML-Dateien mit einer `WebElementEntity`-Struktur. Jede Datei beschreibt ein HTML-Element über eine `selectorCollection`, die eine oder mehrere Lokalisierungsstrategien als Schlüssel-Wert-Paare enthält (z. B. BASIC/XPath oder CSS), sowie ein `selectorMethod`-Feld, das die bevorzugte Strategie bestimmt.

Während der Build-Time konvertiert `object_repo_converter.py` diese XML-Dateien in das JSON-Format. Die interne Struktur bleibt dabei vollständig erhalten — lediglich das Dateiformat ändert sich. Das folgende Beispiel zeigt die Transformation der Objektdatei `view_all_users_btn`:

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

Zur Runtime liest die Hilfsfunktion `find_katalon_test_object()` in `katalon_helpers.py` die JSON-Datei ein, liest `selectorMethod` aus und sucht den passenden Wert aus der `selectorCollection`. Anschließend lokalisiert sie das Element über die API von Selenium: bei CSS mit `By.CSS_SELECTOR`, bei allen anderen Strategien (einschließlich BASIC) mit `By.XPATH`. Der Aufruf im generierten Testcode bleibt dabei strukturell identisch zum Katalon-Original:

**Katalon (Groovy):**
```groovy
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
```
**Generierter Python-Code:**
```python
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
```

Durch diese Zweistufigkeit — Format-Konvertierung zur Build-Time, Auflösung zur Runtime — muss der generierte Testcode selbst keine Kenntnis über die verwendete Lokalisierungsstrategie haben. Die Bindung zwischen Testlogik und Element-Selektor bleibt erhalten, ohne dass sich die Testeingabe ändert.

---

#### 5.4.2 Syntaktische Transformation: Groovy zu Python
Die Groovy-Syntax wird durch Regex-Pattern-Matching in Python-Syntax überführt. Aus der Implementierung ergeben sich beispielsweise folgende Transformationen:

**Katalon (Groovy):**
```groovy
WebUI.verifyTextPresent('View All Users', false)
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
WebUI.setText(findTestObject('All_Users/search_input'), david)
WebUI.verifyTextPresent(GlobalVariable.user4name, false)
```

**Generierter Python-Code:**
```python
assert 'View All Users' in self.driver.page_source
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').clear()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').send_keys(variables.david)
assert GlobalVariable.USER4NAME in self.driver.page_source
```

##### 5.4.2.1 Regex-basierte Transformation
Die Pipeline nutzt mehrere aufeinander abgestimmte Muster, um Groovy-Testcode schrittweise in ein ausführbares Python-Testformat zu überführen.

Im Sinne des Diagramms beginnt dieser Ablauf mit dem Einlesen der ursprünglichen Groovy-Datei. Danach werden Kommentare und Importzeilen entfernt, sodass nur der für die Transpilation relevante Code verbleibt. Aus diesem gefilterten Code werden im nächsten Schritt die eigentlichen Testzeilen extrahiert. Diese Testzeilen werden anschließend geparst und in ihre Grundbestandteile wie Klassenbezug, Methodenname und Parameter zerlegt. 

Auf dieser Grundlage folgt die Transformation erkannter Methoden und Parameter in entsprechende Konstrukte der Zielumgebung. Aus den transformierten Bausteinen wird danach Python-Code erzeugt, der die ursprüngliche Testlogik in neuer Form abbildet. Abschließend werden die generierten Fragmente zu einem vollständigen Test zusammengesetzt. 

Zur Veranschaulichung folgen Bilder, die den Ablauf des Parsens der „findTestObject“-Methode zeigen. Dabei wird regex101.com verwendet, um die Muster anschaulicher darzustellen.

*(Refer to Figures 8, 9, and 10 in the original PDF for the regex matching views).*

Die folgende Tabelle zeigt die wichtigsten Regex Muster, die im Transpilationsprozess zum Einsatz kommen:

---

### Table 1: Overview of the Regular Expression (Regex) Patterns in the Transpilation Process

| # | Pattern Name | Regex | Purpose |
| :--- | :--- | :--- | :--- |
| **1** | `comment_pattern` | `/\*[^*]*\*+(?:[^/*][^*]*\*+)*/` | Remove block comments |
| **2** | `private_method_pat` | `private void .*{\n[\s\w.\(\)=\"\,\'\/\[+@\-\]\\;\<{}]*\n}` | Extract private methods |
| **3** | `katalon_lines_pattern` | `\/\*\|\/\/.+\|\/\*.+\|WebUI.+\n.+\|WebUI.+\|CustomKeywords.*` | Filter relevant code lines |
| **4** | `katalon_code_pattern` | `(\w+)\.(\w+)\((.*)\)` | Decomposes code into Class, Method, Parameter |
| **5** | `fto_as_param_pat` | `(findTestObject\(.*\))(?=,)` | Detects `findTestObject()` as the first parameter with positive lookahead for a comma |
| **6** | `ftd_as_param_pat` | `(findTestData\(.*\))(?=,)` | Detects `findTestData()` as the first parameter with positive lookahead for a comma |
| **7** | `param_pattern` | `,\s+(?=false)\|(!\]),\s(?=Fail.*)\|(?<![a-zA-Z]),\s(?!\s)(?![a-zA-Z])\|,\s(?=null)\|,\s+(?=\[)` | Split parameters when multiple are present |
| **8** | `fto_param_str_pattern`| `(findTestObject\(('.+').*\))` | Extracts `findTestObject()` with string argument for transformation |
| **9** | `ftd_param_str_pattern`| `findTestData\(('.+').*\)\.getValue\((.+)\))` | Extracts `findTestData()` with string and `getValue()` argument |
| **10**| `GlobalVariable_pattern`| `GlobalVariable\.([A-Za-z_][A-Za-z0-9_]*)` | Normalize global variables |
| **11**| `abn_test_pat` | `String\s\w+\s=\|if\(|TestObject\s\w+\s=` | Detect custom user code |

---

## 6 Evaluation

Zur Evaluation des Migrationswerkzeugs wurde das Katalon-Beispielprojekt `sample-website-katalon-tests` verwendet. Es enthält reale End-to-End-Tests, ein Object Repository, ein globales Variablen-Profil und eine eingebundene CSV-Datendatei. Die Migration wurde auf einem Windows-11-Rechner mit Python 3.13.0 und pytest 8.4.1 durchgeführt.

### 6.1 Migrationsergebnis
Die Ausführung des Migrators (`python main.py`) liefert folgendes Ergebnis:

---

### Table 2: Migration Results Summary

| Component | Count | Description |
| :--- | :---: | :--- |
| **Translated Test Scripts** | 5 | All `.groovy` files from `Scripts/` successfully translated |
| **Untranslatable Tests** | 0 | No tests placed in `src/unreadable_tests/` |
| **Object Repository Files** | 9 | All `.rs` XML files converted to JSON |
| **Variable Files** | 1 | Test-specific variables extracted from `.tc` metadata files |
| **Runtime Files** | 2 | `base_test.py` and `katalon_helpers.py` copied to target |
| **Configuration Files** | 4 | `pytest.ini`, `requirements.txt`, `.gitignore`, `README.md` |
| **Data Files** | 1 | `users.csv` copied directly to target project |

All 5 test scripts were translated without errors. No tests were placed in `unreadable_tests/`, which corresponds to a **translation rate of 100%**.

---

### 6.2 Structural Integrity
After migration, the target project was verified using `pytest --collect-only` without starting a browser or the target application. Pytest was able to import all generated files without errors and discover all 5 tests:

```text
collected 5 items

src/tests/Menus/test_navigation_bar.py::Test_navigation_bar::test_navigation_bar
src/tests/Users/test_filter_for_admins.py::Test_filter_for_admins::test_filter_for_admins
src/tests/Users/test_search_for_david_kim.py::Test_search_for_david_kim::test_search_for_david_kim
src/tests/Users/test_show_active_viewers.py::Test_show_active_viewers::test_show_active_viewers
src/tests/Util/test_login.py::Test_login::test_login

========================= 5 tests collected in 0.27s ==========================
```

No import errors, no unresolved dependencies. The generated modules are syntactically valid Python, and all imports (`katalon_helpers`, `base_test`, `GlobalVariables`) are resolvable.

---

### 6.3 Code Quality: Before-After Comparison
Using the `filter_for_admins` test as an example, the difference between the original and generated code can be demonstrated:

**Katalon (Groovy) — 37 lines, including 18 Boilerplate Imports:**
```groovy
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
// ... 16 further import lines ...

WebUI.callTestCase(findTestCase('Util/login'), [:], FailureHandling.STOP_ON_FAILURE)
WebUI.verifyTextPresent('View All Users', false)
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
WebUI.selectOptionByValue(findTestObject('All_Users/roles_dropdown'), 'Admin', false)
WebUI.verifyTextPresent(findTestData('users').getValue(3, 1), false)
```

**Generated Python Code — 22 lines, 7 Imports (consolidated):**
```python
import pytest
import src.runtime.katalon_helpers as kh
from src.runtime.base_test import *
from src.profiles.global_variables import GlobalVariables as GlobalVariable
from selenium.webdriver.support.ui import Select

class Test_filter_for_admins(BaseTest):
    def test_filter_for_admins(self):
        assert 'View All Users' in self.driver.page_source
        kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
        Select(kh.find_katalon_test_object(self.driver, 'All_Users/roles_dropdown')).select_by_value('Admin')
        assert kh.find_katalon_test_data(self.driver, 'users', 3, 1) in self.driver.page_source
```

The boilerplate share drops from 18 to 7 import lines. The test logic is formulated in standard Python using pytest conventions and no longer requires proprietary Katalon keywords.

### 6.4 Effort Comparison
The automated migration of the sample project took less than one second. In comparison, a manual migration would have required the following steps:
* Understanding Katalon nestings (`Scripts` $\leftrightarrow$ `Test Cases`) and mapping the files.
* Translating 5 Groovy test scripts to Python (approx. 30–60 minutes per test).
* Manually converting 9 XML object files into readable Selenium locator definitions.
* Extracting the `GlobalVariables` from the `.glbl` file and creating a Python class.
* Setting up the project structure (`pytest.ini`, `requirements.txt`, folders, `__init__.py` files).

The estimated manual effort is **8–12 hours** for this sample project. As the number of tests grows, the migrator scales linearly, whereas the manual effort increases disproportionately due to increasingly complex cross-references (variables, objects, data).

## 7 Diskussion
*(Sektion im Original leergelassen)*

## 8 Fazit & Ausblick
*(Sektion im Original leergelassen)*

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

$$\text{Berlin, 01.08.2026}$$

$$\text{___________________________} \quad \text{___________________________} \quad \text{___________________________}$$  
$$\text{Place} \qquad\qquad\qquad\quad \text{Date} \qquad\qquad\qquad\quad \text{Original Signature}$$
