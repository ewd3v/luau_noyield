local noyield = require("./src")

assert(type(noyield) == "function", "noyield isn't a function")

assert(noyield(function(input)
	assert(input == "test input", "input is wrong")
	return "test output"
end, "test input") == "test output", "output is wrong")

local thread = coroutine.create(function()
	pcall(noyield, function()
		coroutine.yield()
	end)
end)
coroutine.resume(thread)
assert(coroutine.status(thread) == "dead", "noyield doesn't prevent yielding")

noyield(function()
	coroutine.yield()
end)
