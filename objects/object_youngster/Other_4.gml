// -------------------------- First colliding event --------------------------

YoungsterIsWaiting = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterIsWaiting);
		collisionContext.AddGlobalState2(GlobalGameStates.MimiGoingToKnockAtNeighbour, GlobalGameStates.MimiWalksIntoWoman);
		AddCollisionContext(collisionContext);
	}
	
	// Start the conversation
	var c27_1 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
	c27_1.AddSubText(new SubText("Well? Go ask!", 0.4, true));
	RenderText(c27_1);
	
	// Disable the control for the player
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterIsWaiting);
collisionContext.AddGlobalState2(GlobalGameStates.MimiGoingToKnockAtNeighbour, GlobalGameStates.MimiWalksIntoWoman);
AddCollisionContext(collisionContext);

// -------------------------- Second colliding event --------------------------

YoungsterNoticesOldtimer = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// TODO: make sure this works...
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterNoticesOldtimer);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
		AddCollisionContext(collisionContext);
	}
	
	// Start the conversation
	var c42_1 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
	c42_1.AddSubText(new SubText("Tsk, not her again...", 0.3, true));
	RenderText(c42_1);
	
	// Disable the control for the player
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterNoticesOldtimer);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
AddCollisionContext(collisionContext);

// -------------------------- Sounds --------------------------

// Set the sound for youngster flick
var youngsterPoint = new SoundContext(foley_hallwayYoungsterPointCloth, anim_youngsterPoint, 1);
youngsterPoint.SetPersistent(true);
AddSoundContext(youngsterPoint);