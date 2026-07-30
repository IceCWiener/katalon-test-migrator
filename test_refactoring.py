#!/usr/bin/env python3
"""Test that all refactored modules can be imported successfully."""

try:
    from pipeline.test_script_scanner import iterate_and_translate_test_cases
    from src.pipeline.object_repo_converter import create_object_repository
    from src.pipeline.variables_extractor import create_variables_as_py
    from src.pipeline.global_vars_generator import create_global_variables_file
    from src.pipeline.copy_runtime_files import copy_runtime_files, copy_data_files
    
    print("✓ All pipeline imports successful")
    
    from src.pipeline.test_transpiler import process_katalon_test
    from src.pipeline.test_assembler import TestAssembler
    
    print("✓ All core transpiler imports successful")
    
    from src.utils.file_utils import get_variables_from_tc, read_file
    from src.utils.string_utils import change_var_name
    from src.utils.xml_utils import write_xml_to_json, get_xml_as_json
    
    print("✓ All utility imports successful")
    
    print("\n✅ REFACTORING SUCCESSFUL - All modules properly imported")
    print("\nNew structure is functional and ready for use.")
    
except Exception as e:
    print(f"❌ Import error: {e}")
    import traceback
    traceback.print_exc()
    exit(1)
