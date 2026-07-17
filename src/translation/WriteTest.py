import re
import src.utils.helper_functions as hf
import src.utils.katalon_helpers as kh


class WriteTest:
    """Class used by translate_groovy2python.py to translate groovy selenium-test functionality into pytest."""
    # TODO: Implement logging

    def change_test_name(self, test_name: str) -> str:
        test_name = test_name.replace(' ', '_')
        test_name = test_name.replace(',', '_')
        test_name = test_name.replace('-', '')

        return test_name

    def __init__(self, test_case_name: str, test_path: str):
        test_case_name = self.change_test_name(test_case_name)
        self.var_present = False
        self.var_folder = test_path.split("\\")[-3]
        if self.var_folder == "variables":
            self.var_folder = ""
        else:
            self.var_folder = self.change_test_name(self.var_folder) + "."
        self.var_file_name = test_case_name

        self.file_content_imports = [
            "import pytest",
            "import time",
            "import src.utils.katalon_helpers as kh",
            "from src.tests.base_test import *",
            "from src.profiles.global_variables import GlobalVariables as GlobalVariable",
            "from selenium.webdriver.support.ui import Select",
        ]

        self.file_content_class = [
            "class Test_" + test_case_name + "(BaseTest):"
        ]

        self.file_content_init = [""]
        
        self.file_content_tests = [
            f"\tdef test_{test_case_name}(self):"
        ]

        # List of availible translated functions
        self.translate_methods_list = [ 
            "openBrowser",
            "closeBrowser",
            "navigateToUrl",
            "maximizeWindow",
            "click",
            #"clickTestObject",
            "delay",
            "executeJavaScript",
            "findWebElements",
            "getAttribute",
            "getText",
            "refresh",
            "scrollToElement",
            "selectOptionByValue",
            "sendKeys",
            "setText",
            "setViewPortSize",
            "takeFullPageScreenshot",
            "uploadFile",
            "verifyElementAttributeValue",
            "verifyElementNotPresent",
            "verifyElementPresent",
            "verifyMatch",
            "verifyNotMatch",
            "verifyTextNotPresent",
            "verifyTextPresent",
            "waitForElementPresent",
            "clearText",
            "comment",
            "findTestObject",
            "callTestCase",
            "findTestData",
        ]

    ### methods

    def openBrowser(self, *args):
        self.file_content_tests.append("")

    def closeBrowser(self, *args):
        return ""

    def navigateToUrl(self, url: str, *args):
        stripped_url = url.strip()
        if not (
            stripped_url.startswith(("'", '"')) and stripped_url.endswith(("'", '"'))
        ) and "GlobalVariable." not in stripped_url and "vars." not in stripped_url:
            url = "'" + url + "'"
        self.file_content_tests.append(
                f"self.driver.get({url})"
        )

    def maximizeWindow(self):
        self.file_content_tests.append(
            "self.driver.maximize_window()"
        )

    def click(self, to, *args): # TODO: Add 'FailureHandling.STOP_ON_FAILURE' handling
        self.file_content_tests.append(
            f"{to}.click()"
        )

    def delay(self, time, *args):
        self.file_content_tests.append(
            f"time.sleep({time})"
        )

    def executeJavaScript(self, js: str, opt_args: str):
        self.file_content_tests.append(
            f"self.driver.execute_script({js}, {opt_args})"
        )

    def findWebElements(self, to):
        self.file_content_tests.append(
            f"self.driver.find_elements({to})"
        )

    def getAttribute(self, to, *att):
        self.file_content_tests.append(
            f"{to}.get_attribute({att})"
        )

    def getText(self, to):
        self.file_content_tests.append(
            f"{to}.text"
        )

    # TODO: Add 'FailureHandling.STOP_ON_FAILURE' handling
    def refresh(self, *args):
        self.file_content_tests.append(
            "self.driver.refresh()"
        )

    def scrollToElement(self, to, *args):
        self.file_content_tests.append(
            f"self.driver.execute_script('argument[0].scrollIntoView();', {to})"
        )

    def selectOptionByValue(self, to, val, *args):
        self.file_content_tests.append(
            f"Select({to}).select_by_value({val})"
        )

    def sendKeys(self, to, key, *args):    # Types out the keys
        self.file_content_tests.append(
            f"{to}.send_keys({key})"
        )

    def setText(self, to, text, *args):    # Acts like ctrl+v
        self.file_content_tests.append(
            f"{to}.clear()\n" +
            f"\t\t{to}.send_keys({text})"
        )

    def setViewPortSize(self, x, y):
        self.file_content_tests.append(
            f"self.driver.set_window_size({x}, {y})"
        )

    def takeFullPageScreenshot(self):
        self.file_content_tests.append(
            "self.driver.save_screenshot('screenshot.png')"
        )

    def uploadFile(self, to, path: str):
        if not path.__contains__('GlobalVariable'):
            path = f"'{path}'"
        self.file_content_tests.append(
            f"{to}.send_keys({path})"
        )

    def verifyElementAttributeValue(self, to, att1, att2, *args):
        self.file_content_tests.append(
            f"assert {to}.get_attribute({att1}) == {att2}"
        )

    def verifyElementNotPresent(self, to, token, *args):
        self.file_content_tests.append(
            f"assert {to} == None"
        )

    def verifyElementPresent(self, to, *args): # TODO: Add minimum count functionality i. E. WebUI.verifyElementPresent(findTestObject('Page_Assignment Details/Unlimited Tax Payer'), 10, FailureHandling.STOP_ON_FAILURE)
        self.file_content_tests.append(
            f"assert {to} != None"
        )

    def verifyMatch(self, att1, *att2): # log is a boolean that sets katalon to log or not. Not used here
        self.file_content_tests.append(
            f"assert {att1} == {att2}"
        )

    def verifyNotMatch(self, att, to, control, *args):
        self.file_content_tests.append(
            f"assert not re.match({control}, {to}.get_attribute({att})) != 0"
        )

    def verifyTextNotPresent(self, text, *args):
        self.file_content_tests.append(
            f"assert {text} not in self.driver.page_source"
        )

    def verifyTextPresent(self, text, *args):  # TODO: needs functionality to link variables i. e. "assignments"
        self.file_content_tests.append(
            f"assert {text} in self.driver.page_source"
        )

    def waitForElementPresent(self, to, time):
            self.file_content_tests.append(
                f"WebDriverWait(self.driver, {time}).until(EC.presence_of_element_located((By.XPATH, {to})))"
            )

    def clearText(self, to):
        self.file_content_tests.append(
            f"{to}.clear()"
        )  

    def comment(self, text):
        self.file_content_tests.append(
            f"return ('#' + {text})"
        )
        
    def callTestCase(self, parameter: str, *opt_vars: str): # Add all callTestCase-Cases (in katalon_helpers.py, too)) i. e. "SSO_Login", "Login_Diogo", "Login_angelica" and so on
        for x in opt_vars:
            parameter += x

        self.file_content_tests.append(
            f"# {parameter}"
        )


    ### Utility methods

    def filterTestMethod(self, file_line: str, line_start: str) -> str:
        method_name = ""
        if file_line.startswith(line_start):
            start_index = file_line.find(line_start) + len(line_start)
            end_index = file_line.find("(", start_index)
            method_name = file_line[start_index:end_index]

        return method_name

    '''
    This takes a katalon test line i. e. WebUI.delay(5), and return the different parts seperated from each other.
    '''
    def categorize_test_line(self, test_line: str):
        class_name = ""
        method_name = ""
        parameters = ""
        test_line = test_line.replace("\n", "").replace("\t", ' ')
        katalon_code_pattern = r"(\w+)\.(\w+)\((.*)\)"
        match = re.match(katalon_code_pattern, test_line)

        if match:
            class_name = match.group(1)
            method_name = match.group(2)
            parameters = match.group(3)
        else:
            class_name = ""
            method_name = ""
            parameters = ""

        param_pattern = r",\s+(?=false)|(?!\]),\s(?=Fail.*)|(?<![a-zA-Z]),\s(?!\s)(?![a-zA-Z])|,\s(?=null)|,\s+(?=\[)"

        fto_as_param_pat = r"(findTestObject\(.*\))(?=,)"
        ftd_as_param_pat = r"(findTestData\(.*\))(?=,)"
        fto_as_parameter = re.match(fto_as_param_pat, parameters)
        ftd_as_parameter = re.match(ftd_as_param_pat, parameters)
        if fto_as_parameter:
            rest: str = parameters.replace(fto_as_parameter.group(1), '')
            parameters = rest.replace(", ", '', 1) 
            parameters = re.split(param_pattern, parameters)
            parameters.insert(0, fto_as_parameter.group(1))
        elif ftd_as_parameter:
            rest: str = parameters.replace(ftd_as_parameter.group(1), '')
            parameters = rest.replace(", ", '', 1) 
            parameters = re.split(param_pattern, parameters)
            parameters.insert(0, ftd_as_parameter.group(1))
        else:
            parameters = re.split(param_pattern, parameters) 

        # Remove leading whitespaces
        for i in range(0, parameters.__len__()):
            parameters[i] = parameters[i].lstrip()
            if parameters[i] == "null":
                parameters[i] = "None"

        return class_name, method_name, parameters

    def compareAvailableMethods(self, method_name: str) -> bool:
        result = False
        if method_name in self.translate_methods_list:
            result = True
        elif method_name:
            print(f"[{method_name}] is an unknown testmethod")

        return result

    def check_param_amount_and_execute(self, method_name, test_path, *method_params):
        if hasattr(self, method_name):
            method_to_execute = getattr(self, method_name)
            if method_params and (method_params[0] != None):
                method_params = self.check_params_for_specialties(method_params, test_path)
                method_to_execute(*method_params)
            else:
                method_to_execute()
        else:
            print(f"Method declaration for {method_name} is missing in WriteTest.py!")

    def check_params_for_specialties(self, params: tuple[str], test_path: str) -> list[str]:
        params_list = list(params)

        plus_concat_pattern = r".*,\s(.*)\+(.*)\)|.*,\s'(.*)'.*\+ '(.*)|(.*)\s\+\s(.*)" #r".*,\s(.*)\+(.*)\)|.*,\s(.*)\+(.*)" # TODO: See if the third regex takes more than it should
        fto_param_str_pattern = r"(findTestObject\(('.+').*\))" #r".*(findTestObject\((\'.+\')\)).*" #r'.*findTestObject\((\'.+\')\).*' # WARNING: This filters out any second parameter of a findTestObject() i. e. fto('test/btn', [:])
        ftd_param_str_pattern = r"(findTestData\(('.+').*\)\.getValue\((.+)\))" # Same as with findTestObject() but for findTestData() - TODO: Implement this in the check_params_for_specialties() method and add a findTestData() method to WriteTest.py, write find_katalon_test_data() in katalon_helpers.py and implement it in the test structure

        for i in range(params.__len__()):
            if type(params_list[i]) == int:
                continue

            var_list = hf.get_variables_from_tc(test_path)
            params_list[i] = self.normalize_global_variables(params_list[i])
            params_list[i] = self.replace_variables(params_list[i], var_list) # variables will be translated without changes now

            '''Checks if the parameters contain findTestObject() and prunes them to fit into the resulting test'''
            to_match = re.search(fto_param_str_pattern, params_list[i])
            if to_match:
                param = "kh.find_katalon_test_object(self.driver, " + to_match.group(2) + ")"
                params_list[i] = params_list[i].replace(to_match.group(1), param)
            '''Checks if the parameters contain findTestData() and prunes them to fit into the resulting test'''
            ftd_match = re.search(ftd_param_str_pattern, params_list[i])
            if ftd_match:
                param = "kh.find_katalon_test_data(self.driver, " + ftd_match.group(2) + ", " + ftd_match.group(3) + ")"
                params_list[i] = params_list[i].replace(ftd_match.group(1), param)

        return params_list

    def normalize_global_variables(self, param: str) -> str:
        return re.sub(
            r"GlobalVariable\.([A-Za-z_][A-Za-z0-9_]*)",
            lambda match: f"GlobalVariable.{match.group(1).upper()}",
            param,
        )

    '''Open .tc file containing json with variables corresponding to current test. Crosscheck existence of variable and replace'''
    def replace_variables(self, param: str, var_list):
        if var_list.__len__() > 0:  # TODO: Fix this replacing variables that are inside strings and not a variable, see here: src\Tests\katalon structure\Scripts\Employees\Employee_CalendarData - David\Script1702483183702.groovy (Employee_CalendarDataFile gets replaced when it shouldn't)
            self.var_present = True

            for i in range(var_list.__len__()):
                if var_list[i][0].__len__() > 2:
                    if param.__contains__(var_list[i][0]):
                        # This looks for the variable name but in a sentence and then skips it i. e. "This assignment needs ..." or "... for this assignment."
                        pattern = r"\s" + var_list[i][0] + r"\s|\s" + var_list[i][0] + r"\."
                        if re.search(pattern, param):
                            continue
                        replacement = var_list[i][1]
                        if re.match(r"'.*(?!.)", replacement):
                            replacement = replacement.replace("'", "")
                        # This now does not replace the variable name with the value but adds a "vars."" before the name
                        #param = param.replace(var_list[i][0], replacement)
                        param = param.replace(var_list[i][0], "vars." + var_list[i][0])
        
        return param
    
    def get_structured_content(self):
        file_content_all_txt = ""

        for entry in self.file_content_imports:
            file_content_all_txt += entry + "\n"

        if self.var_present:
            file_content_all_txt += f"from src.variables.{self.var_folder}var_{self.var_file_name} import {self.var_file_name} as vars"
            self.var_present = False

        file_content_all_txt += "\n"

        for entry in self.file_content_class:
            file_content_all_txt += entry

        for entry in self.file_content_init:
            file_content_all_txt += entry + "\n"

        file_content_all_txt += "\n"

        for test_element in self.file_content_tests:
            if test_element.__contains__("def"):
                file_content_all_txt += test_element + "\n"
                continue

            file_content_all_txt += "\t\t" + test_element + "\n"

        return file_content_all_txt
    