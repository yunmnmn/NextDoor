if(gamepad_button_check_pressed(0, gp_face1))
{
	m_currentControllerKey = gp_face1;
}
else if(gamepad_button_check_pressed(0, gp_face2))
{
	m_currentControllerKey = gp_face2;
}
else if(gamepad_button_check_pressed(0, gp_face3))
{
	m_currentControllerKey = gp_face3;
}
else if(gamepad_button_check_pressed(0, gp_face4))
{
	m_currentControllerKey = gp_face4;
}
else if(gamepad_button_check_pressed(0, gp_shoulderl))
{
	m_currentControllerKey = gp_shoulderl;
}
else if(gamepad_button_check_pressed(0, gp_shoulderlb))
{
	m_currentControllerKey = gp_shoulderlb;
}
else if(gamepad_button_check_pressed(0, gp_shoulderr))
{
	m_currentControllerKey = gp_shoulderr;
}
else if(gamepad_button_check_pressed(0, gp_shoulderrb))
{
	m_currentControllerKey = gp_shoulderrb;
}
else if(gamepad_button_check_pressed(0, gp_select))
{
	m_currentControllerKey = gp_select;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_start))
{
	m_currentControllerKey = gp_start;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_stickl))
{
	m_currentControllerKey = gp_stickl;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_stickr))
{
	m_currentControllerKey = gp_stickr;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padu))
{
	m_currentControllerKey = gp_padu;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padd))
{
	m_currentControllerKey = gp_padd;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padl))
{
	m_currentControllerKey = gp_padl;
}
else if(gamepad_button_check_pressed(m_controllerIndex, gp_padr))
{
	m_currentControllerKey = gp_padr;
}

// Check if the axis are different
m_currentAxisH = gamepad_axis_value(m_controllerIndex, gp_axislh);
m_currentAxisV = gamepad_axis_value(m_controllerIndex, gp_axislv);

