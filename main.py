import src.utils.helper_functions as hf
import src.utils.xml2json as x2j
import src.utils.copy_utility_files as cf

if __name__ == "__main__":
    source_root = r"C:\Repos\Bachelor Repos\sample-website-katalon-tests"
    destination_root = r"C:\Repos\Bachelor Repos\sample-website-selenium-tests"

    print("Migration started")

    # Main translation
    hf.Helper_Functions().iterate_and_translate_test_cases(source_root, destination_root)

    # Create new object repository
    x2j.create_object_repository(source_root, destination_root)

    # Create new variables from Test Cases
    hf.Helper_Functions().create_variables_as_py(source_root, destination_root)

    # Create Global Variable profiles
    x2j.create_global_variables_file(source_root, destination_root)

    # Create utility files
    cf.copy_utility_files(destination_root)

    # Copy data
    cf.copy_data_files(source_root, destination_root)

    print("Migration finished")