function MimiConversation()
{		
	conversationFinished = function()
	{
		// Execute this when it's completely dark
		var fadeOutEndCallback = function()
		{
			// Advance the global state
			SetGlobalGameState(GlobalGameStates.MimiRoomSits2);
		
			// Reload the room effectively
			ChangeRoomAndSetPath("room_mimiRoom", path_mimiRoom, 0.0, false);
		}
		CreateFader(FadeState.FadeOut, 0.01, fadeOutEndCallback);
	}
	
	cb9_4 = function()
	{
		var c9_4 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
		c9_4.AddSubText(new SubText("Oh well, I can finally do some studying", 0.2, true));
		RenderText(c9_4);
	}
	
	cb9_3 = function()
	{
		var c9_3 = new TextContext(sprite_mimiAvatarNormal, true, cb9_4);
		c9_3.AddSubText(new SubText("After all that trouble he gave me", 0.2, true));
		RenderText(c9_3);
	}
	
	cb9_2 = function()
	{
		var c9_2 = new TextContext(sprite_mimiAvatarNormal, true, cb9_3);
		c9_2.AddSubText(new SubText("What happened?", 0.2, true));
		RenderText(c9_2);
	}

	// Start of the conversation. Doesn't require a function
	var c9_1 = new TextContext(sprite_mimiAvatarNormal, true, cb9_2);
	c9_1.AddSubText(new SubText("Hey the music stopped!", 0.2, true));

	// Call the parent text context
	if(RenderText(c9_1))
	{
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Play the idle animation
		PlayerPlayAnimation(sprite_mimiIdle, true, noone);
	}
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiConversation);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksBackToRoom);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);