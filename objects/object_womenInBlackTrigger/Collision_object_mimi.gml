function WomenInBlackConversation()
{
	conversationFinished = function()
	{
		// Set the oldtimer to be the following object
		SetViewportFollowInstance(GetPlayerInstance());
		// Set the following speed
		// NOTE: the followspeed will be set back again when the player hits the green trigger
		SetViewportFollowSpeed(0.005);
		
		// Set the idle animation
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiWalksToOldtimer);
	}
	
	cb6_2 = function()
	{
		// Set the oldtimer to be the following object
		SetViewportFollowInstance(instance_oldtimer);
		// Set the following speed
		SetViewportFollowSpeed(0.005);
		
		var c6_2 = new TextContext(sprite_oldtimerAvatarAngry, true, conversationFinished);
		c6_2.AddSubText(new SubText("Could you argue somewhere else, please?", 0.2));
		RenderText(c6_2);
	}
	
	cb6_1 = function()
	{
		// Set the oldtimer visible
		instance_hallwayUpMemory.SetDoorOldtimerVisible(true);
		instance_hallwayUpMemory.SetOldtimerVisible(true);
		
		var c6_1 = new TextContext(sprite_oldtimerAvatarAngry, true, cb6_2);
		c6_1.AddSubText(new SubText("What's going on?", 0.2));
		RenderText(c6_1);
	}
	
	cb5_7 = function()
	{
		var c5_7 = new TextContext(sprite_youngsterAvatarNormal, true, cb6_1);
		c5_7.AddSubText(new SubText("Why all the black?", 0.2));
		RenderText(c5_7);
	}
	
	cb5_6 = function()
	{
		var c5_6 = new TextContext(sprite_youngsterAvatarNormal, true, cb5_7);
		c5_6.AddSubText(new SubText("That's the first time I ever seen her", 0.2));
		RenderText(c5_6);
	}
	
	cb5_5 = function()
	{
		var c5_5 = new TextContext(sprite_youngsterAvatarNormal, true, cb5_6);
		c5_5.AddSubText(new SubText("Looked kind of freaky too", 0.2));
		RenderText(c5_5);
	}
	
	cb5_4 = function()
	{
		var c5_4 = new TextContext(sprite_youngsterAvatarNormal, true, cb5_5);
		c5_4.AddSubText(new SubText("She was home?", 0.2));
		RenderText(c5_4);
	}
	
	cb5_3 = function()
	{
		var c5_3 = new TextContext(sprite_mimiAvatarTroubled, true, cb5_4);
		c5_3.AddSubText(new SubText("?", 0.2));
		RenderText(c5_3);
	}
	
	cb5_2 = function()
	{
		// Set women invisible, and to the default state
		instance_hallwayUpMemory.SetWomenVisible(false);
		instance_women.SetPath(path_hallwayUpWomen, 0.0, 0.0);
		instance_women.PlayAnimation(sprite_womenIdle);
		
		var c5_2 = new TextContext(sprite_youngsterAvatarNormal, true, cb5_3);
		c5_2.AddSubText(new SubText("?", 0.2));
		RenderText(c5_2);
	}
	
	womenAppearsCallback = function()
	{
		// Set the path for the women to walk out of the screen
		instance_women.SetPath(path_hallwayUpWomen, 0.0, instance_women.m_speed);
		// Play the walking animation
		instance_women.PlayAnimation(anim_womenWalk);
		// Mirror the animation, the Women's walk is by default to the left
		instance_women.Mirror(true);
		// Close the door again
		instance_hallwayUpMemory.SetDoorWomenVisible(false);
		
		// Play the callback when the women reached the end
		instance_women.AddPathEndCallback(cb5_2, false);
	}

	// Start of the conversation. Doesn't require a function
	var c5_1 = new TextContext(sprite_womanAvatar, true, womenAppearsCallback);
	c5_1.AddSubText(new SubText("...", 0.2));
	RenderText(c5_1);
}

function MimiToWomenInBlack()
{
	if(m_dirtyFlag == false)
	{
		m_dirtyFlag = true;

		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Set the idle animation
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Make Women and door visible
		instance_hallwayUpMemory.SetDoorWomenVisible(true);
		instance_hallwayUpMemory.SetWomenVisible(true);
		
		// Set the Women in black to the Path
		instance_women.SetPath(path_hallwayUpWomen, 0.0, 0.0);
		
		// Play the conversation with the women in black
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