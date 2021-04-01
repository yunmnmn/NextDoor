// Create a ShadowSurface instance, and set it
GetShadowSurfaceInstance();

// Set the falloff mode
audio_falloff_set_model(audio_falloff_linear_distance);

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
	
	if(	m_previousControllerKey != m_currentControllerKey ||	// Check if the action button is different
		m_previousAxisH != m_currentAxisH || 
		m_previousAxisV != m_currentAxisV)
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

// Returns wether the controller in in control now
function IsController()
{
	return m_controlDevice == ControlDevice.Controller;
}

function WalkingLeft()
{
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		return keyboard_check(vk_left);
	}
	else if(m_controlDevice = ControlDevice.Controller)
	{
		return gamepad_button_check(GetControllerIndex(), gp_padl) || gamepad_axis_value(GetControllerIndex(), gp_axislh) < 0;
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
		return gamepad_button_check(GetControllerIndex(), gp_padr)|| gamepad_axis_value(GetControllerIndex(), gp_axislh) > 0;
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
		return gamepad_button_check_pressed(GetControllerIndex(), gp_face1);
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
		return gamepad_button_check(GetControllerIndex(), gp_face1);
	}
	else
	{
		assert(false, "Something went wrong with the input device");
	}
}

function RegisterController()
{
	var padCount = gamepad_get_device_count();
	for(var i = 0; i < padCount; i++)
	{
		var name = gamepad_get_description(i);
		if(name != "")
		{
			// Set the controller
			SetControllerIndex(i);
			
			// Early out
			return;
		}
	}
	
	// If it got here, it means that no controller was detected, register keyboard here
	m_controlDevice = ControlDevice.Keyboard;
}

function Rumble(p_intensity, p_miliseconds)
{
	if(IsController())
	{
		SetControllerVibrationFactor(p_intensity);
	
		// Clear all moments in the disableRumble timeline
		timeline_clear(timeline_disableRumble);
	
		// Add the moment to the timeline
		timeline_moment_add_script(timeline_disableRumble, p_miliseconds, script_disableRumble);
	
		// Start the rumble
		gamepad_set_vibration(GetControllerIndex(), GetControllerVibrationFactor(), GetControllerVibrationFactor());
	
		// Play the disable timeline rumble
		PlayTimeline(timeline_disableRumble);
	}
}

function StopRumble()
{
	if(IsController())
	{
		// Clear all moments in the disableRumble timeline
		timeline_clear(timeline_disableRumble);
		
		gamepad_set_vibration(GetControllerIndex(), 0.0, 0.0);
	}
}

// ----------- Draw button prompts ---------
m_buttonFrame = 0;
m_elapsedTimeInMilisecondsMarker = 0;
m_buttonImageSpeed = 6.0; // Hack/TODO: make this dynamic instead

m_drawMovingPrompt = false;
m_movingPromptX = 0;
m_movingPromptY = 0;
function DrawMovingPrompt(p_draw, p_x, p_y)
{
	m_drawMovingPrompt = p_draw;
	m_movingPromptX = p_x;
	m_movingPromptY = p_y
}

m_drawPressPrompt = false;
m_pressPromptX = 0;
m_pressPromptY = 0;
function DrawActionPressPrompt(p_draw, p_x, p_y)
{
	m_drawPressPrompt = p_draw;
	m_pressPromptX = p_x;
	m_pressPromptY = p_y;
}

m_drawHoldPrompt = false;
m_drawHoldPromptWorld = false;
m_holdPromptX = 0;
m_holdPromptY = 0;
function DrawActionHoldPrompt(p_draw, p_worldSpace, p_x, p_y)
{
	m_drawHoldPromptWorld = p_worldSpace;
	m_drawHoldPrompt = p_draw;
	m_holdPromptX = p_x;
	m_holdPromptY = p_y;
}

// Default input device is a keyboard
m_controlDevice = ControlDevice.Keyboard;