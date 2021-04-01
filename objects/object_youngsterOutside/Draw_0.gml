if(m_useShadowMap)
{
	// Inherit the parent event
	event_inherited();
}
else
{
	// Draw the sprite without the shadowmap
	draw_self();
}


