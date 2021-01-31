function MimiConversation()
{
	conversationFinished = function()
	{
		// Set the follow speed back to an instant speed
		SetViewportFollowSpeed(1.0);
		
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
		c2_3.AddSubText(new SubText("Anybody there?", 0.2));
		RenderText(c2_3);
	}
	
	cb3_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb3_3);
		c2_2.AddSubText(new SubText("Are you home?!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c3_1 = new TextContext(sprite_mimiAvatarAngry, true, cb3_2);
	c3_1.AddSubText(new SubText("Excuse me! ", 0.2));

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
			var position = PlayerSnapToClosestPosition(m_knockPositionX - 60, GetPlayerInstance().y);
			GetPlayerInstance().m_position = position;
		}

		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, animationEndCallback);
		SetViewportFollowSpeed(0.01);
	}
}

function MimiKnockOnWomenDoor()
{
	if(keyboard_check(vk_space) && m_dirtyFlag == false)
	{
		m_dirtyFlag = true;

		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
	
		// Set Mimi to a fixed position
		var pathPosition = PlayerSnapToClosestPosition(m_knockPositionX, GetPlayerInstance().y);
		GetPlayerInstance().m_position = pathPosition;
		
		MimiConversation();
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiGoingToKnockAtNeighbour:
		MimiKnockOnWomenDoor();
		break;
	default:
		break;
}