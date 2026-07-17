# Introduction 
Welcome to our Selenium-PyTest project. This project is a test automation framework designed to validate functionality in a web-based application.

# Getting Started
## 1.	Installation process
   - Clone repo:
       - Navigate to your project directory and clone the Git repository using SSH:
        
         ```shell
         git clone 'git@ssh.dev.azure.com:v3/de-deloitte/GCM/Global%20Advantage%20Selenium%20PyTests'
         ```

   - Create and activate virtual environment:
       - Use the following command to create a virtual environment (replace `/path/to/new/virtual/environment` with the path to the cloned repository or `.venv` when you're already in the path):

         ```shell
         python -m venv .venv
         ```
       - To activate the virtual environment, run:
         ```shell
         .venv\Scripts\activate
         ```

## 2.	Software dependencies
   - Install the dependencies using:

      ```shell
      python -m pip install -r requirements.txt
      ```
## 3.	Latest releases
## 4.	API references

## 5. Build and Test
  - Build a basic test:
    - Import the necessary modules. In this case, we need `selenium webdriver` for web automation, the supporting modules `Helper_Functions` and `Selenium_Helper`, the URL which we get as imported `BaseUrl` from the `conftest.py` inside the root dir, and the `time` module.
      
      ```python
      import time
      from selenium import webdriver
      from Helper.Helper_Functions import Helper_Functions
      from conftest import BaseUrl
      from Helper.Selenium_Helper import Selenium_Helper 
      ```
    - Define a setup function. This function sets up the Selenium WebDriver, which is used to automate browser actions. In this case, we’re using Chrome as the browser.
      
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
