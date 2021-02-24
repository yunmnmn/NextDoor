function MimiNoticesHoleConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiApproachesHole);
	}
	
	cb17_3 = function()
	{	
		var c17_3 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c17_3.AddSubText(new SubText("Hey, there's a hole over there", 0.2, true));
		RenderText(c17_3);
	}
	
	cb17_2 = function()
	{	
		var c17_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb17_3);
		c17_2.AddSubText(new SubText("That is strange", 0.2, true));
		RenderText(c17_2);
	}

	// Start of the conversation. Doesn't require a function
	var c17_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb17_2);
	c17_1.AddSubText(new SubText("They really don't make any sound", 0.2, true));
	RenderText(c17_1);
}

MimiNoticesHole = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set the idle animation
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
		
	// Play the conversation
	MimiNoticesHoleConversation();
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiNoticesHole);
collisionContext.AddGlobalState1(GlobalGameStates.MimiLooksAround);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);