
// -------------------------- First colliding event --------------------------

function MimiAndYoungsterConversation()
{
	conversationFinished = function()
	{	
		// Follow the player instance again
		SetViewportFollowInstance(GetPlayerInstance());
		
		// Set animation back to idle
		PlayerPlayAnimation2(sprite_mimiIdle, noone);
		
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Set the youngster back to idle
		var animationEndCallback = function()
		{
			instance_youngster.PlayAnimation2(sprite_youngsterIdle, noone);
		};
		// Reverse the youngster point
		instance_youngster.PlayAnimation2(anim_youngsterPoint, animationEndCallback);
		instance_youngster.image_index = 7;
		instance_youngster.image_speed = -1;
		
		// Set the next global state after the conversation is finished
		SetGlobalGameState(GlobalGameStates.MimiGoingToKnockAtNeighbour);
	}
	
	cb2_10 = function()
	{
		var c2_10 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c2_10.AddSubText(new SubText("Watch me! You wait right here!", 0.2, true));
		RenderText(c2_10);
		
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the imgae speed to 0 if the angry animation is still set
			if(GetPlayerInstance().sprite_index == anim_mimiAngry)
			{
				PlayerFreezeAnimationEnd2(anim_mimiAngry);
			}
		}
		PlayerPlayAnimation2(anim_mimiAngry, callbackAngryEnd);
	}
	
	cb2_9 = function()
	{
		var c2_9 = new TextContext(sprite_youngsterAvatarSmirk, true, cb2_10);
		c2_9.AddSubText(new SubText("If the neighbour says it's too loud, I'll think about it.", 0.2, true));
		RenderText(c2_9);
	}
	
	cb2_8 = function()
	{
		var c2_8 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_9);
		c2_8.AddSubText(new SubText("Maybe you're just too uptight.", 0.2, true));
		RenderText(c2_8);
		
		var animationEndCallback = function()
		{
			instance_youngster.FreezeAnimationAtEnd2(anim_youngsterPoint);
		};
		instance_youngster.PlayAnimation2(anim_youngsterPoint, animationEndCallback);
	}
	
	cb2_7 = function()
	{
		var c2_7 = new TextContext(sprite_mimiAvatarAngry, true, cb2_8);
		c2_7.AddSubText(new SubText("You're disturbing the peace!", 0.2, true));
		RenderText(c2_7);
	}
	
	cb2_6 = function()
	{
		var c2_6 = new TextContext(sprite_mimiAvatarAngry, true, cb2_7);
		c2_6.AddSubText(new SubText("Yes it is!", 0.2, true));
		RenderText(c2_6);
		
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the imgae speed to 0 if the angry animation is still set
			if(GetPlayerInstance().sprite_index == anim_mimiAngry)
			{
				PlayerFreezeAnimationEnd2(anim_mimiAngry);
			}
		}
		PlayerPlayAnimation2(anim_mimiAngry, callbackAngryEnd);
	}
	
	cb2_5 = function()
	{
		var c2_5 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_6);
		c2_5.AddSubText(new SubText("I don't think it's so loud.", 0.2, true));
		RenderText(c2_5);
	}
	
	cb2_4 = function()
	{
		var c2_4 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_5);
		c2_4.AddSubText(new SubText("I do?", 0.2, true));
		RenderText(c2_4);
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, cb2_4);
		c2_3.AddSubText(new SubText("You always have it unbearably loud!", 0.2, true));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		instance_hallwayUpMemory.SetDoorYoungsterVisible(true);
		instance_hallwayUpMemory.SetYoungsterVisible(true);
		
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb2_3);
		c2_2.AddSubText(new SubText("Could you please lower the volume?!", 0.2, true));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarAngry, false, cb2_2);
	c2_1.AddSubText(new SubText("Hello?!", 0.2, true));

	// Call the parent text context
	if(RenderText(c2_1))
	{
		// Disable progressing this TextContext untill Mimi's knocking animation has finished playing
		GetCurrentTextContext().m_progressable = false;
		
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
		
		var SetIdleWhenKnockingFinish = function()
		{
			// Enable progressing this TextContext 
			GetCurrentTextContext().m_progressable = true;
			
			// Set mimi back to idle
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
			
			// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
			PlayerSnapToClosestPosition(x - 61, GetPlayerInstance().y, true);
		}
		
		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, SetIdleWhenKnockingFinish);
	}
}

