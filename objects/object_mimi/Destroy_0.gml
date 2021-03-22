for(var i = 0; i < ds_list_size(m_pathCallbacks); i++)
{
	var pathCallback = ds_list_find_value(m_collisionContexts, i);
	delete pathCallback;
}

ds_list_destroy(m_pathCallbacks);