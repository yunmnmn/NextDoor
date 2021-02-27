// If the current TextContext is occupied, go back a second
if(GetCurrentTextContext() != noone)
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

	cb25_2 = function()
	{
		var c25_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c25_2.AddSubText(new SubText("Did she leave?", 0.2, true));
		RenderText(c25_2);
	}
	
	var c25_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb25_2);
	c25_1.AddSubText(new SubText("Phew, she went downstairs", 0.2, true));
	RenderText(c25_1);

	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the idle animation
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
}