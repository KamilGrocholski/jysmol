local Jysmol = require"src.jysmol"

local objectLiteral = '{"key": "value", "number": 42,}'
local expectedTable1 = { key = "value", number = 42 }
local actualTable1 = Jysmol.parse(objectLiteral)
assert(actualTable1.key == expectedTable1.key, "Test Case 1 failed: Incorrect key")
print(actualTable1)
assert(actualTable1.number == expectedTable1.number, "Test Case 1 failed: Incorrect number")

local luaTable2 = { key = "value", number = 42 }
local expectedJsonString2 = '{"key":"value","number":42,}'
local actualJsonString2 = Jysmol.stringify(luaTable2)
print(actualJsonString2)
print(actualJsonString2)
assert(actualJsonString2 == expectedJsonString2, "Test Case 2 failed: Incorrect JSON string")

print("All test cases passed!")
