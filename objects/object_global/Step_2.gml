if(gamepad_button_check_pressed(GetControllerIndex(), gp_face1))
{
	m_previousControllerKey = gp_face1;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face2))
{
	m_previousControllerKey = gp_face2;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face3))
{
	m_previousControllerKey = gp_face3;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_face4))
{
	m_previousControllerKey = gp_face4;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderl))
{
	m_previousControllerKey = gp_shoulderl;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderlb))
{
	m_previousControllerKey = gp_shoulderlb;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderr))
{
	m_previousControllerKey = gp_shoulderr;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_shoulderrb))
{
	m_previousControllerKey = gp_shoulderrb;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_select))
{
	m_previousControllerKey = gp_select;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_start))
{
	m_previousControllerKey = gp_start;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_stickl))
{
	m_previousControllerKey = gp_stickl;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_stickr))
{
	m_previousControllerKey = gp_stickr;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padu))
{
	m_previousControllerKey = gp_padu;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padd))
{
	m_previousControllerKey = gp_padd;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padl))
{
	m_previousControllerKey = gp_padl;
}
else if(gamepad_button_check_pressed(GetControllerIndex(), gp_padr))
{
	m_previousControllerKey = gp_padr;
}

// Check if the axis are different
m_previousAxisH = gamepad_axis_value(GetControllerIndex(), gp_axislh);
m_previousAxisV = gamepad_axis_value(GetControllerIndex(), gp_axislv);