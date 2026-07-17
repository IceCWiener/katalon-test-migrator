import getpass
import json
import os
import re

import xmltodict

import src.utils.parse_katalon_input as g2p
import src.utils.xml2json as x2j


class Helper_Functions:
    """Collection of reocurring non-selenium functions"""

    def contains_script(self, folder_path):
        contains = False
        
        contents = os.listdir(folder_path)
        for item in contents:
            if item.__contains__(".groovy"):
                contains = True
                continue

        return contains

    @staticmethod
    def read_conf_from_json(file_path: str, key: str) -> str:
        """Read configuration from JSON-file.

        Args:
            file_path (str): Filepath to JSON configuration file.
            key (str): JSON-key.

        Returns:
            result(str): JSON-value.
        """
        import json

        result = ""

        with open(file_path, "r") as f:
            config = json.load(f)
        try:
            result = str(config[key])
            print(result)
        except:
            print(f"...unknown key [{key}]")

        return result

    @staticmethod
    def read_current_user() -> str:
        """Return username of current system user

        Returns:
            str: Username
        """
        return getpass.getuser()

    @staticmethod
    def read_csv_return_column_values(
        file_path: str, column_name: str
    ) -> list[str]:  # [ ] TODO: Extended functionality for later implementation.
        """Actual used as pameter value for @pytest.mark.parametrize

        Args:
            file_path (str): Path to csv file.
            column_name (str): Header of column to read values from.

        Returns:
            list(str): List of values.
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

    def readFile(self, file_path) -> str:
        """
        Read the content of a given file.
        :param file_path: Path to the file to be read.
        :return: Content of the file as a string.
        """
        try:
            with open(file_path, 'r') as file:
                file_content = file.read()
                
                return str(file_content)
        except FileNotFoundError:
            print("File was not found")

            return ""
    
    @staticmethod
    def _touch_init(folder_path: str) -> None:
        """Create an empty __init__.py in folder_path if one doesn't already exist."""
        init_file = os.path.join(folder_path, "__init__.py")
        if not os.path.exists(init_file):
            open(init_file, 'w').close()

    def iterate_and_translate_test_cases(self, source_root, destination_root):
        input_path = os.path.join(source_root, "Scripts")
        output_path = os.path.join(destination_root, "src", "tests")
        unreadable_path = os.path.join(destination_root, "src", "unreadable_tests")
        file_count = 0
        folder_count = 0
        unreadable_count = 0
        os.makedirs(output_path, exist_ok=True)
        Helper_Functions._touch_init(output_path)
        for root, dirs, files in os.walk(input_path):
            dirs[:] = [
                dir_name
                for dir_name in dirs
                if dir_name not in ("X_tests_to_translate_by_hand", "unreadable_tests")
            ]
            #Read through folders and create a copied directory system in the ouput path
            for dir in dirs:
                source_path = os.path.join(root, dir)

                # Skip folder creation when they contain a script (the script gets the name of the folder)
                if self.contains_script(source_path):
                    continue

                destination_path = os.path.join(output_path, os.path.relpath(source_path, input_path))
                split = destination_path.split("\\")
                split[-1] = Helper_Functions.change_var_name(split[-1])
                destination_path = "\\".join(split)
                folder_count += 1
                os.makedirs(destination_path, exist_ok=True)
                Helper_Functions._touch_init(destination_path)

            #Read through files, translate them and save to the new directory system
            for file in files:
                error = False
                if file.endswith('.groovy'):
                    source_file_path = os.path.join(root, file)
                    #Read Katalon test, translate and return new Selenium content
                    [content, error_content] = g2p.translate_katalon_test(source_file_path)
                    if error_content.startswith("ERROR"):
                        error = True

                    if error:
                        unreadable_file_path = os.path.join(
                            unreadable_path, os.path.relpath(source_file_path, input_path)
                        )
                        os.makedirs(os.path.dirname(unreadable_file_path), exist_ok=True)
                        with open(unreadable_file_path, 'w', encoding="utf-8") as file:
                            file.write(error_content)
                        unreadable_count += 1
                        continue

                    new_file_path = os.path.join(output_path, os.path.relpath(source_file_path, input_path))
                    #Slice off the last part of the script name i. e. \\Script12321312.groovy to give the test its original name with the added "test_" prefix
                    new_file_path = new_file_path[:-("\\" + file).__len__()] + ".py"
                    split = new_file_path.split("\\")
                    split[-2] = Helper_Functions.change_var_name(split[-2])
                    split[-1] = "test_" + Helper_Functions.change_var_name(split[-1])
                    new_file_path = "\\".join(split)

                    file_count += 1
                    with open(new_file_path, 'w', encoding="utf-8") as file:
                        file.write(content)

        print(
            f"Tests: {file_count} translated, {unreadable_count} unreadable, {folder_count} folders prepared"
        )

    @staticmethod
    def create_variables(input_path, output_path):
        file_count = 1
        folder_count = 1
        for root, dirs, files in os.walk(input_path):
            #Read through folders and create a copied directory system in the ouput path
            for dir in dirs:
                source_path = os.path.join(root, dir)
                destination_path = os.path.join(output_path, os.path.relpath(source_path, input_path))
                print(f"Create new folder copy no. {folder_count} here: " + destination_path)
                folder_count += 1
                os.makedirs(destination_path, exist_ok=True)

            #Read through files, translate them and save to the new directory system
            for file in files:
                source_file_path = os.path.join(root, file)
                #Read .tc xml, skip if it's not containing variables and translate to json
                content = x2j.get_xml_as_json(source_file_path)
                if content == "source xml was empty" or not content.__contains__("variable"):
                    continue

                new_file_path = os.path.join(output_path, os.path.relpath(source_file_path, input_path))
                new_file_path = new_file_path.replace(".tc", ".json")
                print(f"Writing tc variable no. {file_count} here: {new_file_path}")
                file_count += 1
                with open(new_file_path, 'w', encoding='utf-8') as file:
                    file.write(content)

    @staticmethod
    def create_variables_as_py(source_root, destination_root):
        input_path = os.path.join(source_root, "Test Cases")
        output_path = os.path.join(destination_root, "src", "variables")
        file_count = 0
        folder_count = 0
        for root, dirs, files in os.walk(input_path):
            #Read through files, translate them and save to the new directory system
            for file in files:
                source_file_path = os.path.join(root, file)
                #Read .tc xml, skip if it's not containing variables and translate to json
                content = x2j.get_xml_as_json(source_file_path)
                if content == "source xml was empty" or not content.__contains__("variable"):
                    continue

                rel_parent = os.path.dirname(os.path.relpath(source_file_path, input_path))
                parent_parts = [] if rel_parent in ("", ".") else rel_parent.split("\\")
                normalized_parts = [Helper_Functions.change_var_name(part) for part in parent_parts]
                destination_parent = os.path.join(output_path, *normalized_parts)
                if not os.path.exists(destination_parent):
                    folder_count += 1
                os.makedirs(destination_parent, exist_ok=True)

                var_name = Helper_Functions.change_var_name(file)
                new_content = f"class {var_name}:\n"
                decoded_json = json.loads(content)
                for var in decoded_json["TestCaseEntity"]["variable"]:
                    if type(var) is not str:
                        new_content += (f"\t{var['name']} = {var['defaultValue']}\n")
                    else:
                        new_content += (f"\t{decoded_json['TestCaseEntity']['variable']['name']} = {decoded_json['TestCaseEntity']['variable']['defaultValue']}")
                        break

                new_filename = "var_" + Helper_Functions.change_var_name(file) + ".py"
                new_file_path = os.path.join(destination_parent, new_filename)

                file_count += 1
                with open(new_file_path, 'w', encoding='utf-8') as file:
                    file.write(new_content)

        print(f"Variables: {file_count} files generated, {folder_count} folders created")

    @staticmethod
    def change_var_name(test_name: str) -> str:
        test_name = test_name.replace(' ', '_')
        test_name = test_name.replace(',', '_')
        test_name = test_name.replace('-', '')
        test_name = test_name.replace('.tc', '')
        #test_name.capitalize()

        return test_name


# Checks if variables exist by reading the corresponding .tc file in source Test Cases
# TODO: See if this is necessary in the new generated repository, as the base class of GCM_Testing repo makes this unnecessary
def get_variables_from_tc(test_case_path: str):
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

    tc_content = Helper_Functions().readFile(tc_path)
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