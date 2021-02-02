function MimiNoticesHoleConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiApproachesHole);
	}
	
	cb16_3 = function()
	{	
		var c16_3 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c16_3.AddSubText(new SubText("Hey, there's a hole over there", 0.2));
		RenderText(c16_3);
	}
	
	cb16_2 = function()
	{	
		var c16_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb16_3);
		c16_2.AddSubText(new SubText("That is strange", 0.2));
		RenderText(c16_2);
	}

	// Start of the conversation. Doesn't require a function
	var c16_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb16_2);
	c16_1.AddSubText(new SubText("They really don't make any sound", 0.2));
	RenderText(c16_1);
}

MimiNoticesHole = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set the idle animation
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
		
	// Play the conversation
	MimiNoticesHoleConversation();
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiNoticesHole);
collisionContext.AddGlobalState1(GlobalGameStates.MimiEntersYoungstersRoom);
AddCollisionContext(collisionContext);