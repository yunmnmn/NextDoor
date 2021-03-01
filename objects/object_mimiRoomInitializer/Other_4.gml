// Inherit the parent event
event_inherited();

m_transition = 0.0;
m_transitionSpeed = 0.0002;
m_startDayNightTransition = false;

function StartTransition()
{
	m_transition = 0.0;
	m_startDayNightTransition = true;
}

// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	m_transition = 0.0;
}
else
{
	m_transition = 1.0;
}

function MimiConversation()
{
	conversationFinished = function()
	{		
		var animationEndCallback = function()
		{
			// Play the idle animation
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
			// Give the control back to the player
			SetControlState(PlayerControlState.PlayerControl);
			
			// Draw the button prompts
			instance_global.DrawMovingPrompt(true, 175, 124);
			
			m_talkingFinished = true;
		}
		// Set the animation speed back when it's finished playing the conversation
		// Play the sitting animation
		PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
	}
	
	cb2_4 = function()
	{
		var c2_4 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c2_4.AddSubText(new SubText("I should give the guy upstairs a piece of my mind!", 0.2, true));
		RenderText(c2_4);
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, cb2_4);
		c2_3.AddSubText(new SubText("I can't study with this noise all the time!", 0.2, true));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb2_3);
		c2_2.AddSubText(new SubText("Oh, come on!", 0.2, true));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarNormal, true, cb2_2);
	c2_1.AddSubText(new SubText("...", 0.6, true));
	
	// Set the next global state after the animation is finished playing
	SetGlobalGameState(GlobalGameStates.MimiGoingToYoungster);

	// Call the parent text context
	RenderText(c2_1);
}

function MimiComplainsAboutNoise()
{
	// HACK: one time thing
	global.m_path = path_mimiRoom;
	
	// Don't give the control to the player at the beginning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Set Mimi on the path
	PlayerSetPath(path_mimiRoom, 0.0);
	
	// Set the sitting animation	
	// Set the animation speed to 0
	PlayerFreezeAnimation(anim_mimiSit, 0, false);
	
	// Set the conversation
	MimiConversation();
	
	// Pulse the screen here
	PulseScreen(1.0);
}

function MimiConversation2()
{
	conversationFinished = function()
	{
		// Set the sitting animation
		var animationEndCallback = function()
		{
			// Play the idle animation
			PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
			// Give the control back to the player
			SetControlState(PlayerControlState.PlayerControl);
		}
		// Set the animation speed back when it's finished playing the conversation
		// Play the sitting animation
		PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
	}
	
	cb10_3 = function()
	{
		var c10_3 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
		c10_3.AddSubText(new SubText("I could really use a drink.", 0.2, true));
		RenderText(c10_3);
	}
	
	cb10_2 = function()
	{
		var c10_2 = new TextContext(sprite_mimiAvatarNormal, true, cb10_3);
		c10_2.AddSubText(new SubText("I've been studying for so long...", 0.2, true));
		RenderText(c10_2);
	}

	var c10_1 = new TextContext(sprite_mimiAvatarNormal, true, cb10_2);
	c10_1.AddSubText(new SubText("Phew!", 0.2, true));
	RenderText(c10_1);
}

function MimiGetsDrink()
{
	// Don't give the control to the player at the beginning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set the next global state after the animation is finished playing
	SetGlobalGameState(GlobalGameStates.MimiGetsDrink);
	
	// Play the sitting animation, start it frozen on the first frame
	PlayerFreezeAnimation(anim_mimiSit, 0, false);
	
	MimiConversation2();
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiRoomSits:
		MimiComplainsAboutNoise();
		break;
	default:
		break;
}

//
m_talkingFinished = false;
