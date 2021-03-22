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
	
	transitionToEndingRoom = function()
	{
		// Delete the fader
		fader.instance_destroy();
		
		// Reset the textbox
		instance_textbox.Reset();
		
		// Change to the ending Room
		ChangeRooms(room_ending);
	}
	
	// Show this text when Mimi did get caught
	cb40_1 = function()
	{
		// Reset the textbox
		instance_textbox.Reset();
		
		var c40_1 = new TextContext(noone, false, transitionToEndingRoom);
		c40_1.AddSubText(new SubText("After that, I passed out...", 0.3, true));
		RenderText(c40_1);
	}
	fader = CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), cb40_1);
	fader.m_deleteAutomatically = false;
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set that Mimi was caught
	SetMimiCaught(true);
	
	// Freeze at the last frame when she's caught
	PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
	
	// Scream dialogue
	var c39_1 = new TextContext(sprite_mimiAvatarYell, false, noone);
	c39_1.AddSubText(new SubText("KYAAAH!", 0.6, true));
	c39_1.m_progressable = false;
	RenderText(c39_1);
}

var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
endingCollisionContext.ExecuteOnHit();
AddCollisionContext(endingCollisionContext);