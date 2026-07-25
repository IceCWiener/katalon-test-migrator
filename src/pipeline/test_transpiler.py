import re
from src.pipeline.test_assembler import TestAssembler


def read_file(groovy_file_path: str) -> str:
    """Read Groovy test file content."""
    with open(groovy_file_path, "r", encoding='utf-8') as file:
        content = file.read()
    return content


def parse_katalon_test(katalon_test: str, test_name: str, test_path: str) -> str:
    """
    Parse Katalon Groovy test code and transpile to Python Pytest.
    
    Splits test into lines, identifies WebUI method calls, and assembles
    equivalent Selenium WebDriver code.
    """
    assembler = TestAssembler(test_name, test_path)
    
    comment_pattern = "/\\*[^*]*\\*+(?:[^/*][^*]*\\*+)*/"
    default_katalon_lines_pattern = r'\/\*|\/\/.+|\/\*.+|WebUI.+\n.+|WebUI.+|CustomKeywords.*'
    
    # Extract and preserve custom methods
    private_method_pat = r"private void .*{\n[\s\w.\(\)=\"\,'\/\[+@\-\]\\;\<{}]*\n}"
    custom_methods = re.findall(private_method_pat, katalon_test)
    custom_methods_string = ""
    custom = False
    for x in custom_methods:
        custom_methods_string += x

    if custom_methods_string != "":
        custom = True
        custom_methods_string = "\n\n\"\"\"" + custom_methods_string + "\"\"\""

    # Clean and parse test
    katalon_test = re.sub(private_method_pat, "", katalon_test)
    katalon_test = re.sub(comment_pattern, "", katalon_test)
    content_lines = re.findall(default_katalon_lines_pattern, katalon_test)
    
    for line in content_lines:
        method_name = assembler.filterTestMethod(line.strip(), "WebUI.")
        result = assembler.compareAvailableMethods(method_name)
        if result == True:
            class_name, method_name, parameters = assembler.categorize_test_line(line.strip())
            for i in range(len(parameters)): 
                parameters[i] = cast_parameter(parameters[i])
            if assembler.translate_methods_list.__contains__(method_name):
                try:
                    assembler.check_param_amount_and_execute(method_name, test_path, *parameters)
                except:
                    return "ERROR Test too complex to translate"
            else:
                print(f"ERROR: Method '{method_name}' is missing in list of translateable methods in TestAssembler.py")
        elif line.strip().startswith("CustomKeywords."):
            assembler.file_content_tests.append(f"# WARNING: CustomKeyword not translated — {line.strip()}")

    content = assembler.get_structured_content()
    if custom:
        content = "ERROR: Some methods could not be properly translated\n\n" + content + custom_methods_string

    return content

    
def get_katalon_test_name(test: str) -> str:
    """Extract test name from file path."""
    name = test.split("\\")[-2]
    return name


def cast_parameter(param):
    """Cast numeric string parameters to int or float."""
    if re.match(r"\d+\.", param):
        param = float(param)
    elif param == '':
        param = None
    return param


def translate_katalon_test(katalon_test_path: str):
    """
    Main translation function. Converts a Katalon Groovy test file
    to a Python Pytest test file.
    
    Args:
        katalon_test_path: Path to Katalon .groovy test file
        
    Returns:
        Tuple of (python_content, error_message)
    """
    test_name = get_katalon_test_name(katalon_test_path)
    katalon_test = read_file(katalon_test_path)
    error_content = ""
    content: str = parse_katalon_test(katalon_test, test_name, katalon_test_path)

    # Check for handwritten abnormal tests
    abn_test_pat = r"String\s\w+\s=|if\(|TestObject\s\w+\s="
    if re.search(abn_test_pat, katalon_test) or content.startswith("ERROR"):
        error_content = "ERROR: This test is not automatically translateable because it has handwritten features. Origin: " + katalon_test_path + "\n\n\n" + katalon_test
    
    return content, error_content
