Hier ist die vollständige und akademisch präzise Übersetzung Ihrer Bachelorarbeit (Seiten 1 bis 26 des PDFs) ins Englische. 

Die Übersetzung wurde speziell an den Standard englischsprachiger Informatik-Abschlussarbeiten angepasst und verwendet präzise Software-Engineering-Terminologie.

---

# Page 1: Title Page

**Konstantin Lucius Regenhardt**

## Design and Evaluation of an Automated Migration Tool from Katalon Groovy Tests to Selenium-Pytest

Bachelor’s Thesis submitted in partial fulfillment of the requirements for the degree of **Bachelor of Science (B.Sc.) in Environmental Informatics**  
at Department 2 (School of Engineering - Energy and Information)  
Faculty of Engineering and Computer Science  
of the **University of Applied Sciences (HTW) Berlin**  

* **First Supervisor:** Prof. Dr. Jochen Wittmann  
* **Second Supervisor:** Prof. Dr. Zaphod Beeblebrox  
* **Date of Submission:** August 1st, 2026  

---

# Page 2 & 3: Abstract (German & English)

> **Thesis Topic:** Design and Evaluation of an Automated Migration Tool from Katalon Groovy Tests to Selenium-Pytest
>
> **Keywords:** Test Automation, Low-Code, Pro-Code, Code Migration, Transpilation, Katalon Studio, Selenium, Pytest

### Abstract
In software development, proprietary low-code platforms like *Katalon* offer a fast initial entry point into test automation. However, as project complexity scales, these systems frequently lead to a massive escalation of costs due to inflexible licensing frameworks. This thesis addresses this "Vendor Lock-In" problem by establishing an automated transformation pipeline that migrates test suites from closed Katalon structures into an open-source, flexible framework written in Python using Selenium.

A core migration algorithm based on Python execution logic and Regular Expressions (Regex) handles the automated parsing of proprietary formats, translations of test scripts from *Groovy* to *Python*, and mapping of object repositories. The evaluation showcases a fully functional prototype that successfully eliminates license fee dependencies while completely preserving test suite runtime integrity. The results offer users an effective pathway to exit proprietary testing ecosystems by transitioning from "Low-Code" to open-source "Pro-Code".

---

# Page 4 & 5: Glossary (Abkürzungs- und Begriffsverzeichnis)

* **API (Application Programming Interface):** A defined interface through which software components communicate with each other. Selenium provides an API through which tests programmatically control the browser.
* **Build-Time:** The process execution period during the run of the migration tool. In contrast to *Runtime* (the time of test execution), all transformations, conversions, and code generations take place during Build-Time. In this project, Build-Time encompasses all pipeline modules (`test_suite_translator`, `test_transpiler`, `test_assembler`, etc.) that perform a one-time conversion of a Katalon project into a Selenium/Pytest project.
* **CI (Continuous Integration):** A software development principle where code changes are regularly integrated into a shared repository and automatically built and tested. Automated test suites are a core tool in the CI process.
* **Compiler:** A program that analyzes source code of a programming language and checks for errors or translates it into another form. In this thesis, "compiler" refers to the static type analyzer *Pyright*, which examines Python files for type and import errors prior to execution.
* **Pytest Fixture:** A mechanism in Pytest that defines reusable test preconditions and postconditions. Fixtures are declared in the `conftest.py` file and are automatically available to all tests in the project without needing explicit imports. Typical applications include creating a WebDriver object or setting up test data.
* **Groovy:** A dynamically typed scripting language that runs on the JVM and is fully interoperable with Java. Katalon Studio uses Groovy as the scripting language for test scripts. In this work, Groovy code is translated into Python using regex transformation.
* **IDE (Integrated Development Environment):** A software application that provides a comprehensive environment for software development. Typically, it includes a code editor, a debugger, build tools, and often a graphical project browser. Katalon Studio is such an IDE specifically designed for test automation.
* **JVM (Java Virtual Machine):** A runtime environment that enables platform-independent execution of Java bytecode. Groovy, the scripting language of Katalon Studio, runs on the JVM.
* **Locator:** An expression with which Selenium identifies an HTML element on a webpage. Common locator strategies include ID, CSS selector, XPath, and Name. Katalon stores locators in the *Object Repository*; during migration, they are converted into Selenium-compatible `By` strategies.
* **Match:** A successful match of a regular expression pattern with a part of the input text. When a regex pattern finds a text segment that matches the defined rule, this detected area is called a "Match". A match typically also contains *Capture Groups* that store sub-information of the pattern.
* **Object Repository:** A central data structure in Katalon Studio that stores all Test Objects (e.g., buttons, input fields) along with their localization strategies. Each object contains properties such as XPath, CSS selector, or ID, which Selenium uses to identify the element in the DOM of the web application.
* **PoC (Proof of Concept):** A prototype or feasibility study demonstrating that a concept or idea is practically feasible. In this work, PoC refers to the initial implementation of a migration script to verify feasibility.
* **Regex (Regular Expression):** A formal expression used to describe string patterns. In this thesis, regular expressions are used to transform Groovy syntax into Python syntax.
* **Repository:** A version-controlled archive for source code and associated files, typically managed with a version control system like Git. In this thesis, repository refers to both the source Katalon project and the generated target Selenium/Pytest project as independent, versionable entities.
* **Runtime:** The point in time when the generated tests are executed. In contrast to Build-Time (during migration), the migrated Selenium/Pytest tests are actually executed during Runtime. The files stored in `src/runtime/` (`base_test.py`, `katalon_helpers.py`) are used during this phase and are not part of the migration process.
* **SUT (System Under Test):** The system being tested—in this work, the web application to which the automated Selenium tests are applied.
* **Test Object:** An object defined in Katalon Studio that represents an HTML element on a webpage. Test Objects contain information such as name, description, and locator. They are stored in the Object Repository and referenced in test scripts.
* **Transpilation:** The process of automatically translating source code from one programming language to another. Unlike compilation, the level of abstraction is preserved. In this thesis, transpilation refers to translating Groovy test scripts to Python.
* **UI (User Interface):** The user interface of an application through which users interact with the system. In the context of this work, UI refers to the graphical interface validated by automated tests.
* **Vendor Lock-in:** The technical or economic dependence of a company on a single vendor, which makes a transition to alternatives difficult or expensive. In the context of this work, Vendor Lock-in refers to the binding to Katalon Studio through proprietary file formats and licensed features.
* **WebDriver:** A standardized API (W3C standard) through which programs can programmatically control a web browser. Selenium WebDriver is the reference implementation and forms the basis of all tests generated in this work.

