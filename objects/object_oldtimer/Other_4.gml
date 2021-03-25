function MimiAndOldtimerConversation()
{
	conversationFinished = function()
	{		
		// Set Mimi to idle
		PlayerPlayAnimation2(sprite_mimiIdle, noone);
		
		// Give control back to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiWalksBackToRoom);
	}
	
	cb8_3 = function()
	{
		var c8_3 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
		c8_3.AddSubText(new SubText("Better get back to my room to try some more studying.", 0.3, true));
		RenderText(c8_3);
	}
	
	cb8_2 = function()
	{
		var c8_2 = new TextContext(sprite_mimiAvatarNormal, true, cb8_3);
		c8_2.AddSubText(new SubText("But doesn't really help me with the noise issue.", 0.3, true));
		RenderText(c8_2);
	}
	
	cb8_1 = function()
	{
		instance_hallwayUpMemory.SetDoorOldtimerVisible(false);
		instance_hallwayUpMemory.SetOldtimerVisible(false);
		
		// Play the Hallway Door Close sound
		PlaySound(foley_hallwayDoorClose, 100, false);
		
		var c8_1 = new TextContext(sprite_mimiAvatarNormal, true, cb8_2);
		c8_1.AddSubText(new SubText("That is weird and all.", 0.3, true));
		RenderText(c8_1);
	}
	
	cb7_18 = function()
	{		
		var c8_18 = new TextContext(sprite_mimiAvatarNormal, true, cb8_1);
		c8_18.AddSubText(new SubText("Thank you, have a nice day.", 0.3, true));
		RenderText(c8_18);
	}
	
	cb7_17 = function()
	{
		var c8_17 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_18);
		c8_17.AddSubText(new SubText("Have a nice day.", 0.3, true));
		RenderText(c8_17);
	}
	
	cb7_16 = function()
	{
		var c8_16 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_17);
		c8_16.AddSubText(new SubText("If that's all dear, I still have some laundry to do.", 0.3, true));
		RenderText(c8_16);
	}

	cb7_15 = function()
	{
		var c8_15 = new TextContext(sprite_mimiAvatarNormal, true, cb7_16);
		c8_15.AddSubText(new SubText("Hmm...", 0.2, true));
		RenderText(c8_15);
	}
	
	cb7_14 = function()
	{
		var c8_14 = new TextContext(sprite_oldtimerAvatarAngry, true, cb7_15);
		c8_14.AddSubText(new SubText("Very unfriendly, if you ask me.", 0.4, true));
		RenderText(c8_14);
	}

	cb7_13 = function()
	{
		var c8_13 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_14);
		c8_13.AddSubText(new SubText("And they never say anything, not even a hello.", 0.3, true));
		RenderText(c8_13);
	}

	cb7_12 = function()
	{
		var c8_12 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_13);
		c8_12.AddSubText(new SubText("But they dress completely in black.", 0.3, true));
		RenderText(c8_12);
	}
	
	cb7_11 = function()
	{
		var c8_11 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_12);
		c8_11.AddSubText(new SubText("They all have a different figure.", 0.3, true));
		RenderText(c8_11);
	}

	cb7_10 = function()
	{
		var c8_10 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_11);
		c8_10.AddSubText(new SubText("A strange bunch...", 0.2, true));
		RenderText(c8_10);
	}
	
	cb7_9 = function()
	{
		var animationEndCallback = function()
		{
			// Freeze at the last frame of the thinking animation
			FreezeAnimationAtEnd2(anim_oldtimerThink);
		};
		PlayAnimation2(anim_oldtimerThink, animationEndCallback);
		
		var c8_9 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_10);
		c8_9.AddSubText(new SubText("I'm pretty sure more women are living there.", 0.3, true));
		RenderText(c8_9);
	}
	
	cb7_8 = function()
	{
		var c8_8 = new TextContext(sprite_mimiAvatarNormal, true, cb7_9);
		c8_8.AddSubText(new SubText("What do you mean?", 0.4, true));
		RenderText(c8_8);
	}
	
	cb7_7 = function()
	{
		var c7_7 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_8);
		c7_7.AddSubText(new SubText("And there isn't anyone else?", 0.3, true));
		RenderText(c7_7);
	}
	
	cb7_6 = function()
	{
		var c7_6 = new TextContext(sprite_mimiAvatarNormal, true, cb7_7);
		c7_6.AddSubText(new SubText("She just left...", 0.3, true));
		RenderText(c7_6);
	}
	
	cb7_5 = function()
	{
		var c7_5 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_6);
		c7_5.AddSubText(new SubText("You should ask his nextdoor?", 0.3, true));
		RenderText(c7_5);
	}
	
	cb7_4 = function()
	{
		var c7_4 = new TextContext(sprite_oldtimerAvatarNormal, true, cb7_5);
		c7_4.AddSubText(new SubText("Well, a little, but our rooms are separated.", 0.3, true));
		RenderText(c7_4);
	}
	
	cb7_3 = function()
	{
		var c7_3 = new TextContext(sprite_mimiAvatarNormal, true, cb7_4);
		c7_3.AddSubText(new SubText("Does the loud music from that apartment bother you too?", 0.3, true));
		RenderText(c7_3);
	}
	
	cb7_2 = function()
	{
		var c7_2 = new TextContext(sprite_mimiAvatarNormal, true, cb7_3);
		c7_2.AddSubText(new SubText("I'm from downstairs.", 0.3, true));
		RenderText(c7_2);
	}
	
	// Call the parent text context
	var c7_1 = new TextContext(sprite_mimiAvatarNormal, true, cb7_2);
	c7_1.AddSubText(new SubText("Excuse me, can I ask you something?", 0.3, true));
	RenderText(c7_1);
}

MimiConversationOldtimer = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	mirror = (GetPlayerInstance().x > x) ? true : false;
	walkToPosition = function()
	{			
		// Set the path speed back to 0.0
		// TODO: fix a way so that the user doesn;t mannualy need to set this
		GetPlayerInstance().SetPathSpeed(0.0);
		// Play the listen animation
		var callbackAngryEnd = function()
		{
			// Freeze at the last frame
			PlayerFreezeAnimationEnd(anim_mimiListen, GetPlayerInstance().m_mirrored);
		}
		PlayerPlayAnimation(anim_mimiListen, mirror, callbackAngryEnd);
		// Play the conversation
		MimiAndOldtimerConversation();
	}
	PlayerMoveAndExecute(mirror ? x + 100 : x - 100, GetPlayerInstance().y, 1.0, walkToPosition);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiConversationOldtimer);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
AddCollisionContext(collisionContext);