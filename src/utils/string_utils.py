import re


def change_var_name(name: str) -> str:
    """
    Convert a name to Python-safe identifier.
    Removes special characters, .tc extension, and converts spaces to underscores.
    """
    name = name.replace(' ', '_')
    name = name.replace(',', '_')
    name = name.replace('-', '')
    name = name.replace('.tc', '')
    
    return name