---

# Page 6: Table of Contents

*(Translated index as established previously)*

---

# Page 7: List of Figures

* **Figure 1:** Transpilation Activity Diagram: Transformation path of a Katalon test to a Python-Pytest test . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
* **Figure 2:** Through the `katalon_lines_pattern` pattern, three separate regex matches with three groups each for class, method, and parameters are extracted from a block of Katalon lines . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
* **Figure 3:** During the parsing phase, the `fto_as_param_pat` pattern detects the `findTestObject()` method as the first parameter if followed by a comma, allowing them to be split . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
* **Figure 4:** The `fto_param_str_pattern` pattern extracts the `findTestObject()` method with the string argument required for the transformation . . . . . . 18

---

# Page 8: List of Tables

* **Table 1:** Overview of the Regular Expression (Regex) patterns in the transpilation process . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
* **Table 2:** Migration Results: All components of the Katalon project were successfully transferred . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22

---

# Page 9, 10 & 11: Chapter 1: Introduction & Chapter 2: Foundations

## 1 Introduction

### 1.1 Motivation
Automated testing is a central component of modern software quality assurance. In many teams, test automation frameworks are adopted to accelerate regression testing and increase release confidence [1]. Initially, our team used Katalon Studio as an IDE to build a basic testing infrastructure alongside the development of internal business software. Over time, this infrastructure grew significantly and covered the majority of the software.

As project requirements evolved, the team needed more advanced automation workflows, such as automated date calculations and deeper control over test execution and debugging. At this stage, initial blocks emerged: advanced features that are considered elementary in programming required additional licenses, creating substantial costs and limiting the scalability of the infrastructure. This quickly crystallized as a blocker, as the prices were disproportionate to the services provided and were unsustainable over the long term. A migration to an open-source project was proposed as a solution.

Given the significant existing investment in a Katalon-based testing environment, rewriting all collected tests completely from scratch was not feasible. Therefore, a migration approach was investigated as a PoC to preserve previously created tests and all associated assets while enabling the transition to an open and extensible open-source structure.

### 1.2 Problem Statement
The core problem addressed in this thesis is how to retain and reuse an existing Katalon project when moving to a license-independent open-source environment. A manual migration of Katalon tests to Selenium/Pytest is extremely time-consuming and practically unattainable for a large volume of tests. This is because, besides pure script translation, a multitude of additional dependencies and configurations must be taken into account. 

A Katalon project consists not only of test scripts, but also of a variety of assets such as object repositories, variable definitions, global profiles, and data dependencies. These are stored in proprietary formats and would have to be manually "excavated" and merged. A manual migration would therefore not only require the translation of Groovy to Python, but also the reconstruction of the entire project structure and adaptation to the open-source frameworks.

