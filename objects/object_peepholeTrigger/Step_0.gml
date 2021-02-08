if(GetGlobalGameState() == GlobalGameStates.MimiIsPeeking)
{
	if(ActionKeyHold())
	{
		m_pan += m_panSpeed * DeltaTimeInMiliseconds();
	}
	else
	{
		m_pan -= m_snapbackSpeed * DeltaTimeInMiliseconds();
	}
	
	m_pan = max(min(m_pan, 1.0), 0.0);
	var interpolatedX = lerp(m_viewportLookPositionOriginX, 0, m_pan);
	interpolatedX = clamp(interpolatedX, min(m_viewportLookPositionOriginX, 0), max(m_viewportLookPositionOriginX, 0));
	SetViewportPositionX(interpolatedX);
	
	//if(GetViewportPositionX() < 12)
	//{
	//	m_lockedToWomen = true;
	//	instance_womanScary.NoticeMimi();
	//}
	
	var norm = 1.0 - (GetViewportPositionX() / (m_viewportLookPositionOriginX-600));
	instance_wallWithHole.m_scalar = norm;
}
else if(GetGlobalGameState() == GlobalGameStates.MimiFallsBack)
{
}



