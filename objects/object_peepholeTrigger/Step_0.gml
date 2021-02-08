if(GetGlobalGameState() == GlobalGameStates.MimiIsPeeking)
{
	if(ActionKeyHold())
	{
		var interpolatedX = lerp(GetViewportPositionX(), 0, max(min(m_panSpeed * DeltaTimeInMiliseconds(), 1.0), 0.01));
		SetViewportPositionX(interpolatedX);
	}
	else
	{
		if(!m_lockedToWomen)
		{
			var interpolatedX = lerp(GetViewportPositionX(), m_viewportLookPositionOriginX, max(min(m_snapbackSpeed * DeltaTimeInMiliseconds(), 1.0), 0.01));
			SetViewportPositionX(interpolatedX);
		}
	}
	
	if(GetViewportPositionX() < 12)
	{
		m_lockedToWomen = true;
		instance_womanScary.NoticeMimi();
	}
}
else if(GetGlobalGameState() == GlobalGameStates.MimiFallsBack)
{
}

var norm = 1.0 - (GetViewportPositionX() / m_viewportLookPositionOriginX);
instance_wallWithHole.m_scalar = norm;

