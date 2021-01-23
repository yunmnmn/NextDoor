// Draw the text
draw_set_font(font_textboxFont);

// Only draw something if the TextContext is valid
if(m_textContext != noone)
{
	// TODO: Move this logic to a step event, instead of a draw
	if(m_state == TextboxState.RenderingContext)
	{	
		var stringToRender = "";
	
		var subTextCount = ds_list_size(m_textContext.m_subTexts);
		if(m_subTextIndex < subTextCount)
		{
			var subText = ds_list_find_value(m_textContext.m_subTexts, m_subTextIndex);
			var text = subText.m_text;
			var playSpeed = subText.m_playSpeed;
		
			m_textPosition += playSpeed;
			var subString = string_copy(text, 1, min(string_length(text), m_textPosition));
		
			stringToRender = m_text + subString;
		
			// If it reached the end of the subText, go to the next one
			if(m_textPosition >= string_length(text) + 1)
			{
				m_text = stringToRender;
				m_subTextIndex++;
				m_textPosition = 0;
			}
		}
		else
		{
			stringToRender = m_text;
			m_state = TextboxState.Waiting;
		}
	
		var textHeight = string_height(stringToRender);
		draw_text_ext(x, y, stringToRender, textHeight, sprite_width);
	}
	else if(m_state == TextboxState.Waiting)
	{
		// Draw the full text
		var textHeight = string_height(m_text);
		draw_text_ext(x, y, m_text, textHeight, sprite_width);
	
		// Only allow progressing when the current TextContext is progressable
		if(m_textContext.m_progressable)
		{
			// Draw a small white box on the bottom right corner to indicate that the text is finished
			var boxSize = new Vector2(10.0, 10.0);
			var boxPosition = new Vector2(x + sprite_width - boxSize.m_x, y + sprite_height - boxSize.m_y);
			draw_rectangle(boxPosition.m_x, boxPosition.m_y, boxPosition.m_x + boxSize.m_x, boxPosition.m_y + boxSize.m_y, false);
		}
	}
	
	// Draw the sprite if it's valid
	if(m_textContext.m_avatarSpriteIndex != noone)
	{
		// Hardcoded offset
		var offset = 10;
		draw_sprite(m_textContext.m_avatarSpriteIndex, 0, x - sprite_get_width(m_textContext.m_avatarSpriteIndex) - offset, y);
	}
}

m_sameFrame -= 1;
m_sameFrame = clamp(m_sameFrame, 0, 1);
