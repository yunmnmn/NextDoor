function MimiConversationYoungster()
{
	if(keyboard_check(vk_space) && m_dirtyFlag == false)
	{
		m_dirtyFlag = true;
	
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Set Mimi to idle
		if(GetPlayerInstance().x > x)
		{
			PlayerPlayAnimation(sprite_mimiIdle, true, noone);
		}
		else
		{
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		}
		
		// Play the conversation
		MimiAndYoungsterConversation();
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiGointToYoungsterAgain:
		MimiConversationYoungster();
		break;
	default:
		break;
}

function MimiAndYoungsterConversation()
{
	conversationFinished = function()
	{	
		// Set the image properties back to normal
		m_player.image_speed = 1;
		m_player.image_index = 0;
		
		// Set Mimi to idle
		if(GetPlayerInstance().x > x)
		{
			PlayerPlayAnimation(sprite_mimiIdle, true, noone);
		}
		else
		{
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		}
		
		// Give control back to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiWalksIntoWoman);
	}
	
	cb4_8 = function()
	{
		var c2_8 = new TextContext(sprite_youngsterAvatarNormal, true, conversationFinished);
		c2_8.AddSubText(new SubText("Doesn’t seem to be anyone around today though", 0.2));
		RenderText(c2_8);
	}
	
	cb4_7 = function()
	{
		var c2_7 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_8);
		c2_7.AddSubText(new SubText("Sometimes I hear the door opening and closing", 0.2));
		RenderText(c2_7);
	}
	
	cb4_6 = function()
	{
		var c2_6 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_7);
		c2_6.AddSubText(new SubText("I don't think it's empty", 0.2));
		RenderText(c2_6);
	}
	
	cb4_5 = function()
	{
		var c2_5 = new TextContext(sprite_mimiAvatarAngry, true, cb4_6);
		c2_5.AddSubText(new SubText("Ofcourse they don't complain, if nobody lives there!", 0.2));
		RenderText(c2_5);
			
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the image speed to 0 if the angry animation is still set
			if(m_player.sprite_index == anim_mimiAngry)
			{
				m_player.image_speed = 0;
				m_player.image_index = 4;
			}
		}
		if(GetPlayerInstance().x > x)
		{
			PlayerPlayAnimation(anim_mimiAngry, true, callbackAngryEnd);
		}
		else
		{
			PlayerPlayAnimation(anim_mimiAngry, false, callbackAngryEnd);
		}

	}
	
	cb4_4 = function()
	{
		var c2_4 = new TextContext(sprite_mimiAvatarTroubled, true, cb4_5);
		c2_4.AddSubText(new SubText("You sure it's not just an empty room?", 0.2));
		RenderText(c2_4);
	}
	
	cb4_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarTroubled, true, cb4_4);
		c2_3.AddSubText(new SubText("Away?!", 0.2));
		RenderText(c2_3);
	}
	
	cb4_2 = function()
	{
		var c4_2 = new TextContext(sprite_youngsterAvatarSmirk, true, cb4_3);
		c4_2.AddSubText(new SubText("That neighbour seems to be away a lot", 0.2));
		RenderText(c4_2);
	}
	
	// Call the parent text context
	var c4_1 = new TextContext(sprite_youngsterAvatarNormal, true, cb4_2);
	c4_1.AddSubText(new SubText("Probably not home", 0.2));
	if(RenderText(c4_1))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
	}
}