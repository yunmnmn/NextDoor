m_speed = 1.3;
m_endingSpeed = 1.0;

m_cachedFootstepSoundIndex = 0;
m_cachedFootstepSoundIndex2 = 0;
m_cachedFootstepSoundIndex3 = 0;
m_cachedFootstepSoundIndex4 = 0;

// Don't let Mimi outside anymore
GameEndingRoom = function()
{	
	if(!GetMimiCaught())
	{
		return;
	}
		
	// Show this text when Mimi did get caught
	cb40_1 = function()
	{
		// Don't render the fader over the textbox anymore
		fader.m_overTextbox = false;
		
		// Reset the textbox
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
		
		PlayTimeline(timeline_delayedEndingConversation);
		
		// Set everything to 0.0
		image_speed = 0.0;
		path_speed = 0.0;
	}
	fader = CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), cb40_1);
	fader.m_deleteAutomatically = false;
	fader.m_overTextbox = true;
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set that Mimi was caught
	SetMimiCaught(true);
	
	// Freeze at the last frame when she's caught
	PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
	
	// Slow down the image speed of the women
	image_speed = 0.5;
	
	// Slow down the movement of the women
	path_speed = 0.3;
	
	// Scream dialogue
	var c39_1 = new TextContext(sprite_mimiAvatarYell, false, noone);
	c39_1.AddSubText(new SubText("KYAAAH!", 0.6, true));
	c39_1.m_progressable = false;
	RenderText(c39_1);
}

// TODO: move this to another object
if(room == room_youngsterRoom)
{
	var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
	endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
	endingCollisionContext.ExecuteOnHit();
	AddCollisionContext(endingCollisionContext);
}

