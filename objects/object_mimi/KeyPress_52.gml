// When the animation is finished playing, call this callback funciton
{
	// This callback will be executed when the animation is finished with executing
	var animationEndCallback = function()
	{
		// Go back to the idle animation when the animation is finished playing
		PlayerPlayAnimation(sprite_mimiIdle, noone);
		// Give the control back to the player
		SetControlState(PlayerControlState.PlayerControl);
	}

	// Disable player movement while it's playing animations
	SetControlState(PlayerControlState.PlayerControl);
	
	// Play the Knocking animation
	PlayerPlayAnimation(anim_mimiKnock, animationEndCallback);
}