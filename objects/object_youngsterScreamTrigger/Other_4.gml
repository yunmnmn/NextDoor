function YoungsterStreamsConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the state
		SetGlobalGameState(GlobalGameStates.MimiChecksOnYoungster);
		
		// Set Mimi to scared from now on
		SetMimiScared(true);
	}
	
	cb13_2 = function()
	{	
		var c13_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c13_2.AddSubText(new SubText("Sounded like it came from upstairs...", 0.3, true));
		RenderText(c13_2);
	}
	
	cb13_1 = function()
	{
		// Go to scared from now on
		var AnimationEndCallback = function()
		{
			PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
		}
		PlayerPlayAnimation2(anim_mimiIdleToScared, AnimationEndCallback);
		
		// Start of the conversation. Doesn't require a function
		var c13_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb13_2);
		c13_1.AddSubText(new SubText("What was that?!", 0.6, true));
		RenderText(c13_1);
		
		// Play the scary ambience room music
		PlayRoomMusic(music_ambientScary, "AmbientScary", true, 1.0, true);
		SoundGain(GetRoomMusic(), 0.0, 0.0);
		SoundGain(GetRoomMusic(), 1.0, 500);
	}

	PlayerPlayAnimation2(anim_mimiShock, cb13_1);
	
	// Play the Youngster scream
	PlaySound(foley_hallwayDownYoungsterScream, 10.0, false);
}

MimiHearsYoungsterScream = function()
{	
	// Make the youngster outside invisible again
	instance_outsideMemory.m_youngsterOutsideVisible = false;

	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set mimi back to idle scared
	PlayerPlayAndFreezeAtEnd(anim_mimiIdleToScared, PlayerGetMirrored());
		
	// Play the conversation with the women in black
	YoungsterStreamsConversation();
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiHearsYoungsterScream);
collisionContext.AddGlobalState1(GlobalGameStates.MimiReturnsFromDrinking);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);