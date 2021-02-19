// The player has to move Mimi in order to progress
if(m_talkingFinished)
{
	if(!m_pressedMove && (WalkingRight() || WalkingLeft()))
	{
		m_pressedMove = true;
		
		// Remove the moving button prompt
		instance_global.DrawMovingPrompt(false, 0, 0);
		
		var animationEndCallback = function()
		{
			// Play the idle animation
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
			// Give the control back to the player
			SetControlState(PlayerControlState.PlayerControl);
		}
		// Set the animation speed back when it's finished playing the conversation
		// Play the sitting animation
		PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
	}
}

// Do the transition from day to night
if(m_startDayNightTransition)
{
	m_transition += m_transitionSpeed * DeltaTimeInMiliseconds();
	m_transition = clamp(m_transition, 0.0, 1.0);
	
	if(m_transition == 1.0)
	{
		m_startDayNightTransition = false;
		
	}
}