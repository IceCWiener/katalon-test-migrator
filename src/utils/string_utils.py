import re


def change_var_name(name: str) -> str:
    """
    Convert a name to Python-safe identifier.
    Removes special characters and converts spaces to underscores.
    """
    name = name.replace(' ', '_')
    name = name.replace(',', '_')
    name = name.replace('-', '')
    return name
