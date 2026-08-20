local Ripple = require("../../Ripple")
local Fluid = require("../../Fluid")
local test = require("../../../../tests/test")
local useTween = require("../useTween")

test("should update binding when goal is set", function()
	local src, tween

	Fluid.root(function()
		src, tween = useTween(0)
		tween:setGoal(1, { tween = { duration = 0 } })
	end)

	Ripple.tweenScheduler.step(1)
	assert(src() == 1, `Expected tween to reach goal, got {src()}`)
end)

return {}
