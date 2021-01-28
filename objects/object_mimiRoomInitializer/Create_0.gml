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
		
			// Set the next global state after the animation is finished playing
			SetGlobalGameState(GlobalGameStates.MimiGoingToYoungster);
		}
		// Set the animation speed back when it's finished playing the conversation
		// Play the sitting animation
		PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
		GetPlayerInstance().image_speed = 1;
		GetPlayerInstance().image_index = 0;
		// Set the animation speed back when it's finished playing the conversation
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, true, conversationFinished);
		c2_3.AddSubText(new SubText("I can't study with this noise all the time! ", 0.2));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, true, cb2_3);
		c2_2.AddSubText(new SubText("Oh, come on!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarNormal, true, cb2_2);
	c2_1.AddSubText(new SubText("...", 0.6));

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
	PlayerPlayAnimation(anim_mimiSit, false, noone);
	// Set the animation speed to 0
	GetPlayerInstance().image_speed = 0;
	GetPlayerInstance().image_index = 0;
	
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
		
			// Set the next global state after the animation is finished playing
			SetGlobalGameState(GlobalGameStates.MimiGetsDrink);
		}
		// Set the animation speed back when it's finished playing the conversation
		// Play the sitting animation
		PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
		GetPlayerInstance().image_speed = 1;
		GetPlayerInstance().image_index = 0;
	}
	
	cb10_3 = function()
	{
		var c10_3 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
		c10_3.AddSubText(new SubText("I could really use a drink", 0.2));
		RenderText(c10_3);
	}
	
	cb10_2 = function()
	{
		var c10_2 = new TextContext(sprite_mimiAvatarNormal, true, cb10_3);
		c10_2.AddSubText(new SubText("I'm thristy", 0.2));
		RenderText(c10_2);
	}

	var c10_1 = new TextContext(sprite_mimiAvatarNormal, true, cb10_2);
	c10_1.AddSubText(new SubText("Phew, I've been studying for so long", 0.2));
	RenderText(c10_1);
}

function MimiGetsDrink()
{
	// Don't give the control to the player at the beginning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the sitting animation
	PlayerPlayAnimation(anim_mimiSit, false, noone);
	GetPlayerInstance().image_speed = 0;
	GetPlayerInstance().image_index = 0;
	
	MimiConversation2();
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiRoomSits:
		MimiComplainsAboutNoise();
		break;
	case GlobalGameStates.MimiRoomSits2:
		MimiGetsDrink();
		break;
	default:
		break;
}