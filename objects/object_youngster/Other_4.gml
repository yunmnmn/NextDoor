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
	c27_1.AddSubText(new SubText("Well, go ask around", 0.2, true));
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

function MimiAndYoungsterConversation()
{
	conversationFinished = function()
	{			
		// Set Mimi to idle
		PlayerPlayAnimation2(sprite_mimiIdle, noone);
		
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiWalksIntoWoman);
	}
	
	cb4_8 = function()
	{
		var c2_8 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
		c2_8.AddSubText(new SubText("Doesn't seem to be anyone around today though", 0.2, true));
		RenderText(c2_8);
	}
	
	cb4_7 = function()
	{
		var c2_7 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_8);
		c2_7.AddSubText(new SubText("Sometimes I hear the door opening and closing", 0.2, true));
		RenderText(c2_7);
	}
	
	cb4_6 = function()
	{
		var c2_6 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_7);
		c2_6.AddSubText(new SubText("I don't think it's empty", 0.2, true));
		RenderText(c2_6);
	}
	
	cb4_5 = function()
	{
		var c2_5 = new TextContext(sprite_mimiAvatarAngry, true, cb4_6);
		c2_5.AddSubText(new SubText("Ofcourse they don't complain, if nobody lives there!", 0.2, true));
		RenderText(c2_5);
			
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the image speed to 0 if the angry animation is still set
			if(GetPlayerInstance().sprite_index == anim_mimiAngry)
			{
				PlayerFreezeAnimationEnd2(anim_mimiAngry);
			}
		}
		PlayerPlayAnimation2(anim_mimiAngry, callbackAngryEnd);

	}
	
	cb4_4 = function()
	{
		var c2_4 = new TextContext(sprite_mimiAvatarTroubled, true, cb4_5);
		c2_4.AddSubText(new SubText("You sure it's not just an empty room?", 0.2, true));
		RenderText(c2_4);
	}
	
	cb4_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarTroubled, true, cb4_4);
		c2_3.AddSubText(new SubText("Away?!", 0.2, true));
		RenderText(c2_3);
	}
	
	cb4_2 = function()
	{
		var c4_2 = new TextContext(sprite_youngsterAvatarSmirk, true, cb4_3);
		c4_2.AddSubText(new SubText("That neighbour seems to be away a lot", 0.2, true));
		RenderText(c4_2);
	}
	
	// Call the parent text context
	var c4_1 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_2);
	c4_1.AddSubText(new SubText("Probably not home", 0.2, true));
	if(RenderText(c4_1))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
	}
}

collisionEvent = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	mirror = (GetPlayerInstance().x > x) ? true : false;
	walkToPosition = function()
	{			
		GetPlayerInstance().SetPathSpeed(0.0);
		PlayerPlayAnimation(sprite_mimiIdle, mirror, noone);
		MimiAndYoungsterConversation();
	}
	PlayerMoveAndExecute(mirror ? x + 100 : x - 100, GetPlayerInstance().y, 1.0, walkToPosition);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AddGlobalState1(GlobalGameStates.MimiGointToYoungsterAgain);
AddCollisionContext(collisionContext);

// -------------------------- Third colliding event --------------------------

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
	var c27_1 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
	c27_1.AddSubText(new SubText("Ah, shit. Not her again...", 0.2, true));
	RenderText(c27_1);
	
	// Disable the control for the player
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterNoticesOldtimer);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
AddCollisionContext(collisionContext);