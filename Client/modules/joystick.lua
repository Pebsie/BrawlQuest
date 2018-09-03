function initJoystick()

  JS_UP = "dpup"
  JS_DOWN = "dpdown"
  JS_LEFT = "dpleft"
  JS_RIGHT = "dpright"

  JS_ATK = "a"
  JS_RUN = "b"

  if not joystick then joystick = {isGamepadDown = function(a) return false end} end
end
