MimiFallsBackwards = function()
{
	// Set Mimi at the right position
	// TODO: Fix hardcoding
	PlayerSnapToClosestPosition(2200, 348, false);
	
	// Show the women at the window
	FreezeWomenAnimation = function()
	{
		// Set the viewport speed
		SetViewportFollowSpeed(0.003);
		// Follow Mimi again with a slight offset to the left
		var viewportEndPosition = new Vector2(GetPlayerInstance().x - 400, GetPlayerInstance().y);
		FollowPositionAndDisable(viewportEndPosition);
		
		// Let the Women walk torwards mimi
		instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomen, 0.0, 1.3);
		
		// Play the walking animation
		instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenCrawl, false, noone);
		
		// Enable player controls again
		SetControlState(PlayerControlState.PlayerControl);
	}
	instance_youngsetRoomWomenOutside.StopPath();
	instance_youngsetRoomWomenOutside.x = 2373;
	instance_youngsetRoomWomenOutside.y = 240;
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
	// TODO: Play the movie
	
	// Fall backwards afterwards
	MimiFallsBackwards();
}

LookOutsideWindow = function()
{	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set the path for the women to walk out of the screen
	instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomenOutside, 0.0, 1.3);
	// Play the walking animation
	instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenWalkGiant, false, noone);
	// Set the callback to play the Movie when the women reaches the end of the path
	instance_youngsetRoomWomenOutside.AddPathPointCallback(1, PlayWomenClimbMovie, false);
		
	// Set the idle animation
	PlayerPlayAnimation(sprite_mimiIdleScared, false, noone);
		
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