MimiToYoungster = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);

	// Walk to the position to knock
	var walkToPosition = function()
	{
		DisableFollowingInstance();
		GetPlayerInstance().SetPathSpeed(0.0);
			
		MimiAndYoungsterConversation();
	}
	PlayerMoveAndExecute(x, GetPlayerInstance().y, 1.0, walkToPosition);
}

// First use of the collider
var collisionContext = new CollisionContext(GetPlayerInstance(), MimiToYoungster);
collisionContext.AddGlobalState2(GlobalGameStates.MimiGoingToYoungster);
AddCollisionContext(collisionContext);

// -------------------------- Second colliding event --------------------------

function MimiKnocksOnDoorConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiEntersYoungstersRoom);
		
		// Let the viewport follow the player again
		// TODO: This shouldn't have to, check why
		SetViewportFollowInstance(GetPlayerInstance());
	}
	
	cb14_3 = function()
	{	
		var c14_3 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c14_3.AddSubText(new SubText("The door seems to be open.", 0.2, true));
		RenderText(c14_3);
	}
	
	cb14_2 = function()
	{	
		var c14_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb14_3);
		c14_2.AddSubText(new SubText("Are you okay?", 0.2, true));
		RenderText(c14_2);
	}

	// Start of the conversation. Doesn't require a function
	var c14_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb14_2);
	c14_1.AddSubText(new SubText("Hello?! ", 0.6, true));

	// Call the parent text context
	if(RenderText(c14_1))
	{
		// Disable progressing this TextContext untill Mimi's knocking animation has finished playing
		GetCurrentTextContext().m_progressable = false;
		
		// Give the player control back
		SetControlState(PlayerControlState.PlayerNoControl);
		
		var SetIdleWhenKnockingFinish = function()
		{
			// Enable progressing this TextContext 
			GetCurrentTextContext().m_progressable = true;
			
			// Set mimi back to idle scared
			PlayerPlayAndFreezeAtEnd(anim_mimiIdleToScared, false);
			
			// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
			PlayerSnapToClosestPosition(x - 61, GetPlayerInstance().y, true);
		}
		
		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, SetIdleWhenKnockingFinish);
	}
}

MimiChecksOnYoungster = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);

	// Walk to the position to knock
	var walkToPosition = function()
	{
		GetPlayerInstance().SetPathSpeed(0.0);
			
		MimiKnocksOnDoorConversation();
	}
	PlayerMoveAndExecute(x, GetPlayerInstance().y, 1.0, walkToPosition);
}

// Second use of the collider
var collisionContext2 = new CollisionContext(GetPlayerInstance(), MimiChecksOnYoungster);
collisionContext2.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
AddCollisionContext(collisionContext2);

// -------------------------- Third colliding event --------------------------

// Transition HallwayUp -> Youngster's room 
function collisionEvent()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);
	
	// Fade, and when finished, load the hallway
	{
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			
			var pathPosition = SnapToClosestPosition(path_youngsterRoom, 1600, 342);
			ChangeRoomAndSetPath(room_youngsterRoom, path_youngsterRoom, pathPosition, true);
		}
		CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
	}
}

// Third use of the collider
var collisionContext3 = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext3.AddGlobalState1(GlobalGameStates.MimiEntersYoungstersRoom);
AddCollisionContext(collisionContext3);


// HACK: Add a trigger when the door is closed by youngster
YoungsterSlamsDoorDialogue = function()
{		
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	// Start the monologue
	var c34_1 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
	c34_1.AddSubText(new SubText("I can't believe this guy!", 0.2, true));
	RenderText(c34_1);
	
	// Set Mimi to idle	
	PlayerPlayAnimation2(sprite_mimiIdle, noone);
	
	// Disable the control for the player
	SetControlState(PlayerControlState.PlayerNoControl);
}

AddDialogueAfterYoungsterSlamsDoor = function()
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterSlamsDoorDialogue);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
	AddCollisionContext(collisionContext);
}