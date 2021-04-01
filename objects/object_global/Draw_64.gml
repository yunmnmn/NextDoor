// Show FPS if debug is enabled
if(DebugMode())
{
	draw_text(0, 0, 1000.0 / DeltaTimeInMiliseconds());
}

// Increment the frame
if(m_drawMovingPrompt || m_drawPressPrompt || m_drawHoldPrompt)
{
	m_elapsedTimeInMilisecondsMarker += DeltaTimeInMiliseconds();
	if(m_elapsedTimeInMilisecondsMarker > 1000.0 / m_buttonImageSpeed)
	{
		m_elapsedTimeInMilisecondsMarker = 0.0;
		m_buttonFrame = (m_buttonFrame + 1) % 99999;
	}
}
else
{
	m_elapsedTimeInMilisecondsMarker = 0;
	m_buttonFrame = 0;
}

if(m_drawMovingPrompt)
{
	var buttonSpriteIndex = noone;
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		buttonSpriteIndex = anim_movePromptKeyboard;
	}
	else if(m_controlDevice == ControlDevice.Controller)
	{
		buttonSpriteIndex = anim_movePromptController;
	}
	else
	{
		assert(false, "No controller state is set")
	}
	var imageIndex = (m_buttonFrame) % sprite_get_number(buttonSpriteIndex);
	draw_sprite_ext(buttonSpriteIndex, imageIndex, m_movingPromptX, m_movingPromptY, 1.0, 1.0, 0.0, c_white, 0.8);
}

if(m_drawPressPrompt)
{
	var buttonSpriteIndex = noone;
	if(m_controlDevice == ControlDevice.Keyboard)
	{
		buttonSpriteIndex = anim_pressPromptKeyboard;
	}
	else if(m_controlDevice == ControlDevice.Controller)
	{
		buttonSpriteIndex = anim_pressPromptController;
	}
	else
	{
		assert(false, "No controller state is set")
	}
	var imageIndex = (m_buttonFrame) % sprite_get_number(buttonSpriteIndex);
	draw_sprite_ext(buttonSpriteIndex, imageIndex, m_pressPromptX, m_pressPromptY, 1.0, 1.0, 0.0, c_white, 0.8);
}

if(m_drawHoldPrompt && !m_drawHoldPromptWorld)
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