The technical challenge lies not only in the syntactic conversion of test code, but in the end-to-end transformation of a test automation project into an executable and scalable alternative format.

### 1.3 Objective & Structure of the Thesis
The objective of this thesis is to design an automated migrator that converts Katalon-based test projects into a Python-Selenium/Pytest project structure.

To achieve this goal, this work first analyzes the structure of a Katalon project and that of a Python-Selenium/Pytest project. Then, a migration algorithm is designed step-by-step to transfer the proprietary formats of the former into the open formats of the latter. Subsequently, a prototype is implemented to automate the transformation and ensure test integrity. Finally, the results are evaluated and discussed to assess the effectiveness of the migration process.

---

## 2 Foundations

### 2.1 Automated Testing
Software testing is a fundamental part of quality assurance in software development. Its goal is to ensure that a system functions correctly and meets defined requirements. A broad distinction is made between manual and automated testing.

In manual testing, also called "manual regression testing", a person executes the test steps themselves and evaluates the result. This approach is highly effective for small, infrequent, or exploratory checks; however, its time expenditure scales rapidly. With increasing software complexity, the time required for manual testing increases exponentially.

Automated testing refers to running tests using test scripts executed by a computer. The scripts define inputs, actions, and expected results. Core benefits of automated testing include [2]:
* **Repeatability:** The same tests can be executed as often as desired and consistently.
* **Speed:** Large test suites can be executed in a short amount of time.
* **Regression Safety:** After code changes, it can be quickly checked whether existing functionality still works correctly.
* **CI/CD Integration:** Automated tests can be integrated directly into deployment pipelines.

A frequently used method is the **End-to-End (E2E) Test**, where an application is tested from a user's perspective through the user interface. Tools like Selenium WebDriver enable such tests for web-based applications by programmatically controlling a browser.

---

### 2.2 Low-Code Platforms in Testing
Low-code platforms are development environments that abstract complex technical operations through graphical user interfaces and pre-built components. In the field of test automation, they offer a low-barrier entry point: tests can be recorded via a GUI or assembled from a catalog of predefined actions without requiring deep programming knowledge.

This characteristic makes low-code tools attractive for teams with limited programming expertise. However, as requirement complexity grows, they often quickly reach their limits [3]:
* **Custom Logic** that goes beyond pre-built components is difficult or impossible to implement.
* **Test Logic** is tightly coupled to the platform and integrates poorly with external version control systems.
* **Scalability and Customizability** are limited by the platform model.

In contrast, so-called **Pro-Code** approaches involve writing tests entirely in a general-purpose programming language like Python. Frameworks like Selenium and Pytest offer maximum flexibility but require corresponding programming skills. These frameworks are open-source, meaning they are free, publicly accessible, and transparent. The transition from low-code to pro-code is the core focus of this thesis.

### 2.3 Vendor Lock-in with Proprietary Platforms
Vendor lock-in describes the dependence of a user or organization on a specific vendor, making a switch to an alternative costly or highly resource-intensive [4]. This dependence often arises from proprietary file formats, platform-specific programming languages, or APIs that cannot be used outside the vendor's ecosystem.

In test automation, vendor lock-in occurs, for example, when:
* Test scripts are written in a platform-native scripting language and cannot be easily transferred to other frameworks.
* Internal data structures like object repositories or profile configurations are stored in proprietary formats.
* Certain features are only available in paid licensing tiers.

Consequently, teams must either accept rapidly rising license fees or lose a significant portion of their previous work when changing platforms. For the project described in this thesis, this problem manifested in the form of basic development features—such as debugging via the CLI—requiring more expensive license tiers, making long-term use of the platform highly expensive.

---

# Page 12 to 18: Chapter 3: Structural Analysis

## 3 Structural Analysis

### 3.1 Katalon Project Structure
From the perspective of an IDE user, a Katalon Studio project consists of tests, an "Object Repository", global variables in profiles, test-specific variables, and integrated test data. These are stored in a hierarchical folder structure managed by the IDE.

