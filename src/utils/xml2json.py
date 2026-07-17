import xmltodict
import json
import os
import re
from pathlib import Path


def write_xml_to_json(xml_file_path, json_file_path):
    with open(xml_file_path, "r", encoding="utf-8") as xml_file:
        xml_str = xml_file.read()
        if not xml_str.__contains__("xml"):
            xml_str = "Source file was empty"
        try:    
            data_dict = xmltodict.parse(xml_str)
        except SyntaxError as e:
            xml_str = "Source was empty"
            data_dict = xmltodict.parse(xml_str)

        json_data = json.dumps(data_dict, indent=4)

    with open(json_file_path, "w", encoding="utf-8") as json_file:
        json_file.write(json_data)

def get_xml_as_json(xml_file_path):
    with open(xml_file_path, "r", encoding="utf-8") as xml_file:
        xml_str = xml_file.read()
        if xml_str:
            data_dict = xmltodict.parse(xml_str)
            json_data = json.dumps(data_dict, indent=4)
            
            return json_data

        #print("XML WAS EMPTY: " + xml_file_path)
        return "source xml was empty"
    
def create_object_repository(source_root, destination_root):
    input_path = os.path.join(source_root, "Object Repository")
    output_path = os.path.join(destination_root, "src", "object_repository")
    file_count = 0
    for dir_path, dirs, files in os.walk(input_path):
        for dir in dirs:
            source_path = os.path.join(dir_path, dir)
            destination_path = os.path.join(output_path, os.path.relpath(source_path, input_path))
            os.makedirs(destination_path, exist_ok=True)

        for file in files:
            if file.endswith(".rs"):
                source_file_path = os.path.join(dir_path, file)
                new_file_path = os.path.join(output_path, os.path.relpath(source_file_path, input_path))
                write_xml_to_json(source_file_path, new_file_path)
                file_count += 1

    print(f"Object repository: {file_count} files converted")

def create_global_variable_profiles(source_root_folder: Path): # i. e. C:\Repos\GCM-Katalon-Tests\Web UI Test\Profiles
    for file in os.listdir(source_root_folder / "Profiles"):
        rel_path = os.path.join(source_root_folder / "Profiles", file)
        if os.path.isfile(rel_path):
            file: str = file.replace('.glbl', '.json')
            write_xml_to_json(rel_path, ("src\\profiles\\json\\" + file))


def _to_python_literal(value):
    if value is None:
        return "None"

    text = str(value).strip()
    lowered = text.lower()

    if lowered == "null":
        return "None"
    if lowered == "true":
        return "True"
    if lowered == "false":
        return "False"

    if (text.startswith("'") and text.endswith("'")) or (text.startswith('"') and text.endswith('"')):
        return repr(text[1:-1])

    if re.fullmatch(r"-?\d+", text):
        return text

    if re.fullmatch(r"-?\d+\.\d+", text):
        return text

    return repr(text)


def _normalize_identifier(name: str) -> str:
    normalized = re.sub(r"\W+", "_", name)
    if not normalized:
        normalized = "UNNAMED"
    if normalized[0].isdigit():
        normalized = f"VAR_{normalized}"
    return normalized.upper()


def create_global_variables_file(source_project_root: str, destination_project_root: str) -> str:
    """
    Generate src/profiles/global_variables.py in a destination project root
    by reading Profiles/default.glbl (XML) from the source project root.

    Args:
        source_project_root: Root folder of the source Katalon project.
        destination_project_root: Root folder of the destination project.

    Returns:
        Absolute path of the generated global_variables.py file.
    """
    glbl_path = os.path.join(source_project_root, "Profiles", "default.glbl")

    if not os.path.isfile(glbl_path):
        raise FileNotFoundError(f"Could not find default.glbl at: {glbl_path}")

    with open(glbl_path, "r", encoding="utf-8") as glbl_file:
        xml_str = glbl_file.read()

    profile_data = xmltodict.parse(xml_str)
    entities = profile_data.get("GlobalVariableEntities", {}).get("GlobalVariableEntity", [])
    if isinstance(entities, dict):
        entities = [entities]

    destination_dir = os.path.join(destination_project_root, "src", "profiles")
    os.makedirs(destination_dir, exist_ok=True)
    destination_file = os.path.join(destination_dir, "global_variables.py")

    lines = [
        "class GlobalVariables:",
        "    \"\"\"Generated from Katalon JSON global variables profile.\"\"\"",
    ]

    if not entities:
        lines.append("    pass")
    else:
        for item in entities:
            name = _normalize_identifier(str(item.get("name", "UNNAMED")))
            value = _to_python_literal(item.get("initValue"))
            lines.append(f"    {name} = {value}")

    lines.append("")

    with open(destination_file, "w", encoding="utf-8") as out_file:
        out_file.write("\n".join(lines))

    return os.path.abspath(destination_file)


if __name__ == "__main__":
    pass
