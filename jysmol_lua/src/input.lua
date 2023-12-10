local Jysmol = require"src.jysmol"

local function run ()
   local input = arg[1]
   print("input: " .. input)
   local parsed = Jysmol.parse(input)
   -- print("parsed: " .. parsed)
   local stringified = Jysmol.stringify(parsed)
   print("stringified: " .. stringified)
end

run()