#### 3.1.1 Essential Folders and Files
* **3.1.1.1 Test Cases & Variables:** The test scripts in Katalon are written in Groovy, a dynamic language that runs on the Java Virtual Machine (JVM). They are supplied with a variety of built-in keywords and functions specifically developed for test automation. Variables can be defined both globally and locally; global variables are stored in profiles and are accessible in all tests.
* **3.1.1.2 Object Repository:** The Object Repository is a central element in the Katalon environment that enables the storage of User Interface (UI) elements. It stores the properties of HTML elements used during test execution. Users can select elements on the website using a tool provided by Katalon Studio and generate them in the Object Repository. These elements can be reused across different tests, facilitating test maintenance and scalability.
* **3.1.1.3 Global Variables & Profiles:** Users in Katalon can define their own global variables to be used in various Test Cases. These variables are stored in profiles, which can represent different users or environments. Profiles make it possible to run tests in various configurations without changing the test code itself. For example, if one profile contains the variable `URL` with the value `https://staging.example.com` and another profile has the same variable with the value `https://production.example.com`, the test can be run in both environments simply by selecting the appropriate profile.
* **3.1.1.4 Test Data & Integration:** Katalon can integrate test data from various sources, such as Excel files, CSV files, or databases. This test data can be referenced in the test scripts to run the tests with different input values.
* **3.1.1.5 Custom Keywords:** Users can create their own methods, so-called "Custom Keywords", which can be reused in multiple Test Cases. These keywords are written in Groovy and allow for more complex logic to be incorporated into tests and made reusable.

---

### 3.1.2 Nesting in the Katalon Structure
All files and folders created in the Katalon Integrated Development Environment (IDE) are clearly presented in the viewport. However, once you examine the folder structure of a Katalon project outside the IDE, you realize that test scripts do not consist of a single file, as is standard in programming.

#### 3.1.2.1 Nesting of Test Cases
In Katalon, a "Test Case" consists of multiple files working together. If you follow the Katalon folder structure in Explorer under "Test Cases", as displayed in the IDE, you arrive at a `.tc` file. Opening this file reveals that it is a renamed `.xml` file. It contains metadata, such as a description, test name, tags, comments, a GUID, and the actual values of the test-specific variables. There is no obvious reference to the actual test logic. 

This logic is stored in a separate file. To find it, one must open the "Scripts" folder and mirror the path of the "Test Case". There, you will find a folder bearing the test name, which contains a `.groovy` file named "Script" combined with a random number. The number has no relation to the `.tc` file. This `.groovy` file contains the actual test logic. If the test accesses a variable, the "raw" name of the variable is written in the script. "Raw" means that the name in the code has no data type and references nothing in the test. The variable is neither declared nor initialized in the test.

#### 3.1.2.2 Nesting of Global Variables
When a test uses a global variable, this appears in the code as `GlobalVariable.VARIABLE_NAME`. The value of the variable is not found in the script, but in the profile file with the extension `.glbl`, which is stored in the "Profiles" folder. This file is also an `.xml` file and contains the variables as entries in a `GlobalVariableEntity`. These entries contain the actual value and metadata, consisting of a description, the variable name, the data type, and a boolean describing whether the value is "protected". If it is "protected", the value is treated as sensitive and is masked with asterisks in the UI and during editing.

#### 3.1.2.3 Nesting of Test Data
As soon as you want to integrate a data file format using Katalon Studio, the IDE creates a `.dat` file in the "Data Files" folder bearing the same name as the integrated file. This file also contains XML structures, but only holds some metadata, including the path to the integrated file, the file type, delimiters (if applicable), and whether the path is internal or external to the project. The actual data is not contained in the `.dat` file, but in the integrated file itself.

#### 3.1.2.4 Nesting of Custom Keywords
The majority of the "Custom Keywords" logic is stored in the "Keywords" folder and user-created subfolders, written in Groovy as `ClassName.groovy`. These scripts contain the actual classes and methods called in the tests. In the "Libs" folder, there is a `CustomKeywords.groovy` file. This defines static forwards with the same name as the classes in the "Keywords" folder. These methods call the actual methods in the classes, making them callable in every test.

The following listing shows the complete file structure of the Katalon project as it exists outside the IDE in the filesystem:

---

### Listing 1: Katalon Project Structure (Complex Nesting & Formats)

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

This structure illustrates the complexity that a migration must handle. Particularly striking is the variety of file formats: although files like `.tc`, `.rs`, `.glbl`, and `.dat` are all XML-based, they carry proprietary extensions that obscure their content. Furthermore, a single test consists of two separate files in two different folders—metadata in `Test Cases/` and test logic in `Scripts/`. The connection between them is only reconstructible via the path: `Scripts/Users/filter_for_admins/Script1781348815820.groovy` belongs to `Test Cases/Users/filter_for_admins.tc`. To make matters worse, the script files bear randomly generated numbers in their names, allowing no conclusions about the corresponding Test Case.

---

### 3.2 Selenium/Pytest Project Structure
A project that uses Selenium and Pytest for test automation is, unlike Katalon, not bound to a proprietary project structure. Pytest only expects a traceable file organization through conventions, valid Python modules, and a configuration in the project root directory in the form of a `pyproject.toml` or `pytest.ini` [5]. In a pure test project, the repository contains no application code, but exclusively test cases, shared helper modules, configuration files, and test data. 

