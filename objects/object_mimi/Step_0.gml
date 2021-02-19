if(WalkingLeft())
{
	// Only allow movement when the player is allowed control
	if(global.g_playerControlState == PlayerControlState.PlayerControl)
	{
		m_position -= GetMovementSpeed();
		// Clamp the positions between 0 - 1
		m_position = clamp(m_position, 0.0, 1.0);
	}
}

if(WalkingRight())
{
	// Only allow movement when the player is allowed control
	if(global.g_playerControlState == PlayerControlState.PlayerControl && !GetMimiCrawling())
	{
		m_position += GetMovementSpeed();
		// Clamp the positions between 0 - 1
		m_position = clamp(m_position, 0.0, 1.0);
	}
}