m_viewportLookPositionOriginX = 0.0;
m_viewportLookPositionOriginY = 0.0;

m_pan = 0.0;
m_panSpeed = 0.0003;
m_snapbackSpeed = 0.002;

m_lockedToWomen = false;

function MimiIsSpooked()
{
	//PlayerPlayAnimation2(anim_mimiPeep, animationEndCallback);
	//instance_peepholeTrigger.m_lockedToWomen = false;
	//PlayerPlayAnimation2(anim_mimiPeepShock, animationEndCallback);
}

function MimiPeepsConversation()
{
	conversationFinished = function()
	{		
		// Advance the global game state
		SetGlobalGameState(GlobalGameStates.MimiIsPeeking);
	}
	
	cb18_3 = function()
	{
		var c18_3 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c18_3.AddSubText(new SubText("Maybe that guy did it", 0.2));
		RenderText(c18_3);
	}
	
	cb18_2 = function()
	{
		var c18_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb18_3);
		c18_2.AddSubText(new SubText("It looks made", 0.2));
		RenderText(c18_2);
	}

	// Disable progressing this TextContext untill Mimi's knocking animation has finished playing
	// When the knocking animation is finished, execute this callback
	var animationEndCallback = function()
	{		
		// Freeze the peeping animation when it's finished
		PlayerFreezeAnimationEnd2(anim_mimiPeep);
		
		// Start of the conversation. Doesn't require a function
		var c18_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb18_2);
		c18_1.AddSubText(new SubText("How did this got here", 0.2));
		RenderText(c18_1)
	}
	// Play the knocking animation
	PlayerPlayAnimation2(anim_mimiPeep, animationEndCallback);
	
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
	PlayerMoveAndExecute(x + 5, GetPlayerInstance().y, 1.0, walkToPosition);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), MimiPeeps);
collisionContext.AddGlobalState1(GlobalGameStates.MimiApproachesHole);
AddCollisionContext(collisionContext);