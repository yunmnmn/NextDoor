
// -------------------------- First colliding event --------------------------

function MimiConversation()
{		
	cb12ConversationFinished = function()
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerControl);
		
		// Set mimi back to idle
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Progress the global state
		SetGlobalGameState(GlobalGameStates.MimiReturnsFromDrinking);
		
		// Enable all triggers again
		SetDisableAllTriggers(false);
	}
	
	cb12_7 = function()
	{
		var c11_7 = new TextContext(sprite_mimiAvatarTroubled, true, cb12ConversationFinished);
		c11_7.AddSubText(new SubText("See you around...", 0.2, true));
		RenderText(c11_7);
	}
	
	cb12_6 = function()
	{		
		var c12_6 = new TextContext(sprite_mimiAvatarTroubled, true, cb12_7)
		c12_6.AddSubText(new SubText("I'm going back to my room.", 0.2, true));
		RenderText(c12_6);
	}
	
	cb12_5 = function()
	{
		var c12_5 = new TextContext(sprite_mimiAvatarTroubled, true, cb12_6);
		c12_5.AddSubText(new SubText("...", 0.2, true));
		RenderText(c12_5);
	}
	
	cb12_4 = function()
	{
		var c12_4 = new TextContext(sprite_youngsterAvatarTerrified, true, cb12_5);
		c12_4.AddSubText(new SubText("What are they doing that not a single sound leaks through those walls?", 0.2, true));
		RenderText(c12_4);
	}
	
	cb12_3 = function()
	{
		var c12_3 = new TextContext(sprite_youngsterAvatarTerrified, true, cb12_4);
		c12_3.AddSubText(new SubText("What things are they doing nextdoor?", 0.2, true));
		RenderText(c12_3);
	}
	
	cb12_2 = function()
	{
		var c12_2 = new TextContext(sprite_youngsterAvatarTerrified, true, cb12_3);
		c12_2.AddSubText(new SubText("Who are they?", 0.2, true));
		RenderText(c12_2);
	}
	
	cb12_1 = function()
	{
		// Set the stairs invisible again
		instance_stairs.visible = false;
		
		// Set the women invisible again
		instance_outsideMemory.SetWomenOutsideVisible(false);
		instance_womenOutside.SetPath(path_outsideWomen, 0.0, 0.0);
		instance_womenOutside.PlayAnimation2(sprite_womenIdle, noone);
		
		// Play Mimi's shock animation
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		var c12_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb12_2);
		c12_2.AddSubText(new SubText("?", 0.2, true));
		RenderText(c12_2);
		
		// Pan the camera back to Mimi
		followCallback = function()
		{
			// Play the Youngster GaspToIdle animation
			var animationEndCallback = function()
			{
				// Freeze at the last frame
				instance_youngsterOutside.FreezeAnimationAtEnd(sprite_youngsterCornerIdle);
				
				// Set the follow speed back
				SetViewportFollowSpeed(1.0);
			};
			instance_youngsterOutside.PlayAnimation2(anim_youngsterCornerGaspToIdle, animationEndCallback);
		}
		FollowInstanceAndCallback(GetPlayerInstance(), followCallback);
	}
	
	womenWalk = function()
	{
		// Set the path for the women to walk out of the screen
		instance_womenOutside.path_speed = 1.3;
		// Play the walking animation
		instance_womenOutside.PlayAnimation2(anim_womenWalkTall, noone);
		// Mirror the animation, the Women's walk is by default to the left
		instance_womenOutside.Mirror(true);
		
		// When the women is at the stairs, make her turn around
		// NOTE: 3 is the node at the stairs
		var womenAtStairs = function()
		{
			instance_womenOutside.Mirror(false);
			instance_stairs.visible = true;
		}
		instance_womenOutside.AddPathPointCallback(3, womenAtStairs, false);
		
		// When the women is at the end of the path
		instance_womenOutside.AddPathEndCallback(cb12_1, false);
	}

	cb11_20 = function()
	{
		var c11_20 = new TextContext(sprite_womanTallAvatar, true, womenWalk);
		c11_20.AddSubText(new SubText("...", 0.2, true));
		RenderText(c11_20);
	}

	cb11_19 = function()
	{
		// Play the Youngster gasp animation
		var animationEndCallback = function()
		{
			// Freeze at the last frame
			instance_youngsterOutside.FreezeAnimationAtEnd(anim_youngsterCornerGasp);
		};
		instance_youngsterOutside.PlayAnimation2(anim_youngsterCornerGasp, animationEndCallback);
		
		// Set the women behind to a visible sprite
		instance_womenOutside.PlayAnimation2(sprite_womenIdleTall, noone);
		
		// Set a point callback when Women passes Mimi, so mimi turns back to idle
		var womenPassesMimi = function()
		{
			finishTurning = function()
			{
				PlayerPlayAnimation2(sprite_mimiIdle, noone);
			}
			
			// Play the mimi turn reverse animation
			PlayerPlayAnimation2(anim_mimiTurnReverse, finishTurning);
		}
		instance_womenOutside.AddPathPointCallback(2, womenPassesMimi, false);

		// Play the mimi turn animation
		PlayerPlayAndFreezeAtEnd(anim_mimiTurn, PlayerGetMirrored());
		
		var c11_19 = new TextContext(sprite_youngsterAvatarGasp, true, cb11_20);
		c11_19.AddSubText(new SubText("AH!", 0.2, true));
		RenderText(c11_19);
		
		// Turn on the light
		instance_outsideMemory.SetLampOutsideNearDoorVisible(true);
	}
	
	cb11_18 = function()
	{
		var c11_18 = new TextContext(sprite_youngsterAvatarScared, true, cb11_19);
		c11_18.AddSubText(new SubText("It's freaking me out...", 0.2, true));
		if(!m_womenWaiting)
		{
			c11_18.m_progressable = false;
		}
		
		RenderText(c11_18);
	}
	
	cb11_17 = function()
	{
		// Set the women on the path
		instance_womenOutside.PlayAnimation2(anim_womenWalkTallShadow, noone);
		instance_womenOutside.Mirror(true);
		instance_womenOutside.SetPath(path_outsideWomen, 0.0, 1.3);
		// Set the women in black visible
		instance_outsideMemory.SetWomenOutsideVisible(true);
		
		var BehimdMimi = function()
		{
			// Set women to tall idle shadow
			instance_womenOutside.FreezeAnimationAtEnd2(sprite_womenIdleTallShadow);
			
			// Stop the women from walking
			instance_womenOutside.path_speed = 0.0;
			
			m_womenWaiting = true;
			
			// If the player is already waiting, make it progressable again
			if(GetCurrentTextContext().m_progressable == false)
			{
				GetCurrentTextContext().m_progressable = true;
			}
		}
		instance_womenOutside.AddPathPointCallback(1, BehimdMimi, false);
		
		var c11_17 = new TextContext(sprite_youngsterAvatarScared, true, cb11_18);
		c11_17.AddSubText(new SubText("I should at least be able to hear them talk or move around or something.", 0.2, true));
		RenderText(c11_17);
	}
	
	cb11_16 = function()
	{		
		var c11_16 = new TextContext(sprite_youngsterAvatarScared, true, cb11_17);
		c11_16.AddSubText(new SubText("And with these thin walls...", 0.2, true));
		RenderText(c11_16);
	}
	
	cb11_15 = function()
	{
		var c11_15 = new TextContext(sprite_youngsterAvatarScared, true, cb11_16);
		c11_15.AddSubText(new SubText("They never make a single sound!", 0.2, true));
		RenderText(c11_15);
	}
	
	cb11_14 = function()
	{				
		var c11_14 = new TextContext(sprite_youngsterAvatarScared, true, cb11_15);
		c11_14.AddSubText(new SubText("I don't know how many people live there, but...", 0.2, true));
		RenderText(c11_14);
		
		// Turn off the light at the door
		instance_outsideMemory.SetLampOutsideNearDoorVisible(false);
		instance_outsideNightBackground.StopFlickering();
	}
	
	cb11_13 = function()
	{
		var c11_13 = new TextContext(sprite_youngsterAvatarScared, true, cb11_14);
		c11_13.AddSubText(new SubText("It's weird.", 0.2, true));
		RenderText(c11_13);
	}
	
	cb11_12 = function()
	{
		var c11_12 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_13);
		c11_12.AddSubText(new SubText("What do you mean?", 0.2, true));
		RenderText(c11_12);
	}
	
	cb11_11 = function()
	{
		var c11_11 = new TextContext(sprite_youngsterAvatarScared, true, cb11_12);
		c11_11.AddSubText(new SubText("What's up with them?", 0.2, true));
		RenderText(c11_11);
	}
	
	cb11_10 = function()
	{
		var c11_10 = new TextContext(sprite_youngsterAvatarScared, true, cb11_11);
		c11_10.AddSubText(new SubText("Those ladies nextdoor to me.", 0.2, true));
		RenderText(c11_10);
	}
	
	cb11_9 = function()
	{
		var c11_9 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_10);
		c11_9.AddSubText(new SubText("Sure...", 0.2, true));
		RenderText(c11_9);
	}
	
	cb11_8 = function()
	{
		var c11_8 = new TextContext(sprite_youngsterAvatarScared, true, cb11_9);
		c11_8.AddSubText(new SubText("Can I ask you something?", 0.2, true));
		RenderText(c11_8);
	}
	
	cb11_7 = function()
	{
		var c11_7 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_8);
		c11_7.AddSubText(new SubText("You're white as a sheet!", 0.2, true));
		RenderText(c11_7);
	}
	
	cb11_6 = function()
	{
		// Play the listen animation
		var callbackAngryEnd = function()
		{
			// Freeze at the last frame
			PlayerFreezeAnimationEnd2(anim_mimiListen);
		}
		PlayerPlayAnimation2(anim_mimiListen, callbackAngryEnd);
		
		var c11_6 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_7);
		c11_6.AddSubText(new SubText("What's gotten into you?", 0.2, true));
		RenderText(c11_6);
	}
	
	cb11_5 = function()
	{
		var c11_5 = new TextContext(sprite_youngsterAvatarScared, true, cb11_6);
		c11_5.AddSubText(new SubText("Don't sneak up on me like that.", 0.2, true));
		RenderText(c11_5);
	}
	
	cb11_4 = function()
	{
		var c11_4 = new TextContext(sprite_youngsterAvatarScared, true, cb11_5);
		c11_4.AddSubText(new SubText("Oh it's you...", 0.2, true));
		RenderText(c11_4);
	}
	
	cb11_3 = function()
	{
		var c11_3 = new TextContext(sprite_youngsterAvatarScared, true, cb11_4);
		c11_3.AddSubText(new SubText("?!", 0.2, true));
		RenderText(c11_3);
	}
	
	cb11_2 = function()
	{
		var c11_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb11_3);
		c11_2.AddSubText(new SubText("Hey! What are you doing there?", 0.2, true));
		RenderText(c11_2);
	}
	
	var c11_1 = new TextContext(sprite_mimiAvatarTroubled, false, cb11_2);
	c11_1.AddSubText(new SubText("It's that guy from upstairs.", 0.2, true));
	
	// Call the parent text context
	if(RenderText(c11_1))
	{
		// Disable progressing this TextContext untill Mimi's shock animation is finished
		GetCurrentTextContext().m_progressable = false;
		
		// Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
		
		var SetIdleWhenShockFinish = function()
		{
			// Enable progressing this TextContext 
			GetCurrentTextContext().m_progressable = true;
			
			// Set Mimi back to idle
			PlayerPlayAnimation2(sprite_mimiIdle, noone);
		}
		
		// Play the shock animation
		PlayerPlayAnimation(anim_mimiShock, false, SetIdleWhenShockFinish);
		
		// Pan the camera to the youngster
		SetViewportFollowSpeed(0.0015);
		FollowPosition(new Vector2(instance_youngsterOutside.x, GetPlayerInstance().y));
	}
}

