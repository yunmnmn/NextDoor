// Reset the previous and current cached keys
m_previousControllerKey = noone;
m_currentControllerKey = noone;
m_currentKeyboardKey = noone;
m_previousKeyboardKey = noone;

// Hack: Window focus
if(mouse_check_button_pressed(mb_any))
{
	 WindowFocus();
}

// Check if a new controller has been plugged in
RegisterController();

if(gamepad_button_check_pressed(GetControllerIndex(), gp_face1))
{
	m_currentControllerKey = gp_face1;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face2))
{
	m_currentControllerKey = gp_face2;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face3))
{
	m_currentControllerKey = gp_face3;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face4))
{
	m_currentControllerKey = gp_face4;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderl))
{
	m_currentControllerKey = gp_shoulderl;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderlb))
{
	m_currentControllerKey = gp_shoulderlb;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderr))
{
	m_currentControllerKey = gp_shoulderr;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderrb))
{
	m_currentControllerKey = gp_shoulderrb;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_select))
{
	m_currentControllerKey = gp_select;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_start))
{
	m_currentControllerKey = gp_start;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_stickl))
{
	m_currentControllerKey = gp_stickl;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_stickr))
{
	m_currentControllerKey = gp_stickr;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padu))
{
	m_currentControllerKey = gp_padu;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padd))
{
	m_currentControllerKey = gp_padd;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padl))
{
	m_currentControllerKey = gp_padl;
	//WindowFocus();
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padr))
{
	m_currentControllerKey = gp_padr;
	//WindowFocus();
}

// Check if the axis are different
m_currentAxisH = gamepad_axis_value(GetControllerIndex(), gp_axislh);
m_currentAxisV = gamepad_axis_value(GetControllerIndex(), gp_axislv);

