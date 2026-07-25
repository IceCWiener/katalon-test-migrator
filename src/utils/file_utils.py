import os
import json
import xmltodict
from src.utils.xml_utils import get_xml_as_json
from src.utils.string_utils import change_var_name


def _touch_init(folder_path: str) -> None:
    """Create an empty __init__.py in folder_path if one doesn't already exist."""
    init_file = os.path.join(folder_path, "__init__.py")
    if not os.path.exists(init_file):
        open(init_file, 'w').close()


def read_file(file_path: str) -> str:
    """
    Read the content of a given file.
    
    Args:
        file_path: Path to the file to be read.
        
    Returns:
        Content of the file as a string, or empty string if not found.
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            file_content = file.read()
            return str(file_content)
    except FileNotFoundError:
        print("File was not found")
        return ""


def read_csv_return_column_values(file_path: str, column_name: str) -> list[str]:
    """
    Read CSV file and return values from specified column.
    
    Args:
        file_path: Path to csv file.
        column_name: Header of column to read values from.

    Returns:
        List of values from the column.
    """
    values: list[str] = []
    with open(file_path, "r") as f:
        lines = f.readlines()
        columns = lines[0].strip().split(",")
        if column_name not in columns:
            print("Column [" + column_name + "] not found in the CSV file.")
            return []
        index = columns.index(column_name)
        for line in lines[1:]:
            values.append(line.strip().split(",")[index])
                
    return values


def get_variables_from_tc(test_case_path: str) -> list:
    """
    Extract variables from the corresponding .tc file in source Test Cases.
    
    Args:
        test_case_path: Path to the test case script (groovy file)
        
    Returns:
        List of [name, defaultValue] pairs
    """
    variables = []
    normalized = test_case_path.replace("/", "\\")
    marker = "\\Scripts\\"
    if marker not in normalized:
        return variables

    source_root, rel_script_path = normalized.split(marker, 1)
    rel_script_folder = os.path.dirname(rel_script_path)
    tc_path = os.path.join(source_root, "Test Cases", rel_script_folder + ".tc")

    if not os.path.exists(tc_path):
        return variables

    tc_content = read_file(tc_path)
    if not tc_content:
        return variables

    try:
        decoded_tc = xmltodict.parse(tc_content)
    except Exception:
        return variables

    test_case_entity = decoded_tc.get("TestCaseEntity", {})
    tc_variables = test_case_entity.get("variable")
    if not tc_variables:
        return variables

    if isinstance(tc_variables, list):
        for var in tc_variables:
            variables.append([var.get("name"), var.get("defaultValue")])
    elif isinstance(tc_variables, dict):
        variables.append([tc_variables.get("name"), tc_variables.get("defaultValue")])
          
    return variables
