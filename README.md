# Katalon Test Migrator

A tool to convert Katalon Groovy test scripts to Selenium pytest tests.

## Overview

This migrator translates Katalon test automation projects into standalone Selenium pytest projects. It handles:

- **Test script translation**: Groovy `WebUI.*` calls → Python Selenium equivalents
- **Object repository conversion**: Katalon `.rs` XML files → JSON object definitions
- **Variable extraction**: Katalon test case variables → Python class definitions
- **Global variables**: Katalon `.glbl` profiles → `GlobalVariables` Python class
- **Data file mapping**: Referenced CSV files → copied to destination repo
- **Runtime helpers**: Base test class, object/data lookup utilities, pytest config

## Setup

1. Clone and set up:
   ```powershell
   git clone https://github.com/IceCWiener/katalon-test-migrator.git
   cd katalon-test-migrator
   python -m venv .venv
   .venv\Scripts\Activate.ps1
   python -m pip install -r requirements.txt
   ```

## 2. Configuration

Edit `main.py` with your project paths:

```python
source_root = r"C:\Repos\sample-website-katalon-tests"
destination_root = r"C:\Repos\sample-website-selenium-tests"
```

## 3. Run the migrator

```powershell
python main.py
```

## Output

The generated project in `destination_root` will contain:

- `src/tests/`: translated pytest test modules
- `src/object_repository/`: converted object repository (JSON format)
- `src/profiles/global_variables.py`: generated global variable definitions
- `data/`: copied data files
- `pytest.ini`: pytest configuration
- `requirements.txt`: runtime dependencies
- `README.md`: quick setup guide for the generated project
- `.gitignore`: standard Python ignores

## Project structure

```
src/
  utils/              # Migrator orchestration and runtime helpers
    helper_functions.py      # Migrator-only: orchestration, variable extraction
    katalon_helpers.py       # Runtime: object/data lookup (copied to dest)
    xml2json.py              # Migrator-only: XML parsing, global variable generation
    copy_utility_files.py    # Migrator: file copying and destination setup
    parse_katalon_input.py   # Migrator-only: Groovy parsing
  translation/        # Translation layer
    WriteTest.py       # Migrator-only: Groovy-to-pytest code generation
  Object Repository/  # Source Katalon object definitions (for reference)
data/                 # Source data files
profiles_glbl/        # Source Katalon global variable profiles
```

## Notes

- Unreadable test cases (translation failures) are placed in `src/unreadable_tests/` with error messages
- Local test case variables are prefixed with `vars.` and extracted from matching `.tc` files
- Global variables are converted to uppercase identifiers (e.g., `url` → `URL`) 
      
      ```python
      def test_launchBrowser_with_options():
        username = Helper_Functions.read_current_user()
        global options
        options = Selenium_Helper.set_launchoptions_chrome(username)
        global driver
        driver = webdriver.Chrome(options=options)
        time.sleep(5) # NOTE: Driver needs a few seconds.
      ```
    - Define a test case. In this case, the function uses the driver to open the imported URL `BaseUrl`.
      > [!NOTE]
      A test case is a function which name starts or ends with the term `test`, so `pytest` can recognize it as a test.

      ```python
      def test_resolveUrl():
        driver.get(BaseUrl)
      ```
    - Define a cleanup after test. The function quits the driver, effectively cleaning up after the test.

      ```python
      def test_tearDown():
        driver.quit()
      ```
  - Run test:
    - To start a test like basic test-module `test_Click_single_element.py`, run the following command from `root`:
      
      ```shell
      python -m pytest "src\Tests\test_Click_single_element.py" -v 
      ```
    -  Or inside vsCode in the 'Testing' section, via play icon next to test name:

        ![alt text](data\img\vscode_run_basic_test.png)



# Contribute
#[ ] TODO: Explain how other users and developers can contribute to make your code better. 
