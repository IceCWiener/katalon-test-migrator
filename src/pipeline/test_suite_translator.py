import os
from src.pipeline.test_transpiler import translate_katalon_test
from src.utils.file_utils import _touch_init
from src.utils.string_utils import change_var_name


def iterate_and_translate_test_cases(source_root: str, destination_root: str) -> None:
    """
    Recursively scan and translate all Katalon test scripts to Python Pytest.
    
    Walks through source_root/Scripts, identifies .groovy files, transpiles them
    to Python, and writes results to destination_root/src/tests.
    Untranslatable tests are written to src/unreadable_tests.
    
    Args:
        source_root: Root folder of the source Katalon project.
        destination_root: Root folder of the destination project.
    """
    input_path = os.path.join(source_root, "Scripts")
    output_path = os.path.join(destination_root, "src", "tests")
    unreadable_path = os.path.join(destination_root, "src", "unreadable_tests")
    file_count = 0
    folder_count = 0
    unreadable_count = 0
    os.makedirs(output_path, exist_ok=True)
    _touch_init(output_path)
    
    for root, dirs, files in os.walk(input_path):
        dirs[:] = [
            dir_name
            for dir_name in dirs
            if dir_name not in ("X_tests_to_translate_by_hand", "unreadable_tests")
        ]
        
        # Create directory structure in output
        for dir in dirs:
            source_path = os.path.join(root, dir)

            # Skip folder creation when they contain a script (the script gets the name of the folder)
            if contains_script(source_path):
                continue

            destination_path = os.path.join(output_path, os.path.relpath(source_path, input_path))
            split = destination_path.split("\\")
            split[-1] = change_var_name(split[-1])
            destination_path = "\\".join(split)
            folder_count += 1
            os.makedirs(destination_path, exist_ok=True)
            _touch_init(destination_path)

        # Translate Groovy files
        for file in files:
            error = False
            if file.endswith('.groovy'):
                source_file_path = os.path.join(root, file)
                # Read Katalon test, translate and return new Selenium content
                [content, error_content] = translate_katalon_test(source_file_path)
                if error_content.startswith("ERROR"):
                    error = True

                if error:
                    unreadable_file_path = os.path.join(
                        unreadable_path, os.path.relpath(source_file_path, input_path)
                    )
                    os.makedirs(os.path.dirname(unreadable_file_path), exist_ok=True)
                    with open(unreadable_file_path, 'w', encoding="utf-8") as f:
                        f.write(error_content)
                    unreadable_count += 1
                    continue

                new_file_path = os.path.join(output_path, os.path.relpath(source_file_path, input_path))
                # Slice off the last part of the script name to give the test its original name with the added "test_" prefix
                new_file_path = new_file_path[:-("\\" + file).__len__()] + ".py"
                split = new_file_path.split("\\")
                split[-2] = change_var_name(split[-2])
                split[-1] = "test_" + change_var_name(split[-1])
                new_file_path = "\\".join(split)

                file_count += 1
                with open(new_file_path, 'w', encoding="utf-8") as f:
                    f.write(content)

    print(
        f"Tests: {file_count} translated, {unreadable_count} unreadable, {folder_count} folders prepared"
    )


def contains_script(folder_path: str) -> bool:
    """Check if a folder contains a .groovy file."""
    contents = os.listdir(folder_path)
    for item in contents:
        if item.__contains__(".groovy"):
            return True
    return False
