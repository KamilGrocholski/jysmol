local JysmolParser = require "src.parser"
local JysmolStringifier = require "src.stringifier"

local Jysmol = {}

Jysmol.parse = JysmolParser.parse

Jysmol.stringify = function (value)
   return JysmolStringifier.stringify_value(value)
end

return Jysmol
