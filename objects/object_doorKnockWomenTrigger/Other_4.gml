function MimiConversation()
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
		var c4_8 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
		c4_8.AddSubText(new SubText("Doesn't seem to be anyone around today though.", 0.3, true));
		RenderText(c4_8);
	}
	
	cb4_7 = function()
	{
		var c4_7 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_8);
		c4_7.AddSubText(new SubText("Sometimes I hear the door opening and closing.", 0.3, true));
		RenderText(c4_7);
	}
	
	cb4_6 = function()
	{
		var c4_6 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_7);
		c4_6.AddSubText(new SubText("No, it isn't empty.", 0.3, true));
		RenderText(c4_6);
	}
	
	cb4_5 = function()
	{
		var c4_5 = new TextContext(sprite_mimiAvatarAngry, true, cb4_6);
		c4_5.AddSubText(new SubText("Of course they don't complain, if nobody lives there!", 0.4, true));
		RenderText(c4_5);
			
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
	
	walkToYoungster_cb4_4 = function()
	{
		// Walk towards the youngster again
		var walkToPosition = function()
		{	
			// TODO: Currently necessary for each PlayerMoveAndExecute function, make this obsolete
			GetPlayerInstance().SetPathSpeed(0.0);
			
			// Make it progressable again when Mimi reaches the destination
			GetCurrentTextContext().m_progressable = true;
			
			// Set Mimi back to Idle when she reaches her destination
			PlayerFreezeAnimationEnd2(sprite_mimiIdle);
		}
		PlayerMoveAndExecute(360, 355, 1.0, walkToPosition);
		
		// Walk walking, play line 4.2
		var c4_4 = new TextContext(sprite_mimiAvatarTroubled, true, cb4_5);
		c4_4.AddSubText(new SubText("You sure it's not just an empty room?", 0.3, true));
		c4_4.m_progressable = false;
		RenderText(c4_4);
	}
	
	cb4_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarTroubled, true, walkToYoungster_cb4_4);
		c2_3.AddSubText(new SubText("Away?!", 0.6, true));
		RenderText(c2_3);
	}
	
	cb4_2 = function()
	{
		var c4_2 = new TextContext(sprite_youngsterAvatarSmirk, true, cb4_3);
		c4_2.AddSubText(new SubText("They seem to be away a lot.", 0.3, true));
		RenderText(c4_2);
	}
	
	// Call the parent text context
	cb4_1 = function()
	{
		var c4_1 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_2);
		c4_1.AddSubText(new SubText("Probably not home...", 0.3, true));
		RenderText(c4_1)
	}
	
	cb3_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, cb4_1);
		c2_3.AddSubText(new SubText("Anybody there?", 0.4, true));
		RenderText(c2_3);
	}
	
	cb3_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb3_3);
		c2_2.AddSubText(new SubText("Are you home?!", 0.4, true));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c3_1 = new TextContext(sprite_mimiAvatarAngry, true, cb3_2);
	c3_1.AddSubText(new SubText("Excuse me! ", 0.4, true));

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
			PlayerSnapToClosestPosition(x - 60, GetPlayerInstance().y, false);
			
			// Follow the player slowly while she is knocking
			followCallback = function()
			{
				// Set the follow speed back to an instant speed
				SetViewportFollowSpeed(1.0);
				SetViewportFollowInstance(GetPlayerInstance());
			}
			FollowPositionAndCallback(new Vector2(x - 60, GetPlayerInstance().y), followCallback)
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