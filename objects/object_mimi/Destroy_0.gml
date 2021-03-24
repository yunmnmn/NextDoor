// Destroy all the PathCallbacks, and clean up the memory
for(var i = 0; i < ds_list_size(m_pathCallbacks); i++)
{
	var pathCallback = ds_list_find_value(m_collisionContexts, i);
	delete pathCallback;
}
ds_list_destroy(m_pathCallbacks);

// Destroy all the SoundContexts, and clean up the memory
for(var i = 0; i < ds_list_size(m_soundContexts); i++)
{
	var soundContext = ds_list_find_value(m_soundContexts, i);
	delete soundContext;
}
ds_list_destroy(m_soundContexts);