function MimiKnockOnWomenDoor()
{
	if(keyboard_check(vk_space) && m_dirtyFlag == false)
	{
		m_dirtyFlag = true;

		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
	
		// Set Mimi to a fixed position
		var pathPosition = SnapToClosestPosition(m_knockPositionX, m_player.y);
		m_player.m_position = pathPosition;
		
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

function MimiConversation()
{
	conversationFinished = function()
	{
		// Set the follow speed back to an instant speed
		SetFollowSpeed(1.0);
		
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiGointToYoungsterAgain);
	}
	
	cb3_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, conversationFinished);
		c2_3.AddSubText(new SubText("Anybody there?", 0.2));
		RenderText(c2_3);
	}
	
	cb3_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, cb3_3);
		c2_2.AddSubText(new SubText("Are you home?!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c3_1 = new TextContext(sprite_mimiAvatarAngry, cb3_2);
	c3_1.AddSubText(new SubText("Excuse me! ", 0.2));

	// Call the parent text context
	if(RenderText(c3_1))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// When the knocking animation is finished, execute this callback
		var animationEndCallback = function()
		{				
			// Set the animation back to idle
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
				
			// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
			var position = SnapToClosestPosition(m_knockPositionX - 60, m_player.y);
			m_player.m_position = position;
		}

		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, animationEndCallback);
		SetFollowSpeed(0.01);
	}
}