// Only allow movement when the player is allowed control
if(global.g_playerControlState == PlayerControlState.PlayerControl)
{
	m_position -= GetMovementSpeed();
}
