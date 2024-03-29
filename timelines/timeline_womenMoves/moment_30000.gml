// If the current TextContext is occupied, go back a second
if(GetControlState() != PlayerControlState.PlayerControl)
{
	timeline_position = timeline_position - 1000;
}
else
{
	conversationFinished = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		SetGlobalGameState(GlobalGameStates.MimiHearsTickingAtWindow);
	}

	var c25_1 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
	c25_1.AddSubText(new SubText("Did she leave?", 0.3, true));
	RenderText(c25_1);

	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the idle animation
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
}