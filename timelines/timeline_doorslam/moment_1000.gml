// If the current TextContext is occupied, go back a second
if(GetControlState() != PlayerControlState.PlayerControl)
{
	timeline_position = timeline_position - 1000;
}
else
{
	// TODO: Play a doorslam sound
	
	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the shock animation
	var CallbackWhenShockFinishes = function()
	{
		var MonologueFinished = function()
		{
			// Enable the player control
			SetControlState(PlayerControlState.PlayerControl);
		}
		
		var c16_1 = new TextContext(sprite_mimiAvatarTroubled, true, MonologueFinished);	
		c16_1.AddSubText(new SubText("Must have been the wind.", 0.6, true));
		RenderText(c16_1);
		
		// Back to idle scared
		PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
	}
	PlayerPlayAnimation2(anim_mimiShock, CallbackWhenShockFinishes);
}