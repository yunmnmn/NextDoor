// -------------------------- First colliding event --------------------------

function NobodyIsHereConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global state
		SetGlobalGameState(GlobalGameStates.MimiLooksAround);
	}
	
	cb15_2 = function()
	{	
		var c15_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c15_2.AddSubText(new SubText("Nobody's home...", 0.3, true));
		RenderText(c15_2);
	}

	var c15_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb15_2);
	c15_1.AddSubText(new SubText("That's weird.", 0.4, true));
	RenderText(c15_1);
}

NobodyIshere = function()
{	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set the IdleScared animation
	PlayerPlayAndFreezeAtEnd(sprite_mimiIdleScared, true);
		
	// Play the conversation with the women in black
	NobodyIsHereConversation();
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), NobodyIshere);
collisionContext1.AddGlobalState1(GlobalGameStates.MimiEntersYoungstersRoom);
collisionContext1.ExecuteOnHit();
AddCollisionContext(collisionContext1);

// -------------------------- Second colliding event --------------------------

// Don't let Mimi outside anymore
CannotGoToHallwayUp = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), CannotGoToHallwayUp);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiLooksAround);
		AddCollisionContext(collisionContext);
	}
	// Start the monologue
	var c32_1 = new TextContext(sprite_mimiAvatarScared, true, conversationFinished);
	c32_1.AddSubText(new SubText("Let's look around some more.", 0.3, true));
	RenderText(c32_1);
	
	// Set Mimi to IdleScared
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext2 = new CollisionContext(GetPlayerInstance(), CannotGoToHallwayUp);
collisionContext2.AddGlobalState1(GlobalGameStates.MimiLooksAround);
AddCollisionContext(collisionContext2);

// -------------------------- Third colliding event --------------------------

// Don't let Mimi outside anymore
WomenMightBeOutside = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), WomenMightBeOutside);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiHearsTickingAtWindow);
		AddCollisionContext(collisionContext);
	}
	// Start the monologue
	var c33_1 = new TextContext(sprite_mimiAvatarScared, true, conversationFinished);
	c33_1.AddSubText(new SubText("She could still be in the hallway.", 0.3, true));
	RenderText(c33_1);
	
	// Set Mimi to IdleScared
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext2 = new CollisionContext(GetPlayerInstance(), WomenMightBeOutside);
collisionContext2.AddGlobalState2(GlobalGameStates.MimiHearsTickingAtWindow);
AddCollisionContext(collisionContext2);