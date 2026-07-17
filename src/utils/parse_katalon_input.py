import re
from src.translation.WriteTest import WriteTest as WriteTest


def read_file(groovy_file_path: str) -> str:
    with open(groovy_file_path, "r", encoding='utf-8') as file:
        content = file.read()

    return content

'''
This splits the Katalon Test code into lines, reads and segments method names and writes them into a newly created file as a Selenium based PyTest
param: katalon_test: A String containing a full Katalon Studio test 
'''
def parse_katalon_test(katalon_test: str, test_name: str, test_path: str) -> str:
    #bcs = BlockCommentSkipper()
    wt = WriteTest(test_name, test_path)
    # TODO: Read and evaluate all lines, not just the ones starting with WebUI.
    comment_pattern = "/\\*[^*]*\\*+(?:[^/*][^*]*\\*+)*/"# This must not be a raw r"..." pattern to work # TODO?: Add method to add comments to generated tests
    default_katalon_lines_pattern = r'\/\*|\/\/.+|\/\*.+|WebUI.+\n.+|WebUI.+|CustomKeywords.*' # Ignores custom methods and imports
    
    # Scan and modify raw test strings
    private_method_pat = r"private void .*{\n[\s\w.\(\)=\"\,'\/\[+@\-\]\\;\<{}]*\n}"
    custom_methods = re.findall(private_method_pat, katalon_test) # Custom methods are being saved and added to the test afterwards
    custom_methods_string = ""
    custom = False
    for x in custom_methods:
        custom_methods_string += x

    if custom_methods_string != "":
        custom = True
        custom_methods_string = "\n\n\"\"\"" + custom_methods_string + "\"\"\""

    katalon_test = re.sub(private_method_pat, "", katalon_test) # Get rid of custom methods for the line scan algorithm
    katalon_test = re.sub(comment_pattern, "", katalon_test) # Get rid of block comments
    content_lines = re.findall(default_katalon_lines_pattern, katalon_test)
    
    for line in content_lines:

        #if re.match(r"\/\/", line): continue # Ignore comments 
        # if re.search(r"\*\/\n", line):  # Look for a missing newline after an ending block comment, split and reintegrate  
        #     split_lines = re.split(r"(?<=\*\/)\n", line)
        #     line = split_lines[0]
        #     content_lines.insert(line_count, split_lines[1])
        # line = bcs.skip_block_comments(line)
        # if line == "": continue

        method_name = wt.filterTestMethod(line.strip(), "WebUI.")
        result = wt.compareAvailableMethods(method_name)
        if result == True:
            class_name, method_name, parameters = wt.categorize_test_line(line.strip())
            for i in range(len(parameters)): 
                parameters[i] = cast_parameter(parameters[i])
            if wt.translate_methods_list.__contains__(method_name):
                try:
                    wt.check_param_amount_and_execute(method_name, test_path, *parameters)
                except:
                    return "ERROR Test too complex to translate"
            else:
                print(f"ERROR: Method '{method_name}' is missing in list of translateable methods in WriteTest.py")
        elif line.strip().startswith("CustomKeywords."):
            wt.file_content_tests.append(f"# WARNING: CustomKeyword not translated — {line.strip()}")

    content = wt.get_structured_content()
    if custom:
        content = "ERROR: Some methods could not be properly translated\n\n" + content + custom_methods_string # Add custom methods to the end of the test

    return content
    
def get_katalon_test_name(test: str) -> str:
    #'src\\Tests\\katalon structure\\Scripts\\Assignments Tests\\Assignment create screen fields-Angelica - Copy\\Script1695201090830.groovy'
    name = test.split("\\")[-2]

    return name

# Casts numbers in parameter into ints or floats instead of letting them stay as a string
def cast_parameter(param):
    if re.match(r"\d+\.", param):
        param = float(param)
    #elif re.match(r"\d+\)|\d+\,", param):
    #    param = int(param)
    elif param == '':
        param = None

    return param

def translate_katalon_test(katalon_test_path: str):
    #print(f"\n#### [ START ] translate_groovy_to_python(groovy_file_path:{groovy_file_path})")
    #print("... reading groovy file.")
    test_name = get_katalon_test_name(katalon_test_path)
    katalon_test = read_file(katalon_test_path)
    error_content = ""
    content: str = parse_katalon_test(katalon_test, test_name, katalon_test_path)

    # Check for handwritten abnormal tests
    abn_test_pat = r"String\s\w+\s=|if\(|TestObject\s\w+\s="
    if re.search(abn_test_pat, katalon_test) or content.startswith("ERROR"):
        error_content = "ERROR: This test is not automatically translateable because it has handwritten features. Origin: " + katalon_test_path + "\n\n\n" + katalon_test
    
    return content, error_content #, test_name
    #print(groovy_code)
    #print("\n" + ("#### # " * 10) + "\n")

    #print("... parsing groovy code.")
    #parsed_lines = parse_katalon_test(groovy_code)
    #print(parsed_lines)
    #print("\n" + ("#### # " * 10) + "\n")

    #re_pattern = r"WebUI\.(\w+)\((.*?)\)"
    #groovy_methods = re.findall(re_pattern, groovy_code)
    #print(groovy_methods)
    #print("\n" + ("#### # " * 10) + "\n")
    #print("\n#### [ END ] translate_groovy_to_python\n\n")

    #return groovy_methods

# if __name__ == "__main__":
#     print("\n\n---- ---- ---- START ---- ---- ----\n")
#     translate_katalon_test("src\Tests\katalon structure\Scripts\Assignments Tests\Assignment create screen fields-Angelica - Copy\Script1695201090830.groovy")
#     #translate_groovy_to_python(
#     #    "..\\data\\input\\Katalon\\Groovy_scripts\\Test_SSO_Login.groovy"
#     #)
#     # translate_groovy_to_python(
#     #     "C:\\GCM\\Global%20Advantage%20Selenium%20PyTests\\data\\input\\Katalon\\Groovy_scripts\\Test_SSO_Login.groovy"
#     # )
#     print("\n---- ---- ---- END ---- ---- ----\n\n")
#     # pass
