#!/usr/bin/env python3
"""Clean up old refactored files from the repository."""

import os
import shutil
from pathlib import Path

# List of old files to delete
old_files = [
    "src/translation/WriteTest.py",
    "src/utils/parse_katalon_input.py",
    "src/utils/xml2json.py",
    "src/utils/helper_functions.py",
    "src/utils/copy_utility_files.py",
    "src/utils/base_test.py",
    "src/utils/katalon_helpers.py",
    "src/utils/block_comment_skipper.py",
]

# Delete files
deleted_count = 0
for file_path in old_files:
    p = Path(file_path)
    if p.exists():
        p.unlink()
        print(f"✓ Deleted: {file_path}")
        deleted_count += 1
    else:
        print(f"- Not found: {file_path}")

# Delete old translation directory
translation_dir = Path("src/translation")
if translation_dir.exists():
    shutil.rmtree(translation_dir)
    print(f"✓ Deleted directory: src/translation")
    deleted_count += 1

print(f"\n✅ Cleanup completed: {deleted_count} items removed")
