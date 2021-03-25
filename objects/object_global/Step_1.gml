// Reset the previous and current cached keys
m_previousControllerKey = noone;
m_currentControllerKey = noone;
m_currentKeyboardKey = noone;
m_previousKeyboardKey = noone;

// Hack: Window focus
if(mouse_check_button_pressed(mb_any))
{
	FocusWindow();
}

// Check if a new controller has been plugged in
RegisterController();

if(gamepad_button_check_pressed(m_controllerIndex, gp_face1))
{
	m_currentControllerKey = gp_face1;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_face2))
{
	m_currentControllerKey = gp_face2;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_face3))
{
	m_currentControllerKey = gp_face3;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_face4))
{
	m_currentControllerKey = gp_face4;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_shoulderl))
{
	m_currentControllerKey = gp_shoulderl;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_shoulderlb))
{
	m_currentControllerKey = gp_shoulderlb;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_shoulderr))
{
	m_currentControllerKey = gp_shoulderr;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_shoulderrb))
{
	m_currentControllerKey = gp_shoulderrb;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_select))
{
	m_currentControllerKey = gp_select;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_start))
{
	m_currentControllerKey = gp_start;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_stickl))
{
	m_currentControllerKey = gp_stickl;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_stickr))
{
	m_currentControllerKey = gp_stickr;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padu))
{
	m_currentControllerKey = gp_padu;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padd))
{
	m_currentControllerKey = gp_padd;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padl))
{
	m_currentControllerKey = gp_padl;
	FocusWindow();
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padr))
{
	m_currentControllerKey = gp_padr;
	FocusWindow();
}

// Check if the axis are different
m_currentAxisH = gamepad_axis_value(m_controllerIndex, gp_axislh);
m_currentAxisV = gamepad_axis_value(m_controllerIndex, gp_axislv);

