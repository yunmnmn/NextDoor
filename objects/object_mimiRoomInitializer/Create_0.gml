m_cachedAnimationSpeed = 0;

function MimiConversation()
{
	conversationFinished = function()
	{
		// Set the animation speed back when it's finished playing the conversation
		GetPlayerInstance().image_speed = m_cachedAnimationSpeed;
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, conversationFinished);
		c2_3.AddSubText(new SubText("I can't study with this noise all the time! ", 0.2));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, cb2_3);
		c2_2.AddSubText(new SubText("Oh, come on!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarNormal, cb2_2);
	c2_1.AddSubText(new SubText("...", 0.6));

	// Call the parent text context
	RenderText(c2_1);
}

// At the very first state, play an animation first, and set the player at the start of the path
if(GetGlobalGameState() == GlobalGameStates.MimiRoomSits)
{
	// HACK: one time thing
	global.m_path = path_mimiRoom;
	
	// Don't give the control to the player at the beginning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Set Mimi on the path
	PlayerSetPath(path_mimiRoom, 0.0);
	
	// Set the sitting animation
	var animationEndCallback = function()
	{
		// Play the idle animation
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Give the control back to the player
		SetControlState(PlayerControlState.PlayerControl);
		
		// Set the next global state after the animation is finished playing
		SetGlobalGameState(GlobalGameStates.MimiGoingToYoungster);
	}
	
	PlayerPlayAnimation(anim_mimiSit, false, animationEndCallback);
	// Set the animation speed to 0
	m_cachedAnimationSpeed = GetPlayerInstance().image_speed;
	GetPlayerInstance().image_speed = 0;
	
	// Set the conversation
	MimiConversation();
}