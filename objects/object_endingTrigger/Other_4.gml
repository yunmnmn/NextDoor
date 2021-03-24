// Going to the ending sequence
GameEndingRoom = function()
{		
	transitionToEndingRoom = function()
	{
		// Delete the fader
		fader.instance_destroy();
		
		// Reset the textbox
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
		
		// Transition to the ending room
		ChangeRooms(room_ending);
	}
	
	// Show this text when Mimi espaced
	escapedDialogue = function()
	{
		// Don't render over the textbox anymore	
		fader.m_overTextbox = false;
		
		var c38_1 = new TextContext(noone, false, transitionToEndingRoom);
		c38_1.AddSubText(new SubText("I escaped just in time...", 0.3, true));
		RenderText(c38_1);
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