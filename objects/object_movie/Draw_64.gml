if(m_play)
{
	// Draw the background
	draw_sprite(movie_background, 0, 0, 0);
	// Draw the low frames
	draw_sprite(movie_womenLowFrames, m_drawFrame, 0, 0);
	// Draw the foreground
	draw_sprite(movie_foreground, 0, 0, 0);
	// Draw the top frames
	draw_sprite(movie_womenTopFrames, m_drawFrame, 0, 0);
}
