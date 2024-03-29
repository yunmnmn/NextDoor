function RoomLerp(p_from, p_to)
{
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(p_from, p_to, m_pan);
	interpolatedX = clamp(interpolatedX, min(p_from, p_to), max(p_from, p_to));
	SetViewportPositionX(interpolatedX);
}

function NormalizedViewportPositionToZero(p_threshold)
{
	var norm = 1.0 - (GetViewportPositionX() / p_threshold);
	norm = clamp(norm, 0.0, 1.0);
	return norm;
}

if(GetGlobalGameState() == GlobalGameStates.MimiIsPeeking)
{
	if(!m_lockedToWomen)
	{
		if(ActionKeyHold())
		{
			m_pan += m_panSpeed * GetAverageDeltaTimeInMiliseconds();
		}
		else
		{
			m_pan -= m_snapbackSpeed * GetAverageDeltaTimeInMiliseconds();
		}
	}
	
	// Disable the holdprompt. The user gets the idea
	if(m_pan > 0.5)
	{
		instance_global.DrawActionHoldPrompt(false, true, 0, 0);
	}
	
	RoomLerp(m_viewportLookPositionOriginX, 0);
	
	if(GetViewportPositionX() < 4)
	{
		SetViewportPositionX(0.0);
		m_lockedToWomen = true;
		SetGlobalGameState(GlobalGameStates.MimiLocksPeeking);
		instance_womanScary.NoticesMimi();
	}
	
	var norm = NormalizedViewportPositionToZero(m_viewportLookPositionOriginX - m_viewportFadeThreshold);
	instance_wallWithHole.m_scalar = norm;
}
else if(GetGlobalGameState() == GlobalGameStates.MimiIsShocked)
{
	m_pan -= m_snapbackSpeed * GetAverageDeltaTimeInMiliseconds() * 2.0;
	
	RoomLerp(m_viewportLookPositionOriginX, 0);
	
	var norm = NormalizedViewportPositionToZero(m_viewportLookPositionOriginX - m_viewportFadeThreshold);
	instance_wallWithHole.m_scalar = norm;
}
else if(GetGlobalGameState() == GlobalGameStates.MimiPeepsAgain)
{
	if(!m_lockedToWomen)
	{
		if(ActionKeyHold())
		{
			m_pan += m_panSpeedSecond * GetAverageDeltaTimeInMiliseconds();
		}
		else
		{
			m_pan -= m_snapbackSpeed * GetAverageDeltaTimeInMiliseconds();
		}
	}
	
	if(m_pan > 0.3)
	{
		instance_global.DrawActionHoldPrompt(false, true, 0, 0);
	}
	
	RoomLerp(m_viewportLookPositionOriginX, m_secondPeekViewportPositionX);
	
	var currentViewportPosition = GetViewportPositionX();
	if(abs(m_secondPeekViewportPositionX - currentViewportPosition) < 6)
	{
		SetViewportPositionX(m_secondPeekViewportPositionX);
		m_lockedToWomen = true;
		SetGlobalGameState(GlobalGameStates.WomenLooksAtMimi);
	}
}
else if(GetGlobalGameState() == GlobalGameStates.WomenLooksAtMimi)
{
	var scalar = instance_wallWithHole.m_scalar;
	scalar += m_womenCloseToWallFadeSpeed * GetAverageDeltaTimeInMiliseconds();
	scalar = max(min(scalar, 1.0), 0.0);
	
	instance_wallWithHole.m_scalar = scalar;
	if(scalar == 1.0 && !m_womenPeeps)
	{
		m_womenPeeps = true;
		
		animationWomenLookFinished = function()
		{
			instance_womanScary.FreezeAnimationAtEnd2(anim_womenLook);
			m_lockedToWomen = false;
			SetGlobalGameState(GlobalGameStates.MimiFallsBackwards);
		}
		instance_womanScary.PlayAnimation2(anim_womenLook, animationWomenLookFinished);
		
		// Rumble the controller when Women turns
		Rumble(0.4, 200);
		
		// Play the Chase music
		PlayRoomMusic(GetChase(), "Chase", true, 1.0, true);
		// Fade it in in 0.2 seconds
		SoundGain(GetRoomMusic(), 0.0, 0.0);
		SoundGain(GetRoomMusic(), 1.0, 200);
	}
}
else if(GetGlobalGameState() == GlobalGameStates.MimiFallsBackwards)
{	
	m_pan += m_snapbackSpeed * GetAverageDeltaTimeInMiliseconds() * 2.0;
	RoomLerp(m_secondPeekViewportPositionX, m_viewportLookPositionOriginX);
	
	var norm = NormalizedViewportPositionToZero(m_viewportLookPositionOriginX - m_viewportFadeThreshold);
	instance_wallWithHole.m_scalar = norm;
	
	if(!m_womenAttacks && norm == 0.0)
	{
		m_womenAttacks = true;
		
		// Set the slats visible
		instance_womenSlats.visible = true;
		
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
		
		// Play stats animation
		PlaySlatsAnimation = function()
		{
			animationSlatsFinished = function()
			{
				mimiIsUp = function()
				{	
					// Advance the global state 
					SetGlobalGameState(GlobalGameStates.MimiStandsUpFromAttack);
					// Follow the player again
					SetViewportFollowInstance(GetPlayerInstance());
					// Give control back to the player
					SetControlState(PlayerControlState.PlayerControl);
				
					// Play the women timeline
					PlayTimeline(timeline_womenMoves);
				}
				
				idleToIdleScared = function()
				{
					PlayerPlayAnimation2(anim_mimiIdleToScared, mimiIsUp);
				}
			
				mimiStandsUp = function()
				{
					// Hack: move mimi 64 pixels to the left to match the CrawlToIdle animation
					PlayerSnapToClosestPosition(GetPlayerInstance().x + 64, GetPlayerInstance().y, true);
					PlayerPlayAnimation2(anim_mimiCrawlToIdle, idleToIdleScared);
					
					// Stop the chase music
					StopRoomMusic();
				}
			
				cb23_6 = function()
				{
					var c23_6 = new TextContext(sprite_mimiAvatarScared, true, mimiStandsUp);
					c23_6.AddSubText(new SubText("Were exactly the same woman?", 0.4, true));
					RenderText(c23_6);
				}
			
				cb23_5 = function()
				{
					var cb23_5 = new TextContext(sprite_mimiAvatarScared, true, cb23_6);
					cb23_5.AddSubText(new SubText("All of those women with different figures.", 0.3, true));
					RenderText(cb23_5);
				}
			
				cb23_4 = function()
				{
					var c23_4 = new TextContext(sprite_mimiAvatarScared, true, cb23_5);
					c23_4.AddSubText(new SubText("Does this mean...", 0.4, true));
					RenderText(c23_4);
				}
			
				cb23_3 = function()
				{
					var c23_3 = new TextContext(sprite_mimiAvatarScared, true, cb23_4);
					c23_3.AddSubText(new SubText("Why do they extend and contract?", 0.3, true));
					RenderText(c23_3);
				}
			
				cb23_2 = function()
				{
					var c23_2 = new TextContext(sprite_mimiAvatarScared, true, cb23_3);
					c23_2.AddSubText(new SubText("Those limbs...", 0.3, true));
					RenderText(c23_2);
				}
			
				// Start of the conversation.
				if(GetTextboxInstance() != noone)
				{
					GetTextboxInstance().Reset();
				}
				var c23_1 = new TextContext(sprite_mimiAvatarScared, true, cb23_2);
				c23_1.AddSubText(new SubText("What is she?", 0.4, true));
				RenderText(c23_1)
			
				instance_womenSlats.FreezeAnimationAtEnd2(anim_womenSlats);
				
				// Make the sound softer again
				SoundGain(GetRoomMusic(), 0.0, 1000);
			}
			// Start the slats animation
			instance_womenSlats.PlayAnimation2(anim_womenSlats, animationSlatsFinished);
			
			// Delay the carwling back animation slightly
			PlayTimeline(timeline_mimiCrawlsBack);
			
			// Enable updating the Mimi as the audio listener
			GetPlayerInstance().SetUpdateAudioListener(true);
			m_updateAudioListener = false;
		}
		
		cb22_2 = function()
		{
			var c22_2 = new TextContext(sprite_mimiAvatarScared, false, PlaySlatsAnimation);
			c22_2.AddSubText(new SubText("?!", 0.6, true));
			RenderText(c22_2);
		}
		
		c22_1 = new TextContext(sprite_mimiAvatarYell, false, cb22_2);
		c22_1.AddSubText(new SubText("GYAH!", 0.6, true));
		c22_1.m_progressable = false;
		RenderText(c22_1);
		
		animationLeapFinished = function()
		{			
			// Let the play able to progress
			c22_1.m_progressable = true;
			
			PlayerFreezeAnimationEnd2(anim_mimiLeap);
		}
		PlayerPlayAnimation2(anim_mimiLeap, animationLeapFinished);
	}
}

if(m_updateAudioListener)
{
	SetAudioListenerPosition(GetViewportPositionX(), GetViewportPositionY());
}