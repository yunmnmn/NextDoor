m_speed = 1.3;
m_speedTall = 1.6;

// Trigger when Women is crawling towards Mimi

// Don't let Mimi outside anymore
GameEndingRoom = function()
{	
	var TransitionToEndingRoom = function()
	{
		ChangeRooms(room_ending);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), TransitionToEndingRoom);
	
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