import os
import xmltodict

from pathlib import Path
from src.utils.xml_utils import to_python_literal, normalize_identifier
from src.utils.file_utils import _touch_init


def create_global_variables_file(source_project_root: str, destination_project_root: str) -> str:
    """
    Generate src/profiles/global_variables.py from Katalon default.glbl profile.

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
    _touch_init(destination_dir)
    destination_file = os.path.join(destination_dir, "global_variables.py")

    lines = [
        "class GlobalVariables:",
        "    \"\"\"Generated from Katalon global variables profile.\"\"\"",
    ]

    if not entities:
        lines.append("    pass")
    else:
        for item in entities:
            name = normalize_identifier(str(item.get("name", "UNNAMED")))
            value = to_python_literal(item.get("initValue"))
            lines.append(f"    {name} = {value}")

    lines.append("")

    with open(destination_file, "w", encoding="utf-8") as out_file:
        out_file.write("\n".join(lines))

    return os.path.abspath(destination_file)
