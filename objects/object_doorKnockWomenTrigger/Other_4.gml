function MimiConversation()
{
	conversationFinished = function()
	{
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiGointToYoungsterAgain);
		
		// Set the animation back to idle
		PlayerPlayAnimation2(sprite_mimiIdle, noone);
	}
	
	cb3_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c2_3.AddSubText(new SubText("Anybody there?", 0.2, true));
		RenderText(c2_3);
	}
	
	cb3_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb3_3);
		c2_2.AddSubText(new SubText("Are you home?!", 0.2, true));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c3_1 = new TextContext(sprite_mimiAvatarAngry, true, cb3_2);
	c3_1.AddSubText(new SubText("Excuse me! ", 0.2, true));

	// Call the parent text context
	if(RenderText(c3_1))
	{		
		// Disable progressing this TextContext untill Mimi's knocking animation has finished playing
		GetCurrentTextContext().m_progressable = false;
		
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// When the knocking animation is finished, execute this callback
		var animationEndCallback = function()
		{				
			// Enable progressing this TextContext 
			GetCurrentTextContext().m_progressable = true;
			
			// Set the animation back to idle
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
				
			// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
			PlayerSnapToClosestPosition(x - 61, GetPlayerInstance().y, false);
			
			// Follow the player slowly while she is knocking
			followCallback = function()
			{
				// Set the follow speed back to an instant speed
				SetViewportFollowSpeed(1.0);
				SetViewportFollowInstance(GetPlayerInstance());
			}
			FollowPositionAndCallback(new Vector2(x - 61, GetPlayerInstance().y), followCallback)
		}

		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, animationEndCallback);
		SetViewportFollowSpeed(0.003);
	}
}

MimiKnockOnWomenDoor = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Walk to the position to knock
	var walkToPosition = function()
	{
		GetPlayerInstance().SetPathSpeed(0.0);
			
		MimiConversation();
	}
	PlayerMoveAndExecute(x, GetPlayerInstance().y, 1.0, walkToPosition);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiKnockOnWomenDoor);
collisionContext.AddGlobalState1(GlobalGameStates.MimiGoingToKnockAtNeighbour);
AddCollisionContext(collisionContext);