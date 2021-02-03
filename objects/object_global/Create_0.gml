enum ControlDevice
{
	Keyboard,
	Controller,
}

m_previousControllerKey = noone;
m_currentControllerKey = noone;
m_previousAxisH = 0.0;
m_currentAxisH = 0.0;
m_previousAxisV = 0.0;
m_currentAxisV = 0.0;
// Checks if a controller key has been input
function CheckControllerPressed()
{
	// Early out if gamepads are not supported on this system
	if(!gamepad_is_supported())
	{
		return false;
	}
	
	// Early out if the device count is 0
	var padCount = gamepad_get_device_count();
	if(padCount == 0)
	{
		return false;
	}
	
	if(m_previousControllerKey != m_currentControllerKey || m_previousAxisH != m_currentAxisH || m_previousAxisV != m_currentAxisV)
	{
		m_previousControllerKey = m_currentControllerKey;
		m_previousAxisH = m_currentAxisH;
		m_previousAxisV = m_currentAxisV;
		return true;
	}
	
	return false;
}

m_previousKeyboardKey = noone;
m_currentKeyboardKey = noone;
// Checks if a KeyboardKey has been pressed
function CheckKeyboardKeyPressed()
{
	if(m_currentKeyboardKey != m_previousKeyboardKey)
	{
		m_currentKeyboardKey = m_previousKeyboardKey;
		return true;
	}
	else
	{
		return false;
	}
}


function CheckLastControlDevicePressed()
{
	if(CheckKeyboardKeyPressed())
	{
		return ControlDevice.Keyboard;
	}
	else if(CheckControllerPressed())
	{
		return ControlDevice.Controller
	}
	else
	{
		return noone;
	}
}

function WalkingLeft()
{
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		return keyboard_check(vk_left);
	}
	else if(m_controlDevice = ControlDevice.Controller)
	{
		return gamepad_button_check(m_controllerIndex, gp_padl) || gamepad_axis_value(m_controllerIndex, gp_axislh) < 0;
	}
	else
	{
		assert(false, "Something went wrong with the input device");
	}
}

function WalkingRight()
{
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		return keyboard_check(vk_right);
	}
	else if(m_controlDevice = ControlDevice.Controller)
	{
		return gamepad_button_check(m_controllerIndex, gp_padr)|| gamepad_axis_value(m_controllerIndex, gp_axislh) > 0;
	}
	else
	{
		assert(false, "Something went wrong with the input device");
	}
}

function ActionKeyPressed()
{
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		return keyboard_check_pressed(vk_space);
	}
	else if(m_controlDevice == ControlDevice.Controller)
	{
		return gamepad_button_check_pressed(m_controllerIndex, gp_face1);
	}
	else
	{
		assert(false, "Something went wrong with the input device");
	}
}

function ActionKeyHold()
{
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		return keyboard_check(vk_space);
	}
	else if(m_controlDevice == ControlDevice.Controller)
	{
		return gamepad_button_check(m_controllerIndex, gp_face1);
	}
	else
	{
		assert(false, "Something went wrong with the input device");
	}
}

m_controllerIndex = noone;
var padCount = gamepad_get_device_count();
for(i = 0; i < padCount; i++)
{
	var name = gamepad_get_description(i);
	if(name != "")
	{
		m_controllerIndex = i;
		var test = gamepad_is_connected(m_controllerIndex);
		break;
	}
}


// Default input device is a keyboard
m_controlDevice = ControlDevice.Keyboard;