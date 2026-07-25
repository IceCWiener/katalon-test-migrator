import xmltodict
import json
import re


def write_xml_to_json(xml_file_path: str, json_file_path: str) -> None:
    """Convert XML file to JSON and write to destination."""
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


def get_xml_as_json(xml_file_path: str) -> str:
    """Read XML file and return as JSON string."""
    with open(xml_file_path, "r", encoding="utf-8") as xml_file:
        xml_str = xml_file.read()
        if xml_str:
            data_dict = xmltodict.parse(xml_str)
            json_data = json.dumps(data_dict, indent=4)
            return json_data
        return "source xml was empty"


def to_python_literal(value) -> str:
    """Convert a value to a valid Python literal string."""
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


def normalize_identifier(name: str) -> str:
    """Normalize a string to be a valid Python identifier."""
    normalized = re.sub(r"\W+", "_", name)
    if not normalized:
        normalized = "UNNAMED"
    if normalized[0].isdigit():
        normalized = f"VAR_{normalized}"
    return normalized.upper()
