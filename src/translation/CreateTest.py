from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from src.helper.Selenium_Helper import Selenium_Helper
import re
#DEPRECATED - Do not use
class CreateTest:
    """Class used by script-translated tests to access selenium-pytest functionality with groovy-like function names."""

    def __init__(self):
        self.options = Selenium_Helper.set_launchoptions_chrome(Options())

    def openBrowser(self, url): # Add statement to pass url as option to the webdriver.
        self.driver = webdriver.Chrome(options=self.options)

    def navigateToUrl(self, url: str):
        self.driver.get(url)

    def maximizeWindow(self):
        self.driver.maximize_window()

    def clickTestObject(self, testObject):
        self.driver.find_element_by_xpath(self.findTestObject(testObject).click())

    def click(self, identifier):
        self.driver.find_element_by_identifier(identifier).click()

    def delay(self, seconds):
        self.time.sleep(seconds)

    def executeJavaScript(self, js: str):
        self.driver.execute_script(js)

    def findWebElements(self, testObject):
        self.driver.find_elements_by_xpath(self.findTestObject(testObject))

    def getAttribute(self, testObject, attribute):
        self.driver.find_elements_by_xpath(self.findTestObject(testObject)).getAttribute(attribute)

    def getText(self, testObject):
        self.driver.find_element_by_xpath(self.findTestObject(testObject)).text

    def refresh(self):
        self.driver.refresh()

    def scrollToElement(self, testObject):
        self.driver.execute_script('argument[0].scrollIntoView();', self.driver.find_element_by_xpath(self.findTestObject(testObject)))

    def selectOptionByValue(self, testObject, value):
        self.Select(self.driver.find_element_by_xpath(self.findTestObject(testObject))).select_by_value(value)

    def sendKeys(self, testObject, key):
        self.driver.find_element_by_xpath(self.findTestObject(testObject).send_keys(key))

    def setText(self, testObject, text):
        self.driver.find_element_by_xpath(self.findTestObject(testObject).send_keys(text))

    def setViewPortSize(self, x, y):
        self.driver.set_window_size(x, y)

    def takeFullPageScreenshot(self):
        self.driver.save_screenshot('screenshot.png')

    def uploadFile(self, testObject, key):
        self.driver.find_element_by_xpath(self.findTestObject(testObject).send_keys(key))

    def verifyElementAttributeValue(self, testObject, att1, att2):
        assert self.driver.find_element_by_xpath(self.findTestObject(testObject)).getAttribute(att1) == att2

    def verifyElementNotPresent(self, testObject):
        assert len(self.driver.find_elements_by_xpath(self.findTestObject(testObject))) == 0

    def verifyElementPresent(self, testObject):
        assert len(self.driver.find_elements_by_xpath(self.findTestObject(testObject))) > 0

    def verifyMatch(self, att1, att2):
        assert att1 == att2
    
    def verifyNotMatch(self, attribute, testObject, controlAtt):
        assert not re.match(controlAtt, self.driver.find_element_by_xpath(testObject).getAttribute(attribute)) > 0

    def verifyTextNotPresent(self, text):
        assert text not in self.driver.page_source

    def verifyTextPresent(self, text):
        assert text in self.driver.page_source

    #def waitForElementPresent(self, testObject, timer):
    #    WebDriverWait(self.driver, timer).until(EC.presence_of_element_located((By.XPATH, self.findTestObject(testObject))))

    def clearText(self, testObject):
        self.driver.find_element_by_xpath(self.findTestObject(testObject)).clear()

    def comment(text: str):
        return ("#" + text)

    # def findTestObject(self, xpath_param: str) -> WebElement:
    #     test_object = None
    #     try:
    #         test_object = self.driver.find_element(By.XPATH, xpath_param)
    #     except NoSuchElementException:
    #         print(f"element for [{xpath_param}] not found")

    #     return test_object

    # def setText(self, test_object: WebElement, input_value: str):
    #     test_object = None
    #     try:
    #         test_object.clear()
    #         test_object.send_keys(input_value)
    #     except NoSuchElementException:
    #         print(f"element not found")
