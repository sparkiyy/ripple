local Ripple = require(script.Parent.Parent.Ripple)
local Fluid = require(script.Parent.Parent.Fluid)

type Animatable = Ripple.Animatable
type Motion<T> = Ripple.Motion<T>
type MotionOptions<T> = Ripple.MotionOptions<T>

local function useMotion<T>(initialValue: T, initialOptions: MotionOptions<T>?): (() -> T, Motion<T>)
	local motion = Ripple.createMotion(initialValue, initialOptions)
	local value = Fluid.source(initialValue)

	if not (initialOptions and initialOptions.start == false) then
		motion:start()
	end

	local disconnect = motion:onChange(value)

	Fluid.cleanup(function()
		disconnect()
		motion:stop()
	end)

	return value, motion
end

return useMotion
