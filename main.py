from src.pipeline.test_script_scanner import iterate_and_translate_test_cases
from src.pipeline.object_repo_converter import create_object_repository
from src.pipeline.variables_extractor import create_variables_as_py
from src.pipeline.global_vars_generator import create_global_variables_file
from src.pipeline.copy_runtime_files import copy_runtime_files, copy_data_files


if __name__ == "__main__":
    source_root = r"C:\Repos\Bachelor Repos\sample-website-katalon-tests"
    destination_root = r"C:\Repos\Bachelor Repos\sample-website-selenium-tests"

    print("Migration started")

    # Main translation
    iterate_and_translate_test_cases(source_root, destination_root)

    # Create new object repository
    create_object_repository(source_root, destination_root)

    # Create new variables from Test Cases
    create_variables_as_py(source_root, destination_root)

    # Create Global Variable profiles
    create_global_variables_file(source_root, destination_root)

    # Copy runtime utility files
    copy_runtime_files(destination_root)

    # Copy data
    copy_data_files(source_root, destination_root)

    print("Migration finished")