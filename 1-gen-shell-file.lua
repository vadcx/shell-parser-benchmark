#!/usr/bin/env lua

local args = args or {...}

local stringLenMin = 4
local stringLenMax = 100

local stringCount = 4000 -- how many dummy strings to generate in one function body
local repetitions = 500 -- how often the generated function will be called
local outputName = "random-strings.gen.sh"

do
	assert(stringLenMin <= stringLenMax)
	math.randomseed(1337)

	local sh = assert(io.open(outputName, "wb"))
	sh:write([[
# you must start this file manually with the desired shell!

function single_iteration {

]]
	)

	-- generate alphabet
	local alphabetAZ09Slash_ = {}
	for i = 48, 57 do -- 0-9
		table.insert(alphabetAZ09Slash_, string.char(i))
	end
	for i = 97, 122 do
		table.insert(alphabetAZ09Slash_, string.char(i))
	end
	table.insert(alphabetAZ09Slash_, "_")
	table.insert(alphabetAZ09Slash_, "/")

	-- write function body
	local lines = {}
	for si = 1, stringCount do
		local s = ""
		for n = 1, math.random(stringLenMin, stringLenMax) do
			local letter = alphabetAZ09Slash_[math.random(1, #alphabetAZ09Slash_)]
			s = s .. letter
		end

		table.insert(lines, 'VAR="'.. s ..'";')
	end
	sh:write(table.concat(lines, "\n"), "\n")

	sh:write([[
}
# End of Function / Iteration
]]
	)

	-- write function calls
	for i = 1, repetitions do
		sh:write("single_iteration;\n")
	end
end
