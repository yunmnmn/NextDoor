// Going to the ending sequence
GameEndingRoom = function()
{		
	// Show this text when Mimi espaced
	escapedDialogue = function()
	{
		// Don't render over the textbox over it anymore	
		fader.m_overTextbox = false;
		
		// Reset the textbox
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
		
		PlayTimeline(timeline_delayedEndingConversation);
	}
	fader = CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), escapedDialogue);
	fader.m_deleteAutomatically = false;
	fader.m_overTextbox = true;
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set that Mimi wasn't caught
	SetMimiCaught(false);
	
	// Freeze at the last frame of the crawl animation when mimi hits the ending trigger
	PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
}

var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
endingCollisionContext.ExecuteOnHit();
AddCollisionContext(endingCollisionContext);