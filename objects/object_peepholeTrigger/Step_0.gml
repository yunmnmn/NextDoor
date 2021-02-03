if(GetGlobalGameState() == GlobalGameStates.MimiIsPeeking)
{
	if(ActionKeyHold())
	{
		var interpolatedX = lerp(GetViewportPositionX(), 0, min(m_panSpeed * DeltaTimeInMiliseconds(), 1.0));
		SetViewportPositionX(interpolatedX);
	}
	else
	{
		var interpolatedX = lerp(GetViewportPositionX(), m_viewportLookPositionOriginX, min(m_snapbackSpeed * DeltaTimeInMiliseconds(), 1.0));
		SetViewportPositionX(interpolatedX);
	}
}
