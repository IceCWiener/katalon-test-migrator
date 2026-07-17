import os
import json
import csv

from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium import webdriver

def find_katalon_test_object(driver, path: str) -> WebElement:
        # Check if path already contains "object_repository"
        if path.__contains__("object_repository") == False:
            path = os.path.abspath('src/object_repository/' + path + '.rs')
        else:
            path = os.path.abspath('src/' + path + '.rs')

        with open(path, 'r') as f:
            json_content = f.read()
        decoded_json = json.loads(json_content)
        driver = driver
        selector_type = decoded_json['WebElementEntity']['selectorMethod']
        selector_value = ""

        # Getting the value associated with the selector method
        entries = decoded_json['WebElementEntity']['selectorCollection']['entry']
        if isinstance(entries, dict):
            entries = [entries]

        for collection in entries:
            if collection.get('key') == selector_type:
                selector_value = collection.get('value', "")
                break

        if not selector_value:
            raise ValueError(f"Selector '{selector_type}' not found in object file: {path}")

        match selector_type:
            case "CSS":
                element = driver.find_element(By.CSS_SELECTOR, selector_value)

                return element 
            case _: # For XPATH and BASIC attributes
                element = driver.find_element(By.XPATH, selector_value)

                return element
             
def find_katalon_test_data(*args) -> str:
    # Support both call styles: (csv_name, column, row) and (driver, csv_name, column, row)
    if len(args) == 3:
        csv_name, column, row = args
    elif len(args) == 4:
        _, csv_name, column, row = args
    else:
        raise TypeError('find_katalon_test_data expects 3 or 4 positional arguments')

    csv_path = os.path.abspath(f'data/{csv_name}.csv')
    
    if not os.path.exists(csv_path):
        raise FileNotFoundError(f'CSV file not found: {csv_path}')
    
    with open(csv_path, 'r', newline='') as file:
        csv_reader = list(csv.reader(file))
        
    if row >= len(csv_reader):
        raise IndexError(f'Row {row} out of range in CSV file')
    
    row_data = csv_reader[row]
    
    # Katalon data column indexes are typically 1-based; keep 0 as a valid direct index.
    column_index = column - 1 if column > 0 else column

    if column_index >= len(row_data):
        raise IndexError(f'Column {column} out of range in CSV row')
    
    return row_data[column_index]