Typically, there is a central `tests` directory, which is further subdivided into sections of the application under test (such as UI tests and API tests) as the project scales [6]. The `src` layout known from Python package projects is not mandatory in this case. According to the Python Packaging User Guide, the `src` layout primarily serves to clearly separate importable application code from the project root [7].

#### 3.2.1 Test Scripts & Variables
The actual test cases follow the naming conventions provided by Pytest, such as `test_NAME.py` or `NAME_test.py` [6]. Unlike Katalon, a test case usually consists of exactly one Python file in which the test logic is directly readable. Reusable browser interactions, element selectors, or methods can be factored out into separate helper modules. These are often called "helper" or "utility" functions.

Variables are not managed via proprietary profile or metadata files in such a project, but via standard Python programming structures. Typical patterns include parameterizations in test functions, return values from fixtures, environment variables, or external configuration files. This makes it clear where a value comes from and where it is integrated into the test.

#### 3.2.2 Test Data & Integration
Test data is often stored in a dedicated directory, such as `data`, `resources`, or `testdata`, and then read directly by tests or helper modules as needed. These can be JSON, CSV, XML, or Excel files, but practically any format is usable. Unlike Katalon, no additional proprietary metadata file is created that only contains a reference to the actual data source. Instead, file paths, loading behavior, and further processing are directly visible in the Python code or associated helper functions.

#### 3.2.3 Pytest Fixtures & Configuration
A central role in Pytest is played by the file `conftest.py`. The Pytest fixtures defined there are reusable test components and are automatically available to all tests without needing explicit imports [8]. In this way, shared setups—such as creating a WebDriver object, logins, temporary directories, or standardized test data—can be gathered in a single, common place.

The general project configuration typically resides in the root directory of the repository. There, test paths, default options for the test run, or markers can be defined [5].

For a pure Selenium/Pytest test project, this results in a comparatively lean structure composed of test scripts, shared fixtures, optional helper modules, and separate test data. Compared to the Katalon structure, both the paths and the dependencies between test logic, configuration, and data are much more directly readable.

---

### Listing 2: Generated Target Selenium/Pytest Project Structure

```text
sample-website-selenium-tests/ - New Target Project
│
├── pytest.ini                 - Pytest configuration (generated)
├── requirements.txt           - Python dependencies (generated)
├── .gitignore                 - Git configuration (generated)
├── README.md                  - Project documentation (generated)
│
├── data/                      - Test data (copied from Katalon "Data Files")
│   └── users.csv              - Original file copied directly
│
└── src/
    ├── __init__.py
    │
    ├── tests/                 - From: Test Cases/ + Scripts/
    │   ├── Users/
    │   │   ├── test_filter_for_admins.py - .../filter_for_admins/Script...groovy
    │   │   ├── test_search_for_david_kim.py
    │   │   ├── test_show_active_viewers.py
    │   │   └── __init__.py
    │   ├── Menus/
    │   │   ├── test_navigation_bar.py
    │   │   └── __init__.py
    │   └── __init__.py
    │
    ├── object_repository/     - From: Object Repository/ (.rs XML ➔ JSON)
    │   ├── All_Users/
    │   │   ├── view_all_users_btn.json - Content: JSON (converted from .rs XML)
    │   │   ├── search_input.json
    │   │   ├── roles_dropdown.json
    │   │   └── __init__.py
    │   ├── Nav_Bar/
    │   └── __init__.py
    │
    ├── profiles/              - From: Profiles/ (.glbl XML)
    │   ├── global_variables.py - Python class with all GlobalVariables
    │   └── __init__.py
    │
    ├── variables/             - From: Test Cases/ (test-specific variables)
    │   ├── Users/
    │   │   ├── var_search_for_david_kim.py - Python class per test (if present)
    │   │   └── __init__.py
    │   └── __init__.py
    │
    └── runtime/               - Copied from the migrator itself
        ├── base_test.py       - Selenium WebDriver Base Class
        ├── katalon_helpers.py - Compatibility Helpers
        └── __init__.py
```

---

# Page 19 to 27: Chapter 4: Conception of the Migration Pipeline

## 4 Conceptual Design of the Migration Pipeline
An initial idea, when the task of migrating to another ecosystem arose, was to write a Selenium/Pytest project that could directly read and execute Katalon tests. However, this idea was quickly discarded after consultation with other developers, as the proprietary formats and Katalon-specific logic were too complex to execute directly in an open-source framework. 

