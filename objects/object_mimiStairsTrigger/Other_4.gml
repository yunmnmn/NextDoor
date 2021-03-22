// -------------------------- First colliding event --------------------------

RemindToBuyDrink = function()
{		
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext1 = new CollisionContext(GetPlayerInstance(), RemindToBuyDrink);
		collisionContext1.AddGlobalState1(GlobalGameStates.MimiGetsDrink);
		AddCollisionContext(collisionContext1);
	}
	
	// Start the monologue
	var c35_1 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
	c35_1.AddSubText(new SubText("I'm not going to find any drinks upstairs.", 0.3, true));
	RenderText(c35_1);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), RemindToBuyDrink);
collisionContext1.AddGlobalState1(GlobalGameStates.MimiGetsDrink);
AddCollisionContext(collisionContext1);

// -------------------------- Second colliding event --------------------------

ScaredToGoUpstairs = function()
{		
		conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext2 = new CollisionContext(GetPlayerInstance(), ScaredToGoUpstairs);
		collisionContext2.AddGlobalState1(GlobalGameStates.MimiReturnsFromDrinking);
		AddCollisionContext(collisionContext2);
	}
	
	// Start the monologue
	var c36_1 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
	c36_1.AddSubText(new SubText("I'm not going up there, it give me the creeps.", 0.3, true));
	RenderText(c36_1);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext2 = new CollisionContext(GetPlayerInstance(), ScaredToGoUpstairs);
collisionContext2.AddGlobalState1(GlobalGameStates.MimiReturnsFromDrinking);
AddCollisionContext(collisionContext2);