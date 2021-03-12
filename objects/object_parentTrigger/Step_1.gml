m_drawButtonPrompt = false;

CheckForGlobalState = function(p_collisionContext)
{	
	// Check if the global state is active
	if(!p_collisionContext.m_doNotExecuteOn)
	{	// Only execute on objects that are listed in the filter
		
		if(p_collisionContext.m_allStates)
		{
			return true;
		}
		
		for(j = 0; j < ds_list_size(p_collisionContext.m_globalStates); j++)
		{
			var globalState = ds_list_find_value(p_collisionContext.m_globalStates, j);
			if(GetGlobalGameState() == globalState)
			{
				return true;
			}
		}
		
		return false;
	}
	else
	{	// Execute on all instances, except the ones that are listed
		for(j = 0; j < ds_list_size(p_collisionContext.m_globalStates); j++)
		{
			var globalState = ds_list_find_value(p_collisionContext.m_globalStates, j);
			if(GetGlobalGameState() == globalState)
			{
				return false;
			}
		}
		return true;
	}
}

// Check for collisions
for(i = 0; i < ds_list_size(m_collisionContexts); /*don't iuncrement here*/)
{
	var collisionContext = ds_list_find_value(m_collisionContexts, i);
	assert(collisionContext.m_collisionInstance != noone && collisionContext.m_callback != noone, "CollisionContext has invalid members");
	
	// Check if this trigger collides with the CollisionInstaince, and if the global state matches, and if there is no instance happening now
	if(place_meeting(x, y, collisionContext.m_collisionInstance) && CheckForGlobalState(collisionContext) && GetCurrentTextContext() == noone && GetDisableAllTriggers() == false)
	{
		if(!collisionContext.m_executeOnHit)
		{
			m_drawButtonPrompt = true;
		}
		
		m_elapsedTimeInMiliseconds += DeltaTimeInMiliseconds();
		if(m_elapsedTimeInMiliseconds > m_frameTimeInMiliseconds)
		{
			m_elapsedTimeInMiliseconds = 0.0;
			m_drawFrame = clamp(m_drawFrame + 1, 0, sprite_get_number(m_markSpriteIndex) - 1);
		}
		
		if(collisionContext.m_executeOnHit || ActionKeyPressed())
		{
			collisionContext.m_callback();
			ds_list_delete(m_collisionContexts, i);
		}
		else
		{
			i++;
			continue;
		}
	}
	else
	{
		i++;
	}
}

// Reset the frame count if it's invalid
if(!m_drawButtonPrompt)
{
	m_drawFrame = 0;
	m_elapsedTimeInMiliseconds = 0.0;
}