Instead, an approach was chosen that transforms the Katalon test logic into a new, open structure. Through this complete separation from Katalon structures, maintainability and extensibility could be ensured. For the next approach, a small pipeline was built first, which attempted to translate frequently occurring methods. This approach quickly showed that the Katalon structure in the background of the IDE is much more complex and nested than it appears at first glance. 

Over time, regex-based methods developed to detect all Katalon function calls, followed by others to detect paths to Test Objects, then to detect variables, and finally to detect global variables and their values. Over time, a comprehensive migration pipeline was established that recognizes the central aspects of a Katalon structure, transforms them, and saves them in a new Selenium/Pytest structure.

### 4.1 Architecture Overview
The migration pipeline contains many small modules that work together step-by-step to transform all content. Together, they form five core functions that map the entire transformation process:

1. **Scanner & Parsing:** Acts as the entry point. It systematically scans and extracts all project components such as Test Cases, Object Repository, variables, and test data from the old project.
2. **Transpilation:** Applies regex-based reading rules to the Groovy syntax to progressively recognize and translate the original code.
3. **Mapping & Validation:** Tightly coupled with transpilation, this maps Katalon data types to their Python equivalents while validating the integrity of all transformations.
4. **Code Generation:** Generates valid, immediately executable Selenium-Pytest code from the transformed structures.
5. **Assembly:** The combining step that writes all generated files into a correct and maintainable Selenium/Pytest project structure.

This pipeline architecture ensures that all important elements of a Katalon project are transformed systematically, traceably, and maintainably. The implementation of the migration tool was done in Python and utilizes a strictly modularized architecture that distinguishes between **Build-Time** (Migration Pipeline) and **Runtime** (target project files).

---

### 4.2 Transformation Process

#### 4.2.1 Structural Transformation: Project Layout
As shown in Listing 1 and Listing 2 (Chapter 3), the hierarchical Katalon structure is mapped to a flat, easily executable Python project structure. The main mappings are:
* `Test Cases/` & `Scripts/` $\rightarrow$ `src/tests/` (merged into one file per test)
* `Object Repository/` $\rightarrow$ `src/object_repository/` (XML content converted to JSON)
* `Profiles/` $\rightarrow$ `src/profiles/global_variables.py` (Python class with all variables)
* `Data Files/` $\rightarrow$ `data/` (original file copied directly, proprietary `.dat` metadata is dropped)

#### 4.2.2 Semantic Transformation: Katalon Test Object to Selenium Locators
The Katalon Object Repository stores test objects as `.rs` files—renamed XML files with a `WebElementEntity` structure. Each file describes an HTML element via a `selectorCollection` containing one or more localization strategies as key-value pairs (e.g., `BASIC`/`XPath` or `CSS`), as well as a `selectorMethod` field determining the preferred strategy.

During Build-Time, `object_repo_converter.py` converts these XML files into JSON format. The internal structure remains fully preserved—only the file format changes. The following example shows the transformation of the object file `view_all_users_btn`:

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

At Runtime, the helper function `find_katalon_test_object()` in `katalon_helpers.py` reads the JSON file, extracts the `selectorMethod`, and searches for the matching value from the `selectorCollection`. It then locates the element via the Selenium API: using `By.CSS_SELECTOR` for CSS, and `By.XPATH` for all other strategies (including BASIC). The call in the generated test code remains structurally identical to the Katalon original:

**Katalon (Groovy):**
```groovy
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
```
**Generated Python Code:**
```python
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
```

Through this two-stage approach—format conversion at Build-Time, resolution at Runtime—the generated test code does not need to know the localization strategy used. The binding between test logic and element selector is preserved without changing the test input.

---

#### 4.2.3 Syntactic Transformation: Groovy to Python
The Groovy syntax is translated into Python syntax via regex pattern matching. The implementation yields transformations such as:

**Katalon (Groovy):**
```groovy
WebUI.verifyTextPresent('View All Users', false)
WebUI.click(findTestObject('All_Users/view_all_users_btn'))
WebUI.setText(findTestObject('All_Users/search_input'), david)
WebUI.verifyTextPresent(GlobalVariable.user4name, false)
```

**Generated Python Code:**
```python
assert 'View All Users' in self.driver.page_source
kh.find_katalon_test_object(self.driver, 'All_Users/view_all_users_btn').click()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').clear()
kh.find_katalon_test_object(self.driver, 'All_Users/search_input').send_keys(vars.david)
assert GlobalVariable.USER4NAME in self.driver.page_source
```

*(Refer to Figure 1/Abbildung 1 in the original PDF for the detailed workflow diagram).*

