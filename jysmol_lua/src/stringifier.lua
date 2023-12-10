local M = {}

local function is_array(t)
  local i = 0
  for key in pairs(t) do
      i = i + 1
      if type(key) ~= 'number' then
          return false
      end
  end
  return true
end

function M.stringify_string(value)
    return '"' .. value .. '"'
end

function M.stringify_number(value)
    return '' .. value .. ''
end

function M.stringify_array(arr)
    local str = '['

    for _, el in ipairs(arr) do
        str = str .. M.stringify_value(el) .. ','
    end

    str = str .. ']'

    return str
end

function M.stringify_object(obj)
    local str = '{'

    for key, value in pairs(obj) do
        str = str .. M.stringify_string(key) .. ':' .. M.stringify_value(value) .. ','
    end

    str = str .. '}'

    return str
end

function M.stringify_value(value)
    if value == nil then return 'null' -- TODO useless in table
    elseif value == true then return 'true'
    elseif value == false then return 'false'
    end

    local val_type = type(value)

    if val_type == 'string' then return M.stringify_string(value)
    elseif val_type == 'number' then return M.stringify_number(value)
    elseif val_type == 'table' then
        if is_array(value) then
            return M.stringify_array(value)
        end
        return M.stringify_object(value)
    end

    error('unsupported type' .. val_type)
end

return M
