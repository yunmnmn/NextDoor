m_speed = 1.3;
m_endingSpeed = 1.0;
m_speedTall = 1.6;

// Trigger when Women is crawling towards Mimi

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
	
	// Stop the animation of the women
	image_speed = 0.5;
	
	// Stop the women from moving
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
