if(!m_overTextbox)
{
	draw_set_colour(c_black);
	draw_set_alpha(m_alpha);
	draw_rectangle(0, 0, GetViewportWidth, GetViewportHeight, false);
	draw_set_alpha(1.0);
	// TODO: white here?
	draw_set_colour(c_white);
}