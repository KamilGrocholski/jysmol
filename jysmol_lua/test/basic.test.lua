local Jysmol = require"src.jysmol"

assert(Jysmol.stringify(true) == "true", "True stringify")
assert(Jysmol.stringify(false) == "false", "False stringify")
assert(Jysmol.stringify(nil) == "null", "Nil stringify")
assert(Jysmol.stringify("string") == '"string"', "String stringify")
assert(Jysmol.stringify(1234) == "1234", "Positive Integer stringify")
assert(Jysmol.stringify(-1234) == "-1234", "Negative Integer stringify")
assert(Jysmol.stringify(1234.2) == "1234.2", "Positive Float stringify")
assert(Jysmol.stringify(-1234.2) == "-1234.2", "Negative Float stringify")

assert(Jysmol.stringify({true}) == '[true,]', "True array")
assert(Jysmol.stringify({false}) == '[false,]', "False array")
assert(Jysmol.stringify({false}) == '[false,]', "False array")
assert(Jysmol.stringify({"arr"}) == '["arr",]', "String array")
assert(Jysmol.stringify({1234}) == '[1234,]', "Positive Integer array")
assert(Jysmol.stringify({-1234}) == '[-1234,]', "Negative Integer array")
assert(Jysmol.stringify({-1234.2}) == '[-1234.2,]', "Negative Float array")
assert(Jysmol.stringify({1234.2}) == '[1234.2,]', "Positive Float array")

assert(Jysmol.stringify(Jysmol.parse('{ "k" : 1234 , }')) == '{"k":1234,}', "Positive Integer pair")
assert(Jysmol.stringify({k=-1234}) == '{"k":-1234,}', "Negative Integer pair")
assert(Jysmol.stringify({k=-1234.2}) == '{"k":-1234.2,}', "Negative Float pair")
assert(Jysmol.stringify({k=1234.2}) == '{"k":1234.2,}', "Positive Float pair")
assert(Jysmol.stringify({k="val"}) == '{"k":"val",}', "String pair")
assert(Jysmol.stringify({k={"1"}}) == '{"k":["1",],}', "Array pair")
assert(Jysmol.stringify({k={k="1"}}) == '{"k":{"k":"1",},}', "Pair pair")

print("All test cases passed!")
