MimiFallsBackwards = function()
{
	// Set Mimi at the right position
	// TODO: Fix hardcoding
	PlayerSnapToClosestPosition(2200, 348, false);
	
	// Show the women at the window
	FreezeWomenAnimation = function()
	{
		// Set the viewport speed
		SetViewportFollowSpeed(0.003)
		
		// Follow Mimi again with a slight offset to the left
		var viewportEndPosition = new Vector2(GetPlayerInstance().x - 400, GetPlayerInstance().y);
		FollowPositionAndDisable(viewportEndPosition);
		
		// Enable player controls again
		SetControlState(PlayerControlState.PlayerControl);
		
		// Set player speed slower
		GetPlayerInstance().SetSpeed(0.07); 
		
		FreezeWomenAnimation2 = function()
		{
			// Let the Women walk torwards Mimi
			instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomen, 0.0, 0.7);
		
			// Play the walking animation
			instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenCrawl, false, noone);
			
			// Advance the Global state
			SetGlobalGameState(GlobalGameStates.MimiGetsChased);
		}
		// Play the women stuck animation one more time when the camera is panning
		instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenStuck, false, FreezeWomenAnimation2);
		
	}
	// Show the women at the window
	instance_youngsetRoomWomenOutside.StopPath();
	instance_youngsetRoomWomenOutside.x = 2373;
	instance_youngsetRoomWomenOutside.y = 240;
	
	// Play the women stu ck animation
	instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenStuck, false, FreezeWomenAnimation);
	
	// Set camera back to m_viewportLookPositionOriginX
	SetViewportPositionX(m_viewportLookPositionOriginX);
	
	FallingBackwardsFinished = function()
	{
		// Set to movement crawling
		SetMimiCrawling(true);
		
		// Freeze at the last frame
		PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
	}
	PlayerPlayAnimation(anim_mimiLeapFromStand, false, FallingBackwardsFinished);
}

PlayWomenClimbMovie = function()
{
	// Freeze the animation at the end
	instance_youngsetRoomWomenOutside.image_speed = 0.0;
	
	// Play the timeline a little bit later, so it's waiting there
	PlayTimeline(timeline_womenIsAtWindow);
}

LookOutsideWindow = function()
{	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set the path for the women to walk to the window
	instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomenOutside, 0.0, 1.0);
	// Play the walking animation
	instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenWalkGiant, false, noone);
	// Set the callback to play the Movie when the women reaches the end of the path
	instance_youngsetRoomWomenOutside.AddPathPointCallback(1, PlayWomenClimbMovie, false);
		
	// Set the idle animation
	PlayerPlayAndFreezeAtEnd(anim_mimiIdleToScared, false);
		
	m_viewportLookPositionOriginX = GetViewportPositionX();
	m_viewportLookPositionOriginY = GetViewportPositionY();
	
	// Disable the viewport restriction
	UnrestrictViewportX();
	// Disable following any instance
	DisableFollowingInstance();
	// Set to follow a position
	var viewportEndPosition = new Vector2(room_width - (GetViewportWidth() * 0.5), GetPlayerInstance().y);
	FollowPositionAndDisable(viewportEndPosition);
	SetViewportFollowSpeed(0.0003);
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), LookOutsideWindow);
collisionContext1.AddGlobalState1(GlobalGameStates.MimiHearsTickingAtWindow);
collisionContext1.m_executeOnHit = true;
AddCollisionContext(collisionContext1);

// List of dirty flags
m_lockedToWomen = false;
m_pan = 0.0;
m_panSpeed = 0.0003;