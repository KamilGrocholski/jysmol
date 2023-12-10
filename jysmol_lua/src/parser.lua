local JysmolParser = {}

function JysmolParser:new(input)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    self.input = input
    self.input_len = string.len(input)
    self.position = 0

    self.advance(self)

    return instance
end

function JysmolParser:parse_value()
    self.skip_whitespace(self)

    if self.ch == '"' then
       return self.parse_string(self)
    end
    if self.ch == '[' then
        return self.parse_array(self)
    end
    if self.ch == '{' then
        return self.parse_object(self)
    end
    if IsDigit(self.ch) then
        return self.parse_number(self)
    end
    if self.ch == '-' then
        self.advance(self)
        return -self.parse_number(self)
    end
    if IsAlpha(self.ch) then
        return self.parse_keyword(self)
    end

    error('unexpected token: ' .."'" .. self.ch .. "'" .. ' at position ' .. self.position)
end

function JysmolParser:parse_object()
    local obj = {}
    self.advance(self)
    self.skip_whitespace(self)

    while self.ch ~= '}' and self.position <= self.input_len do
        local key = self.parse_string(self)
        self.skip_whitespace(self)
        self.eat(self, ':')
        obj[key] = self.parse_value(self)
        self.skip_whitespace(self)
        self.eat(self, ',')
        self.skip_whitespace(self)
    end

    self.eat(self, '}')

    return obj
end

function JysmolParser:parse_array()
    local arr = {}
    local i = 1
    self.advance(self)
    self.skip_whitespace(self)

    while self.ch ~= ']' and self.position <= self.input_len do
        arr[i] = self.parse_value(self)
        i = i + 1
        self.skip_whitespace(self)
        self.eat(self, ',')
        self.skip_whitespace(self)
    end

    self.eat(self, ']')

    return arr
end

function JysmolParser:parse_keyword()
    local keyword = ""

    while IsAlpha(self.ch) and self.position <= self.input_len do
        keyword = keyword .. self.ch
        self.advance(self)
    end

    if keyword == 'null' then
        return nil
    end
    if keyword == 'false' then
        return false
    end
    if keyword == 'true' then
        return true
    end

    error('invalid keyword: '.. keyword.. ' at position '.. self.position)
end

function JysmolParser:parse_number()
    local lit = self.parse_int_literal(self)

    while self.ch == "." do
        lit = lit .. "."
        self.advance(self)
        lit = lit .. self.parse_int_literal(self)
    end

    return tonumber(lit)
end

function JysmolParser:parse_int_literal()
    local lit = self.ch
    self.advance(self)

    while IsDigit(self.ch) do
       lit = lit .. self.ch
       self.advance(self)
    end

    return lit
end

function JysmolParser:parse_string()
    local lit = ""
    self.advance(self)

    while self.ch ~= '"' and self.position <= self.input_len do
        lit = lit .. self.ch
        self.advance(self)
    end

    self.eat(self, '"')

    return lit
end

function JysmolParser:eat(ch)
    if self.ch ~= ch then
        error('expected: ' .. "'" .. ch .. "'" .. ' got: ' .. "'" .. self.ch .. "'" .. ' at position ' .. self.position)
    end
    self.advance(self)
end

function JysmolParser:skip_whitespace()
    while IsWhitespace(self.ch) do
       self.advance(self)
    end
end

function JysmolParser:advance()
    self.position = self.position + 1
    if (self.position <= self.input_len) then
        self.ch = string.sub(self.input, self.position, self.position)
    else
        self.ch = '\000'
    end
end

function IsWhitespace(ch)
   return ch == ' ' or ch == '\n' or ch == '\r' or ch == '\t'
end

function IsDigit(ch)
   return string.match(ch, '%d')
end

function IsAlpha(ch)
   return ch >= 'a' and ch <= 'z' or ch >= 'A' and ch <= 'Z'
end

local M = {}

M.parse = function (input)
    local parser = JysmolParser:new(input)
    return parser:parse_value()
end

return M
