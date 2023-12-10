def stringify_value(value, stack):
    match value:
        case None: return 'null'
        case False: return 'false'
        case True: return 'true'

    value_t = type(value) 

    if (value_t is int or value_t is float): return stringify_number(value)
    elif (value_t is str): return stringify_string(value)
    elif (value_t is list): return stringify_array(value, stack or set())
    elif (value_t is dict): return stringify_object(value, stack or set())

    raise Exception('nie ma')

def stringify_string(value):
    return f'"{value}"'

def stringify_number(value):
    return f'{value}'

def stringify_array(arr, stack):
    out = '['
    arr_id = id(arr)

    if (arr_id in stack):
        raise Exception('circular reference')

    stack.add(arr_id)

    for el in arr:
        out += stringify_value(el, stack)
        out += ','

    out += ']'

    stack.remove(arr_id)

    return out

def stringify_object(obj, stack):
    out = '{'
    obj_id = id(obj)

    if (obj_id in stack):
        raise Exception('circular reference')

    stack.add(obj_id)

    for key, value in obj.items():
        out += stringify_string(key)
        out += ':'
        out += stringify_value(value, stack)
        out += ','

    out += '}'

    stack.remove(obj_id)

    return out
