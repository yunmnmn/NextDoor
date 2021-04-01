if(m_overTextbox)
{
	draw_set_colour(c_black);
	draw_set_alpha(m_alpha);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1.0);
	// Back to default
	draw_set_colour(c_white);
}
