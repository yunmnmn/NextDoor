function MimiConversation()
{		
	conversationFinished = function()
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	cb11_4 = function()
	{
		var c11_4 = new TextContext(sprite_youngsterAvatarScared, true, conversationFinished);
		c11_4.AddSubText(new SubText("Don't sneak up on me like that", 0.2));
		RenderText(c11_4);
	}
	
	cb11_3 = function()
	{
		var c11_3 = new TextContext(sprite_youngsterAvatarScared, true, cb11_4);
		c11_3.AddSubText(new SubText("Oh it's you ", 0.2));
		RenderText(c11_3);
	}
	
	cb11_2 = function()
	{
		var c11_2 = new TextContext(sprite_youngsterAvatarScared, true, cb11_3);
		c11_2.AddSubText(new SubText("?!", 0.2));
		RenderText(c11_2);
	}
	
	var c11_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_2);
	c11_1.AddSubText(new SubText("It's that guy from upstairs", 0.2));
	
	// Call the parent text context
	if(RenderText(c11_1))
	{
		// Disable progressing this TextContext untill Mimi's shock animation is finished
		GetCurrentTextContext().m_progressable = false;
		
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
		
		var SetIdleWHenShockFinish = function()
		{
			// Enable progressing this TextContext 
			GetCurrentTextContext().m_progressable = true;
			
			// Set mimi back to idle
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		}
		
		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiShock, false, SetIdleWHenShockFinish);
	}
}

function MimiBuysDrink()
{
	if(keyboard_check(vk_space) && m_dirtyFlag == false)
	{
		m_dirtyFlag = true;
		
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Play the coin animation
		var animationEnd = function()
		{
			// Set Mimi's animation to idle
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
			// Start the conversation
			MimiConversation();
		}
		PlayerPlayAnimation(anim_mimiCoin, false, animationEnd);
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiGetsDrink:
		MimiBuysDrink();
		break;
	default:
		break;
}