PlayFootstepSound = function()
{
	// Appartment footstep sounds
	appartmentWalkSounds[0] = foley_appartmentWalkingStep1;
	appartmentWalkSounds[1] = foley_appartmentWalkingStep2;
	appartmentWalkSounds[2] = foley_appartmentWalkingStep3;
	appartmentWalkSounds[3] = foley_appartmentWalkingStep4;
	appartmentWalkSounds[4] = foley_appartmentWalkingStep5;
	
	// Hallway footstep sounds
	hallwayWalkSounds[0] = foley_hallwayWalkingStep1;
	hallwayWalkSounds[1] = foley_hallwayWalkingStep2;
	hallwayWalkSounds[2] = foley_hallwayWalkingStep3;
	hallwayWalkSounds[3] = foley_hallwayWalkingStep4;
	hallwayWalkSounds[4] = foley_hallwayWalkingStep5;
	
	// Outside footstep sounds
	outsideWalkSounds[0] = foley_outsideWalkingStep1;
	outsideWalkSounds[1] = foley_outsideWalkingStep2;
	outsideWalkSounds[2] = foley_outsideWalkingStep3;
	outsideWalkSounds[3] = foley_outsideWalkingStep4;
	outsideWalkSounds[4] = foley_outsideWalkingStep5;

	var array = noone;
	
	// Play Appartment footsteps
	if(GetRoomType() == RoomType.Appartment)
	{
		array = appartmentWalkSounds;
	}
	else if(GetRoomType() == RoomType.Hallway)
	{
		array = hallwayWalkSounds;
	}
	else // It's outside
	{
		array = outsideWalkSounds;
	}
	
	var arrayLength = array_length(array);
	var arrayIndex = random(arrayLength);
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = array[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundSpider = function()
{
	// Appartment footstep sounds
	spiderWalkSounds[0] = foley_womenSpiderWalk1;
	spiderWalkSounds[1] = foley_womenSpiderWalk2;
	spiderWalkSounds[2] = foley_womenSpiderWalk3;
	spiderWalkSounds[3] = foley_womenSpiderWalk4;
	spiderWalkSounds[4] = foley_womenSpiderWalk5;
	
	var arrayLength = array_length(spiderWalkSounds);
	var arrayIndex = random(arrayLength);
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex2)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex2 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = spiderWalkSounds[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundGiant = function()
{
	// Appartment footstep sounds
	giantWalkSounds[0] = foley_womenGiantWalk1;
	giantWalkSounds[1] = foley_womenGiantWalk2;
	giantWalkSounds[2] = foley_womenGiantWalk3;
	giantWalkSounds[3] = foley_womenGiantWalk4;
	giantWalkSounds[4] = foley_womenGiantWalk5;
	
	var arrayLength = array_length(giantWalkSounds);
	var arrayIndex = random(arrayLength);
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex3)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex3 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = giantWalkSounds[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundHallway = function()
{
	// Appartment footstep sounds
	hallwayWalkSounds[0] = foley_womenHallwayWalk1;
	hallwayWalkSounds[1] = foley_womenHallwayWalk2;
	hallwayWalkSounds[2] = foley_womenHallwayWalk3;
	hallwayWalkSounds[3] = foley_womenHallwayWalk4;
	hallwayWalkSounds[4] = foley_womenHallwayWalk5;
	
	var arrayLength = array_length(hallwayWalkSounds);
	var arrayIndex = random(arrayLength);
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex4)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex4 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = hallwayWalkSounds[arrayIndex];
	return footstepSoundIndex;
}	

// -------------------------- Sounds --------------------------

// Set the SoundContexts for Normal Women walking
function AddNormalWalkingSounds()
{
	var womenNormalWalkSoundContext1 = new SoundContext(noone, anim_womenWalk, 1);
	womenNormalWalkSoundContext1.SetPersistent(true);
	womenNormalWalkSoundContext1.SetSoundPredicate(PlayFootstepSound);
	AddSoundContext(womenNormalWalkSoundContext1);

	var womenNormalWalkSoundContext6 = new SoundContext(noone, anim_womenWalk, 6);
	womenNormalWalkSoundContext6.SetPersistent(true);
	womenNormalWalkSoundContext6.SetSoundPredicate(PlayFootstepSound);
	AddSoundContext(womenNormalWalkSoundContext6);
}

// Set the SoundContexts for Tall Women walking
function AddTallWalkingSounds()
{
	var womenTallWalkSoundContext1 = new SoundContext(noone, anim_womenWalkTall, 1);
	womenTallWalkSoundContext1.SetPersistent(true);
	womenTallWalkSoundContext1.SetSoundPredicate(PlayFootstepSound);
	AddSoundContext(womenTallWalkSoundContext1);

	var womenTallWalkSoundContext6 = new SoundContext(noone, anim_womenWalkTall, 6);
	womenTallWalkSoundContext6.SetPersistent(true);
	womenTallWalkSoundContext6.SetSoundPredicate(PlayFootstepSound);
	AddSoundContext(womenTallWalkSoundContext6);
}

// Set the SoundContexts for Tall Women walking
function AddGiantWalkingSounds()
{
	var womenGiantWalkSoundContext1 = new SoundContext(noone, anim_womenWalkGiant, 1);
	womenGiantWalkSoundContext1.SetPersistent(true);
	womenGiantWalkSoundContext1.SetSoundPredicate(PlayFootstepSoundGiant);
	AddSoundContext(womenGiantWalkSoundContext1);

	var womenGiantWalkSoundContext6 = new SoundContext(noone, anim_womenWalkGiant, 6);
	womenGiantWalkSoundContext6.SetPersistent(true);
	womenGiantWalkSoundContext6.SetSoundPredicate(PlayFootstepSoundGiant);
	AddSoundContext(womenGiantWalkSoundContext6);
}

// Set the SoundContexts for Hallway Women walking
function AddHallwayWalkingSounds()
{
	var womenHallwayWalkSoundContext1 = new SoundContext(noone, anim_womenWalkHallwayProxy, 1);
	womenHallwayWalkSoundContext1.SetPersistent(true);
	womenHallwayWalkSoundContext1.SetSoundPredicate(PlayFootstepSoundHallway);
	womenHallwayWalkSoundContext1.SetPlayFromInstance(true);
	AddSoundContext(womenHallwayWalkSoundContext1);

	var womenHallwayWalkSoundContext6 = new SoundContext(noone, anim_womenWalkHallwayProxy, 6);
	womenHallwayWalkSoundContext6.SetPersistent(true);
	womenHallwayWalkSoundContext6.SetSoundPredicate(PlayFootstepSoundHallway);
	womenHallwayWalkSoundContext6.SetPlayFromInstance(true);
	AddSoundContext(womenHallwayWalkSoundContext6);
}

// Set the SoundContexts for Spider Women walking
function AddSpiderWalkingSounds()
{
	var womenSpiderWalkSoundContext1 = new SoundContext(noone, anim_womenCrawl, 1);
	womenSpiderWalkSoundContext1.SetPersistent(true);
	womenSpiderWalkSoundContext1.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext1);

	var womenSpiderWalkSoundContext5 = new SoundContext(noone, anim_womenCrawl, 5);
	womenSpiderWalkSoundContext5.SetPersistent(true);
	womenSpiderWalkSoundContext5.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext5);
}