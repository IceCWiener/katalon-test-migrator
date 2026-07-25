import os
import json
from src.utils.xml_utils import get_xml_as_json
from src.utils.string_utils import change_var_name
from src.utils.file_utils import _touch_init, read_file


def create_variables_as_py(source_root: str, destination_root: str) -> None:
    """
    Extract variables from Katalon Test Cases (.tc files) and generate
    Python variable modules in the destination project.
    
    Args:
        source_root: Root folder of the source Katalon project.
        destination_root: Root folder of the destination project.
    """
    input_path = os.path.join(source_root, "Test Cases")
    output_path = os.path.join(destination_root, "src", "variables")
    file_count = 0
    folder_count = 0
    
    for root, dirs, files in os.walk(input_path):
        for file in files:
            source_file_path = os.path.join(root, file)
            # Read .tc xml, skip if it's not containing variables and translate to json
            content = get_xml_as_json(source_file_path)
            if content == "source xml was empty" or not content.__contains__("variable"):
                continue

            rel_parent = os.path.dirname(os.path.relpath(source_file_path, input_path))
            parent_parts = [] if rel_parent in ("", ".") else rel_parent.split("\\")
            normalized_parts = [change_var_name(part) for part in parent_parts]
            destination_parent = os.path.join(output_path, *normalized_parts)
            if not os.path.exists(destination_parent):
                folder_count += 1
            os.makedirs(destination_parent, exist_ok=True)

            var_name = change_var_name(file)
            new_content = f"class {var_name}:\n"
            decoded_json = json.loads(content)
            
            for var in decoded_json["TestCaseEntity"]["variable"]:
                if type(var) is not str:
                    new_content += (f"\t{var['name']} = {var['defaultValue']}\n")
                else:
                    new_content += (f"\t{decoded_json['TestCaseEntity']['variable']['name']} = {decoded_json['TestCaseEntity']['variable']['defaultValue']}")
                    break

            new_filename = "var_" + change_var_name(file) + ".py"
            new_file_path = os.path.join(destination_parent, new_filename)

            file_count += 1
            with open(new_file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)

    print(f"Variables: {file_count} files generated, {folder_count} folders created")