MimiBuysDrink = function()
{		
	// Disable all triggers
	SetDisableAllTriggers(true);
				
	// Play the coin animation
	var animationEnd = function()
	{
		// Set Mimi's animation to idle
		PlayerPlayAnimation(sprite_mimiIdle, false, noone);
		
		// Play the flickering light Timeline
		PlayTimeline(timeline_flickeringLight);
		
		// Set the youngster to use the shadowmap
		instance_youngsterOutside.m_useShadowMap = true;
		// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
		PlayerSnapToClosestPosition(x - 4, GetPlayerInstance().y, true);
	}
	PlayerPlayAnimation(anim_mimiCoin, false, animationEnd);
}

MimiMovesToBuyDrink = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);

	// Walk to the position to knock
	var walkToPosition = function()
	{
		GetPlayerInstance().SetPathSpeed(0.0);
			
		MimiBuysDrink();
	}
	PlayerMoveAndExecute(x, GetPlayerInstance().y, 1.0, walkToPosition);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiMovesToBuyDrink);
collisionContext.AddGlobalState1(GlobalGameStates.MimiGetsDrink);
AddCollisionContext(collisionContext);

m_womenWaiting = false;

// -------------------------- Second colliding event --------------------------

MimiMonologue = function()
{	
	conversationFinished = function()
	{
		// Disable the player control
		SetControlState(PlayerControlState.PlayerControl);
		
		var collisionContext = new CollisionContext(GetPlayerInstance(), MimiMonologue);
		collisionContext.AllStates();
		AddCollisionContext(collisionContext);
	}
	
	var c37_1 = new TextContext(sprite_mimiAvatarNormal, true, conversationFinished);
	c37_1.AddSubText(new SubText("I'm not really thirsty.", 0.2, true));
	RenderText(c37_1)
		
	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to Idle
	PlayerFreezeAnimationEnd2(sprite_mimiIdle);
}

if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), MimiMonologue);
	collisionContext.AllStates();
	AddCollisionContext(collisionContext);
}