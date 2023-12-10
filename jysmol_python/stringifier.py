def stringify_value(value):
    match value:
        case None: return 'null'
        case False: return 'false'
        case True: return 'true'

    value_t = type(value) 

    if (value_t is int or value_t is float): return stringify_number(value)
    elif (value_t is str): return stringify_string(value)
    elif (value_t is list): return stringify_array(value)
    elif (value_t is dict): return stringify_object(value)

    raise Exception('nie ma')

def stringify_string(value):
    return f'"{value}"'

def stringify_number(value):
    return f'{value}'

def stringify_array(arr):
    out = '['

    for el in arr:
        out += stringify_value(el)
        out += ','

    out += ']'

    return out

def stringify_object(obj):
    out = '{'

    for key, value in obj.items():
        out += stringify_string(key)
        out += ':'
        out += stringify_value(value)
        out += ','

    out += '}'

    return out
