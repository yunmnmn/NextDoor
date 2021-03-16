if(m_drawHoldPrompt && m_drawHoldPromptWorld)
{
	var buttonSpriteIndex = noone;
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		buttonSpriteIndex = anim_holdPromptKeyboard;
	}
	else if(m_controlDevice == ControlDevice.Controller)
	{
		buttonSpriteIndex = anim_holdPromptController;
	}
	else
	{
		assert(false, "No controller state is set")
	}
	var imageIndex = (m_buttonFrame) % sprite_get_number(buttonSpriteIndex);
	draw_sprite_ext(buttonSpriteIndex, imageIndex, m_holdPromptX, m_holdPromptY, 1.0, 1.0, 0.0, c_white, 0.8);
}