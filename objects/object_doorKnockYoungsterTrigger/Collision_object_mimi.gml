function MimiToYoungster()
{
	if(keyboard_check(vk_space) && m_dirtyFlag == false)
	{
		m_dirtyFlag = true;

		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);

		// Set Mimi to a fixed position
		var position = SnapToClosestPosition(m_knockPositionX, m_player.y);
		m_player.m_position = position;
			
		MimiAndYoungsterConversation();
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiRoomSits:
	case GlobalGameStates.MimiGoingToYoungster:
		MimiToYoungster();
		break;
	//case GlobalGameStates.MimiGoingToAskNeighbours:
	default:
		m_youngster.visible = true;
		m_openDoorMask.visible = true;
		break;
}

function MimiAndYoungsterConversation()
{
	conversationFinished = function()
	{
		// Set the player image speed back
		m_player.image_speed = 1;
		
		// Set animation back to idle
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Set the youngster back to idle
		var animationEndCallback = function()
		{
			m_youngster.PlayAnimation(sprite_youngsterIdle, noone);
			m_youngster.image_speed = 1;
		};
		// Reverse the youngster point
		m_youngster.PlayAnimation(anim_youngsterPoint, animationEndCallback);
		m_youngster.image_index = 7;
		m_youngster.image_speed = -1;
		
		// Set the next global state after the conversation is finished
		SetGlobalGameState(GlobalGameStates.MimiGoingToKnockAtNeighbour);
	}
	
	cb2_10 = function()
	{
		var c2_10 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c2_10.AddSubText(new SubText("Watch me! You wait right here!", 0.2));
		RenderText(c2_10);
		
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the imgae speed to 0 if the angry animation is still set
			if(m_player.sprite_index == anim_mimiAngry)
			{
				m_player.image_speed = 0;
				m_player.image_index = 4;
			}
		}
		m_player.image_speed = 1;
		m_player.image_index = 0;
		PlayerPlayAnimation(anim_mimiAngry, false, callbackAngryEnd);
	}
	
	cb2_9 = function()
	{
		var c2_9 = new TextContext(sprite_youngsterAvatarSmirk, true, cb2_10);
		c2_9.AddSubText(new SubText("If the neighbour says it's too loud, I'll think about it.", 0.2));
		RenderText(c2_9);
	}
	
	cb2_8 = function()
	{
		var c2_8 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_9);
		c2_8.AddSubText(new SubText("Maybe you're just too uptight.", 0.2));
		RenderText(c2_8);
		
		var animationEndCallback = function()
		{
			m_youngster.image_speed = 0;
			m_youngster.image_index = 7;
		};
		m_youngster.PlayAnimation(anim_youngsterPoint, animationEndCallback);
	}
	
	cb2_7 = function()
	{
		var c2_7 = new TextContext(sprite_mimiAvatarAngry, true, cb2_8);
		c2_7.AddSubText(new SubText("You're disturbing the peace!", 0.2));
		RenderText(c2_7);
	}
	
	cb2_6 = function()
	{
		var c2_6 = new TextContext(sprite_mimiAvatarAngry, true, cb2_7);
		c2_6.AddSubText(new SubText("Yes it is!", 0.2));
		RenderText(c2_6);
		
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the imgae speed to 0 if the angry animation is still set
			if(m_player.sprite_index == anim_mimiAngry)
			{
				m_player.image_speed = 0;
				m_player.image_index = 4;
			}
		}
		PlayerPlayAnimation(anim_mimiAngry, false, callbackAngryEnd);
	}
	
	cb2_5 = function()
	{
		var c2_5 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_6);
		c2_5.AddSubText(new SubText("I don't think it's so loud.", 0.2));
		RenderText(c2_5);
	}
	
	cb2_4 = function()
	{
		var c2_4 = new TextContext(sprite_youngsterAvatarNormal, true, cb2_5);
		c2_4.AddSubText(new SubText("I do?", 0.2));
		RenderText(c2_4);
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, cb2_4);
		c2_3.AddSubText(new SubText("You always have it unbearably loud!", 0.2));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		instance_hallwayUpMemory.SetDoorYoungsterVisible(true);
		instance_hallwayUpMemory.SetYoungsterVisible(true);
		
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb2_3);
		c2_2.AddSubText(new SubText("Could you please lower the volume?!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarAngry, false, cb2_2);
	c2_1.AddSubText(new SubText("Hello?!", 0.2));

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
			var position = SnapToClosestPosition(m_knockPositionX - 60, m_player.y);
			m_player.m_position = position;
		}
		
		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, false, SetIdleWhenKnockingFinish);
	}
}