local Ripple = require(script.Parent.Parent.Ripple)
local Fluid = require(script.Parent.Parent.Fluid)

type Animatable = Ripple.Animatable
type Spring<T> = Ripple.Spring<T>
type SpringOptions<T> = Ripple.SpringOptions<T>

local function useSpring<T>(initialValue: T, initialOptions: SpringOptions<T>?): (() -> T, Spring<T>)
	local spring = Ripple.createSpring(initialValue, initialOptions)
	local value = Fluid.source(initialValue)

	if not (initialOptions and initialOptions.start == false) then
		spring:start()
	end

	local disconnect = spring:onChange(value)

	Fluid.cleanup(function()
		disconnect()
		spring:stop()
	end)

	return value, spring
end

return useSpring
