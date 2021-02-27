// -------------------------- First colliding event --------------------------

// Transition Mimi's HallwayDown -> Room when Mimi interacts with the trigger
transitionToOutside = function()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);

	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		ChangeRoomAndSetPath("room_outside", path_outsideHigh, 0.001, false);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), transitionToOutside);
collisionContext1.m_doNotExecuteOn = true;
collisionContext1.AddGlobalState3(GlobalGameStates.MimiGoingToKnockAtNeighbour, GlobalGameStates.MimiGointToYoungsterAgain, GlobalGameStates.MimiWalksToOldtimer);
AddCollisionContext(collisionContext1);

// -------------------------- Second colliding event --------------------------

// Don't let Mimi outside untill she knocked on the neighbor's door
CannotGoOutside = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), CannotGoOutside);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiGoingToKnockAtNeighbour);
		AddCollisionContext(collisionContext);
	}
	// Start the monologue
	var c28_1 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
	c28_1.AddSubText(new SubText("I can't be the only one, who's bothered by this music", 0.2, true));
	RenderText(c28_1);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext2 = new CollisionContext(GetPlayerInstance(), CannotGoOutside);
collisionContext2.AddGlobalState1(GlobalGameStates.MimiGoingToKnockAtNeighbour);
AddCollisionContext(collisionContext2);

// -------------------------- Third colliding event --------------------------

// Don't let Mimi outside untill she went back to talk to the Youngster again
CannotGoOutside2 = function()
{
	conversationFinished = function()
	{			
		// Give control back to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), CannotGoOutside2);
		collisionContext.AddGlobalState2(GlobalGameStates.MimiGointToYoungsterAgain, GlobalGameStates.MimiWalksToOldtimer);
		AddCollisionContext(collisionContext);
	}
	// Start the monologue
	var c29_1 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
	c29_1.AddSubText(new SubText("I'm not giving up just yet ", 0.2, true));
	RenderText(c29_1);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
	
	// Don't give the control to the player
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext3 = new CollisionContext(GetPlayerInstance(), CannotGoOutside2);
collisionContext3.AddGlobalState2(GlobalGameStates.MimiGointToYoungsterAgain, GlobalGameStates.MimiWalksToOldtimer);
AddCollisionContext(collisionContext3);