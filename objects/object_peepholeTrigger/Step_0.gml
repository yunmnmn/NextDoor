if(GetGlobalGameState() == GlobalGameStates.MimiIsPeeking)
{
	if(!m_lockedToWomen)
	{
		if(ActionKeyHold())
		{
			m_pan += m_panSpeed * DeltaTimeInMiliseconds();
		}
		else
		{
			m_pan -= m_snapbackSpeed * DeltaTimeInMiliseconds();
		}
	}
	
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(m_viewportLookPositionOriginX, 0, m_pan);
	interpolatedX = clamp(interpolatedX, min(m_viewportLookPositionOriginX, 0), max(m_viewportLookPositionOriginX, 0));
	SetViewportPositionX(interpolatedX);
	
	if(GetViewportPositionX() < 6)
	{
		SetViewportPositionX(0.0);
		m_lockedToWomen = true;
		SetGlobalGameState(GlobalGameStates.MimiLocksPeeking);
		instance_womanScary.NoticesMimi();
	}
	
	var norm = 1.0 - (GetViewportPositionX() / (m_viewportLookPositionOriginX - 600));
	norm = clamp(norm, 0.0, 1.0);
	instance_wallWithHole.m_scalar = norm;
}
else if(GetGlobalGameState() == GlobalGameStates.MimiIsShocked)
{
	m_pan -= m_snapbackSpeed * DeltaTimeInMiliseconds() * 2.0;
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(m_viewportLookPositionOriginX, 0, m_pan);
	interpolatedX = clamp(interpolatedX, min(m_viewportLookPositionOriginX, 0), max(m_viewportLookPositionOriginX, 0));
	SetViewportPositionX(interpolatedX);
	
	var norm = 1.0 - (GetViewportPositionX() / (m_viewportLookPositionOriginX-600));
	norm = clamp(norm, 0.0, 1.0);
	instance_wallWithHole.m_scalar = norm;
}
else if(GetGlobalGameState() == GlobalGameStates.MimiPeepsAgain)
{
	if(!m_lockedToWomen)
	{
		if(ActionKeyHold())
		{
			m_pan += m_panSpeed * DeltaTimeInMiliseconds();
		}
		else
		{
			m_pan -= m_snapbackSpeed * DeltaTimeInMiliseconds();
		}
	}
	
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(m_viewportLookPositionOriginX, m_secondPeekViewportPositionX, m_pan);
	// TODO: does this make sense?
	interpolatedX = clamp(interpolatedX, min(m_viewportLookPositionOriginX, 0), max(m_viewportLookPositionOriginX, 0));
	SetViewportPositionX(interpolatedX);
	
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
	scalar += m_womenCloseToWallFadeSpeed * DeltaTimeInMiliseconds();
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
	}
}
else if(GetGlobalGameState() == GlobalGameStates.MimiFallsBackwards)
{	
	m_pan -= m_snapbackSpeed * DeltaTimeInMiliseconds() * 2.0;
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(m_viewportLookPositionOriginX, 0, m_pan);
	interpolatedX = clamp(interpolatedX, min(m_viewportLookPositionOriginX, 0), max(m_viewportLookPositionOriginX, 0));
	SetViewportPositionX(interpolatedX);
	
	var norm = 1.0 - (GetViewportPositionX() / (m_viewportLookPositionOriginX-600));
	norm = clamp(norm, 0.0, 1.0);
	instance_wallWithHole.m_scalar = norm;
	
	if(!m_womenAttacks && norm == 0.0)
	{
		m_womenAttacks = true;
		
		animationCrawlFinished = function()
		{
			PlayerFreezeAnimationEnd2(anim_mimiCrawlStart);
		}
		animationLeapFinished = function()
		{
			PlayerPlayAnimation2(anim_mimiCrawlStart, animationCrawlFinished)
		}
		PlayerPlayAnimation2(anim_mimiLeap, animationLeapFinished);
		
		animationSlatsFinished = function()
		{
			conversationFinished = function()
			{
			}
			
			cb23_6 = function()
			{
				var c23_6 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
				c23_6.AddSubText(new SubText("Were exactly the same woman ", 0.2));
				RenderText(c23_6);
			}
			
			cb23_5 = function()
			{
				var cb23_5 = new TextContext(sprite_mimiAvatarTroubled, true, cb23_6);
				cb23_5.AddSubText(new SubText("All of those women with different figures", 0.2));
				RenderText(cb23_5);
			}
			
			cb23_4 = function()
			{
				var c23_4 = new TextContext(sprite_mimiAvatarTroubled, true, cb23_5);
				c23_4.AddSubText(new SubText("Does this mean…", 0.2));
				RenderText(c23_4);
			}
			
			cb23_3 = function()
			{
				var c23_3 = new TextContext(sprite_mimiAvatarTroubled, true, cb23_4);
				c23_3.AddSubText(new SubText("Why do they exstend and contract?", 0.2));
				RenderText(c23_3);
			}
			
			cb23_2 = function()
			{
				var c23_2 = new TextContext(sprite_mimiAvatarTroubled, true, cb23_3);
				c23_2.AddSubText(new SubText("Those limbs", 0.2));
				RenderText(c23_2);
			}
			
			// Start of the conversation.
			instance_textbox.Reset();
			var c23_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb23_2);
			c23_1.AddSubText(new SubText("What is she?", 0.2));
			RenderText(c23_1)
			
			instance_womenSlats.FreezeAnimationAtEnd2(anim_womenSlats);
			instance_womenSlats.visible = false;
		}
		instance_womenSlats.visible = true;
		instance_womenSlats.PlayAnimation2(anim_womenSlats, animationSlatsFinished);
		
		
		instance_textbox.Reset();
		var c22_1 = new TextContext(sprite_mimiAvatarYell, false, noone);
		c22_1.AddSubText(new SubText("GYAH!", 0.2));
		c22_1.m_progressable = false;
		RenderText(c22_1);
	}
}




