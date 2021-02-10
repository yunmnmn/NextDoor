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
