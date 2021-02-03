function YoungsterStreamsConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiChecksOnYoungster);
	}
	
	cb13_2 = function()
	{	
		var c13_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c13_2.AddSubText(new SubText("Sounded like it came from upstairs", 0.2));
		RenderText(c13_2);
	}

	// Start of the conversation. Doesn't require a function
	var c13_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb13_2);
	c13_1.AddSubText(new SubText("GYAH!", 0.6));
	c13_1.AddSubText(new SubText("What was that sound?", 0.2));
	RenderText(c13_1);
}

MimiHearsYoungsterScream = function()
{
	// Set Mimi to scared from now on
	SetMimiScared(true);
	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set the idle animation
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
		
	// Play the conversation with the women in black
	YoungsterStreamsConversation();
}


var collisionContext = new CollisionContext(GetPlayerInstance(), MimiHearsYoungsterScream);
collisionContext.AddGlobalState1(GlobalGameStates.MimiReturnsFromDrinking);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);