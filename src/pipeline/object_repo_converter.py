import os
from src.utils.xml_utils import write_xml_to_json


def create_object_repository(source_root: str, destination_root: str) -> None:
    """
    Convert Katalon Object Repository (.rs XML files) to JSON format
    in the destination project's object_repository directory.
    """
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
