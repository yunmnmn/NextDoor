m_speed = 1.3;
m_endingSpeed = 1.0;

m_cachedFootstepSoundIndex = 0;
m_cachedFootstepSoundIndex2 = 0;

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

// -------------------------- Sounds --------------------------

// Set the SoundContexts for Normal Women walking
{
	var womenNormalWalkSoundContext1 = new SoundContext(noone, anim_womenWalk, 1);
	womenNormalWalkSoundContext1.SetPersistent(true);
	womenNormalWalkSoundContext1.SetSoundPredicate(PlayFootstepSound);
	//womenNormalWalkSoundContext1.SetPlayPredicate(mimiWalkingPredicate);
	AddSoundContext(womenNormalWalkSoundContext1);

	var womenNormalWalkSoundContext6 = new SoundContext(noone, anim_womenWalk, 6);
	womenNormalWalkSoundContext6.SetPersistent(true);
	womenNormalWalkSoundContext6.SetSoundPredicate(PlayFootstepSound);
	//womenNormalWalkSoundContext5.SetPlayPredicate(mimiWalkingPredicate);
	AddSoundContext(womenNormalWalkSoundContext6);
}

// Set the SoundContexts for Tall Women walking
{
	var womenNormalWalkSoundContext1 = new SoundContext(noone, anim_womenWalkTall, 1);
	womenNormalWalkSoundContext1.SetPersistent(true);
	womenNormalWalkSoundContext1.SetSoundPredicate(PlayFootstepSound);
	//womenNormalWalkSoundContext1.SetPlayPredicate(mimiWalkingPredicate);
	AddSoundContext(womenNormalWalkSoundContext1);

	var womenNormalWalkSoundContext6 = new SoundContext(noone, anim_womenWalkTall, 6);
	womenNormalWalkSoundContext6.SetPersistent(true);
	womenNormalWalkSoundContext6.SetSoundPredicate(PlayFootstepSound);
	//womenNormalWalkSoundContext5.SetPlayPredicate(mimiWalkingPredicate);
	AddSoundContext(womenNormalWalkSoundContext6);
}

// Set the SoundContexts for Spider Women walking
{
	var womenSpiderWalkSoundContext1 = new SoundContext(noone, anim_womenCrawl, 1);
	womenSpiderWalkSoundContext1.SetPersistent(true);
	womenSpiderWalkSoundContext1.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext1);

	var womenSpiderWalkSoundContext3 = new SoundContext(noone, anim_womenCrawl, 3);
	womenSpiderWalkSoundContext3.SetPersistent(true);
	womenSpiderWalkSoundContext3.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext3);
	
	var womenSpiderWalkSoundContext5 = new SoundContext(noone, anim_womenCrawl, 5);
	womenSpiderWalkSoundContext5.SetPersistent(true);
	womenSpiderWalkSoundContext5.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext5);
	
	var womenSpiderWalkSoundContext7 = new SoundContext(noone, anim_womenCrawl, 7);
	womenSpiderWalkSoundContext7.SetPersistent(true);
	womenSpiderWalkSoundContext7.SetSoundPredicate(PlayFootstepSoundSpider);
	AddSoundContext(womenSpiderWalkSoundContext7);
}