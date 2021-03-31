// Inherit the parent event
event_inherited();

m_transition = 0.0;
m_transitionSpeed = 0.0002;
m_startDayNightTransition = false;

//
m_talkingFinished = false;
m_cachedDivv = noone;

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
		
		// Play the StandUp sound
		PlaySound(foley_appartmentStandUp, 10.0, false);
	}
	
	cb1_4 = function()
	{
		var c1_4 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c1_4.AddSubText(new SubText("I should give the guy upstairs a piece of my mind!", 0.3, true));
		RenderText(c1_4);
	}
	
	cb1_3 = function()
	{
		var c1_3 = new TextContext(sprite_mimiAvatarAngry, true, cb1_4);
		c1_3.AddSubText(new SubText("I can't study with this noise all the time!", 0.3, true));
		RenderText(c1_3);
	}
	
	cb1_2 = function()
	{		
		// Don't draw the action prompt
		instance_global.DrawActionPressPrompt(false, 170, 150);
		
		var c1_2 = new TextContext(sprite_mimiAvatarAngry, true, cb1_3);
		c1_2.AddSubText(new SubText("Oh, come on!", 0.3, true));
		RenderText(c1_2);
	}

	// Start of the conversation. Doesn't require a function
	var c1_1 = new TextContext(sprite_mimiAvatarNormal, true, cb1_2);
	c1_1.AddSubText(new SubText("...", 0.3, true));
	RenderText(c1_1);

	// Set the next global state after the animation is finished playing
	SetGlobalGameState(GlobalGameStates.MimiGoingToYoungster);	
	
	// Draw the action prompt
	instance_global.DrawActionPressPrompt(true, 578, 430);
}

MimiComplainsAboutNoise = function()
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
		
		// Play the StandUp sound
		PlaySound(foley_appartmentStandUp, 10.0, false);
	}
	
	cb10_3 = function()
	{
		var c10_3 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
		c10_3.AddSubText(new SubText("I could really use a drink.", 0.3, true));
		RenderText(c10_3);
	}
	
	cb10_2 = function()
	{
		var c10_2 = new TextContext(sprite_mimiAvatarNormal, true, cb10_3);
		c10_2.AddSubText(new SubText("It's already dark.", 0.3, true));
		RenderText(c10_2);
	}

	var c10_1 = new TextContext(sprite_mimiAvatarNormal, true, cb10_2);
	c10_1.AddSubText(new SubText("Phew!", 0.4, true));
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
	case GlobalGameStates.MimiGoingToYoungster:
	case GlobalGameStates.MimiWalksBackToRoom:
		// Play the new room music
		PlayRoomMusic(music_metalMimiRoom, "Metal", true, 1, true);
		// Set the volume
		SoundGain(GetRoomMusic(), 1.0, 500);
		break;
	default:
		break;
}