local Ripple = require(script.Parent.Parent.Ripple)
local Fluid = require(script.Parent.Parent.Fluid)

type Animatable = Ripple.Animatable
type Tween<T> = Ripple.Tween<T>
type TweenOptions<T> = Ripple.TweenOptions<T>

local function useTween<T>(initialValue: T, initialOptions: TweenOptions<T>?): (() -> T, Tween<T>)
	local tween = Ripple.createTween(initialValue, initialOptions)
	local value = Fluid.source(initialValue)

	if not (initialOptions and initialOptions.start == false) then
		tween:start()
	end

	local disconnect = tween:onChange(value)

	Fluid.cleanup(function()
		disconnect()
		tween:stop()
	end)

	return value, tween
end

return useTween
