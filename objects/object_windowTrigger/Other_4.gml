MimiFallsBackwards = function()
{
	// Set Mimi at the right position
	// TODO: Fix hardcoding
	PlayerSnapToClosestPosition(2220, 348, false);
	
	// Show the women at the window
	instance_youngsetRoomWomenOutside.StopPath();
	instance_youngsetRoomWomenOutside.x = 2373;
	instance_youngsetRoomWomenOutside.y = 240;
	
	// Play the women stuck animation
	instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenStuck, false, noone);
	
	// Set Mimi speed slower
	GetPlayerInstance().SetSpeed(0.07); 
	
	FallingBackwardsFinished = function()
	{
		// Set to movement crawling
		SetMimiCrawling(true);
		
		// Hack: move mimi 33 pixels to the left to match the anim_mimiLeapFromStand animation
		PlayerSnapToClosestPosition(GetPlayerInstance().x - 33, GetPlayerInstance().y, true);
		
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerNoControl);
		
		// Follow Mimi again with a slight offset to the left
		SetViewportFollowSpeed(0.0003);
		var viewportEndPosition = new Vector2(GetPlayerInstance().x - 500, GetPlayerInstance().y);
		FollowPositionAndDisable(viewportEndPosition);
		
		// Automatically crawl for a bit
		var crawlToPosition = function()
		{	
			// TODO: Currently necessary for each PlayerMoveAndExecute function, make this obsolete
			GetPlayerInstance().SetPathSpeed(0.0);
			
			// Enable the player control
			SetControlState(PlayerControlState.PlayerControl);
			
			// Freeze at the last frame
			PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
			
			// Let the Women walk torwards Mimi
			instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomen, 0.0, 0.7);
		
			// Play the carwling animation
			instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenCrawl, false, noone);
			
			// Advance the Global state
			SetGlobalGameState(GlobalGameStates.MimiGetsChased);
			
			// Set the Women spider sounds
			instance_youngsetRoomWomenOutside.AddSpiderWalkingSounds();
		}
		PlayerMoveAndExecute(2050, 345, 1.0, crawlToPosition);
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
	
	var playChaseMusic = function()
	{
		PlayRoomMusic(music_chase, "ChaseEnding", false, 1.0, true);
		SoundGain(GetRoomMusic(), 0.0, 0.0);
		// Play the chase music at full volume in 0.2 seconds
		SoundGain(GetRoomMusic(), 1.0, 200);
	}
	// Play the room music when it gets close to the window
	instance_youngsetRoomWomenOutside.AddPathPointCallback(1, playChaseMusic, false);
	
	// Set the callback to play the Movie when the women reaches the end of the path
	instance_youngsetRoomWomenOutside.AddPathEndCallback(PlayWomenClimbMovie, false);
		
	// Set the idle animation
	PlayerPlayAndFreezeAtEnd(sprite_mimiIdleScared, false);
		
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
	
	// Add the Giant women footstep sounds
	instance_youngsetRoomWomenOutside.AddGiantWalkingSounds();
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), LookOutsideWindow);
collisionContext1.AddGlobalState1(GlobalGameStates.MimiHearsTickingAtWindow);
collisionContext1.m_executeOnHit = true;
AddCollisionContext(collisionContext1);

// List of dirty flags
m_lockedToWomen = false;
m_pan = 0.0;
m_panSpeed = 0.0003;