function MimiToWomenInBlack()
{
	if(m_dirtyFlag == false)
	{
		m_dirtyFlag = true;

		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Set the idle animation
		PlayerPlayAnimation(sprite_mimiIdle, noone);
		
		WomenInBlackConversation();
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiWalksIntoWoman:
		MimiToWomenInBlack();
		break;
	default:
		break;
}

function WomenInBlackConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		PlayerPlayAnimation(sprite_mimiIdle, noone);
		
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
		
		// Set the player image speed back
		m_player.image_speed = 1;
		
		// Set the next global state after the conversation is finished
		SetGlobalGameState(GlobalGameStates.MimiGoingToKnockAtNeighbour);
	}
	
	cb5_5 = function()
	{
		var c2_5 = new TextContext(sprite_youngsterAvatarNormal, cb2_6);
		c2_5.AddSubText(new SubText("I don't think it's so loud.", 0.2));
		RenderText(c2_5);
	}
	
	cb5_4 = function()
	{
		var c2_4 = new TextContext(sprite_youngsterAvatarNormal, cb2_5);
		c2_4.AddSubText(new SubText("I do?", 0.2));
		RenderText(c2_4);
	}
	
	cb5_3 = function()
	{
		var c5_3 = new TextContext(sprite_mimiAvatarAngry, cb5_4);
		c5_3.AddSubText(new SubText("You always have it unbearably loud!", 0.2));
		RenderText(c5_3);
	}
	
	cb5_2 = function()
	{
		// TODO: hide the door again
		// TODO: let wib walk out of screen to the right

		
		var c5_2 = new TextContext(sprite_mimiAvatarAngry, cb5_3);
		c5_2.AddSubText(new SubText("Could you please lower the volume?!", 0.2));
		RenderText(c5_2);
	}
	
	
	//TODO: set the door and wib visible

	// Start of the conversation. Doesn't require a function
	var c5_1 = new TextContext(sprite_womanAvatar, cb5_2);
	c5_1.AddSubText(new SubText("...", 0.2));
	RenderText(c5_1);
}