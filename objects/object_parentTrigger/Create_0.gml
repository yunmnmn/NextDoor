// Add a CollisionContext 
function AddCollisionContext(p_collisionContext)
{
	ds_list_add(m_collisionContexts, p_collisionContext);
}

function DeleteAllCollisionContexts()
{
	// TODO: delete all memory by iterating over all elements
	for(var i = 0; i < ds_list_size(m_collisionContexts); i++)
	{
		var collisionContext = ds_list_find_value(m_collisionContexts, i);
		collisionContext.Free();
		delete collisionContext;
	}
	
	ds_list_clear(m_collisionContexts);
}

m_collisionContexts = ds_list_create();

m_drawButtonPrompt = false;

// Fixed
m_markSpriteIndex = anim_mark;
m_framesPerSecond = sprite_get_speed(m_markSpriteIndex);
m_frameTimeInMiliseconds = 1000.0 / m_framesPerSecond;
// Changes over frames
m_drawFrame = 0;
m_elapsedTimeInMiliseconds = 0.0;

