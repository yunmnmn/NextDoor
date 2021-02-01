m_drawButtonPrompt = false;

CheckForGlobalState = function(p_collisionContext)
{
	if(p_collisionContext.m_allStates)
	{
		return true;
	}
	
	// Check if the global state is active
	for(j = 0; j < ds_list_size(collisionContext.m_globalStates); j++)
	{
		var globalState = ds_list_find_value(collisionContext.m_globalStates, j);
		if(GetGlobalGameState() == globalState)
		{
			return true;
		}
	}
	
	return false;
}

// Check for collisions
for(i = 0; i < ds_list_size(m_collisionContexts); /*don't iuncrement here*/)
{
	var collisionContext = ds_list_find_value(m_collisionContexts, i);
	assert(collisionContext.m_collisionInstance != noone && collisionContext.m_callback != noone, "CollisionContext has invalid members");
	
	// Check if this trigger collides with the CollisionInstaince
	if(place_meeting(x, y, collisionContext.m_collisionInstance) && CheckForGlobalState(collisionContext))
	{
		m_drawButtonPrompt = true;
		
		m_elapsedTimeInMiliseconds += DeltaTimeInMiliseconds();
		if(m_elapsedTimeInMiliseconds > m_frameTimeInMiliseconds)
		{
			m_elapsedTimeInMiliseconds = 0.0;
			m_drawFrame = (m_drawFrame + 1) % (sprite_get_number(anim_buttonSpace))
		}
		
		if(keyboard_check(vk_space))
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