#### 4.2.3.1 Regex-based Transformation
The migrator uses "Regular Expressions (Regex)" to recognize Groovy syntax. According to Friedl, regex is defined as *"a language used to describe patterns within text"* [9]. A match is a successful matching: when the pattern finds a part of the text that corresponds to the rule, it is called a "Match". In the context of this migration, regex patterns serve to identify Groovy code and dissect it into its individual parts to translate them back into Python equivalents.

A simplified example: To recognize all calls to the Katalon method `WebUI.click(...)`, a pattern is defined as follows:
* **Pattern:** `WebUI\.click\((.*?)\)`
* **Replacement:** `{$1}.click()`

This expression searches for the text "WebUI.click" followed by any content in parentheses and replaces it with the contents of the parentheses coupled with the Python method `.click()`. Thus, `WebUI.click(findTestObject('btn'))` is transformed into `{find_katalon_test_object('btn')}.click()`.

---

### Table 1: Overview of the Regular Expression (Regex) Patterns in the Transpilation Process

| # | Pattern Name | Regex | Purpose |
| :--- | :--- | :--- | :--- |
| **1** | `comment_pattern` | `/\*[^*]*\*+(?:[^/*][^*]*\*+)*/` | Remove block comments |
| **2** | `private_method_pat` | `private void .*{\n[\s\w.\(\)=\"\,\'\/\[+@\-\]\\;\<{}]*\n}` | Extract private methods |
| **3** | `katalon_lines_pattern` | `\/\*\|\/\/.+\|\/\*.+\|WebUI.+\n.+\|WebUI.+\|CustomKeywords.*` | Filter relevant code lines |
| **4** | `katalon_code_pattern` | `(\w+)\.(\w+)\((.*)\)` | Splitting code into Class, Method, Parameter |
| **5** | `fto_as_param_pat` | `(findTestObject\(.*\))(?=,)` | Detect `findTestObject()` as the first parameter with positive lookahead for a comma |
| **6** | `ftd_as_param_pat` | `(findTestData\(.*\))(?=,)` | Detect `findTestData()` as the first parameter with positive lookahead for a comma |
| **7** | `param_pattern` | `,\s+(?=false)\|(!\]),\s(?=Fail.*)\|(?<![a-zA-Z]),\s(?!\s)(?![a-zA-Z])\|,\s(?=null)\|,\s+(?=\[)` | Split parameters when multiple are present |
| **8** | `fto_param_str_pattern`| `(findTestObject\(('.+').*\))` | Extract `findTestObject()` with string argument for transformation |
| **9** | `ftd_param_str_pattern`| `findTestData\(('.+').*\)\.getValue\((.+)\))` | Extract `findTestData()` with string and `getValue()` argument |
| **10**| `GlobalVariable_pattern`| `GlobalVariable\.([A-Za-z_][A-Za-z0-9_]*)` | Normalize global variables |
| **11**| `abn_test_pat` | `String\s\w+\s=\|if\(|TestObject\s\w+\s=` | Detect custom user code |

---

# Page 28 & 29: Chapter 5: Implementation

## 5 Implementation
This chapter describes the technical implementation of the migration tool: its directory structure, the separation between migration and runtime code, and the tasks of the individual pipeline modules.

### 5.1 Project Structure of the Migrator
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

The structure separates responsibilities: `pipeline/` performs the entire transformation during Build-Time, `runtime/` bundles the dependencies to be copied to the target project, and `utils/` provides shared utility functions.

#### 5.1.1 Build-Time vs. Runtime
For the migrator to function, a distinction must be made between Build-Time and Runtime code. *Build-Time* refers to the execution of the migrator itself. *Runtime*, on the other hand, refers to the later point in time when the generated tests are executed in the target project using Selenium.

The files in the `src/runtime/` folder are not part of the migration pipeline; they are only needed in the target project. They contain Selenium WebDriver dependencies that are not installed at the time of migration. If they were kept as standard Python files in the repository, the compiler would report import errors when analyzing the migrator project. Therefore, runtime files carry the extension `.template` and are ignored by the compiler. `copy_runtime_files.py` copies them during Build-Time to the target project, removing the extension automatically.

---

### 5.2 Pipeline Modules in Detail
The migration pipeline consists of six specialized modules called sequentially by `main.py`. Each module is responsible for exactly one transformation:

