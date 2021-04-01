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
		
		// Fade out the chase music
		SoundGain(GetRoomMusic(), 0.0, 1000);
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
	var womenGiantWalkSoundContext1 = new SoundContext(noone, anim_womenWalkGiant, 3);
	womenGiantWalkSoundContext1.SetPersistent(true);
	womenGiantWalkSoundContext1.SetSoundPredicate(PlayFootstepSoundGiant);
	AddSoundContext(womenGiantWalkSoundContext1);

	var womenGiantWalkSoundContext6 = new SoundContext(noone, anim_womenWalkGiant, 8);
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
	womenHallwayWalkSoundContext1.SetPlayFromInstance(instance_youngsetRoomWomenOutside);
	AddSoundContext(womenHallwayWalkSoundContext1);

	var womenHallwayWalkSoundContext6 = new SoundContext(noone, anim_womenWalkHallwayProxy, 6);
	womenHallwayWalkSoundContext6.SetPersistent(true);
	womenHallwayWalkSoundContext6.SetSoundPredicate(PlayFootstepSoundHallway);
	womenHallwayWalkSoundContext6.SetPlayFromInstance(instance_youngsetRoomWomenOutside);
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