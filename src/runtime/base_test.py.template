from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from src.profiles.global_variables import GlobalVariables


class BaseTest:
    """Minimal Selenium base class for generated pytest tests."""

    @classmethod
    def setup_class(cls):
        cls.driver = cls.chrome_configurations()
        cls.driver.maximize_window()
        cls.driver.get(GlobalVariables.URL)

    @classmethod
    def teardown_class(cls):
        driver = getattr(cls, "driver", None)
        if driver is not None:
            driver.quit()

    @staticmethod
    def chrome_configurations():
        options = Options()
        options.add_argument("--start-maximized")
        options.add_argument("--disable-notifications")
        
        return webdriver.Chrome(options=options)
