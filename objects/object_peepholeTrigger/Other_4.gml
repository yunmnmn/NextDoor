function MimiIsSpooked()
{
	finishConverstaion = function()
	{
		// Set the x and y position
		instance_womanScary.x = instance_womenWallPosition.x;
		instance_womanScary.y = instance_womenWallPosition.y;
		instance_womanScary.FreezeAnimationAtEnd2(anim_womenLook);
		
		SetGlobalGameState(GlobalGameStates.MimiPeepsAgain);
	}
	
	cb20_2 = function()
	{
		var c20_2 = new TextContext(sprite_mimiAvatarEye, false, finishConverstaion);
		c20_2.AddSubText(new SubText("...", 0.2));
		RenderText(c20_2);
	}
	
	cb21_1 = function()
	{
		var c21_2 = new TextContext(sprite_mimiAvatarCloser, false, cb20_2);
		c21_2.AddSubText(new SubText("...", 0.2));
		RenderText(c21_2);
	}
	
	animationEndCallback = function()
	{
		GetCurrentTextContext().m_progressable = true;
		PlayerFreezeAnimationEnd2(anim_mimiPeepShock);
	}
	PlayerPlayAnimation2(anim_mimiPeepShock, animationEndCallback);
	
	instance_peepholeTrigger.m_lockedToWomen = false;

	var c20_1 = new TextContext(sprite_mimiAvatarGasp, false, cb21_1);
	c20_1.AddSubText(new SubText("Ah!", 0.2));
	c20_1.m_progressable = false;
	RenderText(c20_1);
}

function MimiPeepsConversation()
{
	conversationFinished = function()
	{		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiIsPeeking);
	}
	
	cb18_4 = function()
	{
		var c18_4 = new TextContext(sprite_mimiAvatarEye, true, conversationFinished);
		c18_4.AddSubText(new SubText("...", 0.2));
		RenderText(c18_4);
	}
	
	cb18_3 = function()
	{
		var c18_3 = new TextContext(sprite_mimiAvatarTroubled, true, cb18_4);
		c18_3.AddSubText(new SubText("Maybe that guy did it", 0.2));
		RenderText(c18_3);
	}
	
	cb18_2 = function()
	{
		var c18_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb18_3);
		c18_2.AddSubText(new SubText("It looks made", 0.2));
		RenderText(c18_2);
	}

	var animationGaspEnd = function()
	{		
		// Freeze the peeping animation when it's finished
		PlayerFreezeAnimationEnd2(anim_mimiPeep);
		
		// Start of the conversation. Doesn't require a function
		var c18_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb18_2);
		c18_1.AddSubText(new SubText("How did this got here", 0.2));
		RenderText(c18_1)
	}
	
	// Play the peeping animation
	PlayerPlayAnimation(anim_mimiPeep, true, animationGaspEnd);
	
	// Disable following any instance from here one
	DisableFollowingInstance();
	// TODO: rename viewport to camera...
	// Cache this viewport position
	m_viewportLookPositionOriginX = GetViewportPositionX();
	m_viewportLookPositionOriginY = GetViewportPositionY();
}

MimiPeeps = function()
{
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	walkToPosition = function()
	{			
		GetPlayerInstance().SetPathSpeed(0.0);
		MimiPeepsConversation();
	}
	PlayerMoveAndExecute(x, GetPlayerInstance().y, 1.0, walkToPosition);
}

// The collision context for this trigger
var collisionContext = new CollisionContext(GetPlayerInstance(), MimiPeeps);
collisionContext.AddGlobalState1(GlobalGameStates.MimiApproachesHole);
AddCollisionContext(collisionContext);

// The original position of the viewport when entering the youngster room, and not interacting with the wall trigger
m_viewportLookPositionOriginX = 0.0;
m_viewportLookPositionOriginY = 0.0;

// Offset from the origin when the wall should start fading
m_viewportFadeThreshold = 600.0;

// The position of the viewport when the wall will fade automatically when Mimi looks for the second time
m_secondPeekViewportPositionX = 640;

m_pan = 0.0;
m_panSpeed = 0.0003;
m_snapbackSpeed = 0.002;
m_womenCloseToWallFadeSpeed = 0.002;

// List of dirty flags
m_lockedToWomen = false;
m_womenPeeps = false;
m_womenAttacks = false;