* `test_suite_translator.py` is the entry point of the pipeline. It recursively traverses the `Scripts/` folder of the Katalon project, filters out `.groovy` files, and delegates each file to `test_transpiler.py` and `test_assembler.py`. The directory structure of the Katalon project is mirrored in the target structure `src/tests/`. Tests that cannot be fully translated are placed in `src/unreadable_tests/`.
* `test_transpiler.py` performs the actual syntactic transformation. It applies the regex patterns documented in Table 1 to the Groovy code, detects Katalon method calls, and translates them step-by-step into Python equivalents. The result is a list of already transformed lines of code.
* `test_assembler.py` takes the transpiled lines and assembles them into a complete Python-Pytest test class. It adds the necessary imports (`pytest`, `selenium`, `katalon_helpers`, `base_test`, `global_variables`), generates the class structure with `BaseTest` inheritance, and wraps the test logic in a `test_` method.
* `object_repo_converter.py` converts all `.rs` files in the `Object Repository/` folder from XML to JSON. The internal `WebElementEntity` structure is preserved; only the file format changes. The result is saved under `src/object_repository/`.
* `global_vars_generator.py` reads `Profiles/default.glbl` (an XML file with `GlobalVariableEntity` entries) and generates `src/profiles/global_variables.py`—a Python class `GlobalVariables` with class variables for each global variable of the Katalon project.
* `variables_extractor.py` reads the `.tc` metadata files of the Test Cases and extracts test-specific variables. For each test with variables, a dedicated Python file is generated under `src/variables/`, providing the variables as a Python class.
* `copy_runtime_files.py` completes the migration: it copies `base_test.py.template` and `katalon_helpers.py.template` into `src/runtime/` of the target project (removing the template extension) and generates the configuration files `pytest.ini`, `requirements.txt`, `.gitignore`, and `README.md` in the root directory.

---

# Page 30 to 32: Chapter 6: Evaluation & Chapters 7-8

## 6 Evaluation
To evaluate the migration tool, the Katalon sample project `sample-website-katalon-tests` was used. It contains real end-to-end tests, an Object Repository, a global variable profile, and an integrated CSV data file. The migration was performed on a Windows 11 machine with Python 3.13.0 and pytest 8.4.1.

### 6.1 Migration Results
Running the migrator (`python main.py`) yields the following results:

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

## 7 Discussion
*(Placeholder for discussion section)*

## 8 Conclusion & Future Work
*(Placeholder for conclusion and future prospects)*

---

# Page 33: Bibliography (Quellenverzeichnis)

*(Preserved exact bibliographic entries with English system labels)*

* **[1]** Katalon, Inc., "Katalon | The AI Platform for Software Quality". Accessed: July 21, 2026. [Online]. Available: `https://katalon.com/`
* **[2]** International Software Testing Qualifications Board, "ISTQB Glossary". Accessed: July 22, 2026. [Online]. Available: `https://glossary.istqb.org/`
* **[3]** A. Sahay, A. Indamutsa, D. Di Ruscio, and A. Pierantonio, "Supporting the Understanding and Comparison of Low-Code Development Platforms", in *Proceedings of the 46th Euromicro Conference on Software Engineering and Advanced Applications (SEAA)*, IEEE, 2020, pp. 171–178. doi: `10.1109/SEAA51224.2020.00036`.
* **[4]** C. Shapiro and H. R. Varian, *Information Rules: A Strategic Guide to the Network Economy*. Boston: Harvard Business School Press, 1998.
* **[5]** pytest development team, "Pytest Documentation: Configuration". Accessed: July 24, 2026. [Online]. Available: `https://docs.pytest.org/en/stable/reference/customize.html`
* **[6]** pytest development team, "Pytest Documentation: Good Integration Practices". Accessed: July 24, 2026. [Online]. Available: `https://docs.pytest.org/en/stable/explanation/goodpractices.html`
* **[7]** Python Packaging Authority, "Python Packaging User Guide: src layout vs flat layout". Accessed: July 24, 2026. [Online]. Available: `https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/`
* **[8]** pytest development team, "Pytest Documentation: Fixtures Reference". Accessed: July 24, 2026. [Online]. Available: `https://docs.pytest.org/en/stable/reference/fixtures.html`
* **[9]** J. E. Friedl, *Mastering Regular Expressions*, 3rd ed. Sebastopol, CA: O'Reilly Media, 2006.

---

# Page 34: Declaration of Authorship

## Declaration of Authorship

I hereby declare that I have written the present thesis independently and without external assistance, and that I have used no other sources and aids than those indicated. All passages taken literally or in spirit from other works have been marked as such, indicating the sources.

$$\text{HTW Berlin, 01.08.2026}$$

$$\text{___________________________} \quad \text{___________________________} \quad \text{___________________________}$$  
$$\text{Place} \qquad\qquad\qquad\quad \text{Date} \qquad\qquad\qquad\quad \text{Original Signature}$$

---

I hope this complete translation helps you with your presentation or paper! Let me know if you would like me to format specific chapters or sections in another way.