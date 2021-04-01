// Draw the text
draw_set_font(font_textboxFont);

// Only draw something if the TextContext is valid
if(m_textContext != noone)
{
	if(m_state == TextboxState.RenderingContext)
	{	
		var stringToRender = "";
	
		var subTextCount = ds_list_size(m_textContext.m_subTexts);
		if(m_subTextIndex < subTextCount)
		{
			var subText = ds_list_find_value(m_textContext.m_subTexts, m_subTextIndex);
			
			// TODO comment
			if(!m_textDirty)
			{
				if(subText.m_newLine)
				{
					m_text += "\n";
				}
				else
				{
					m_text += " ";
				}
				m_textDirty = true;
			}
			
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
				m_textDirty = false;
			}
		}
		else
		{
			stringToRender = m_text;
			m_state = TextboxState.Waiting;
		}
	
		draw_text_ext(x, y, stringToRender, m_textHeight, sprite_width);
	}
	else if(m_state == TextboxState.Waiting)
	{
		// Draw the full text
		draw_text_ext(x, y, m_text, m_textHeight, sprite_width);
	
		// Only allow progressing when the current TextContext is progressable
		if(m_textContext.m_progressable)
		{
			m_elapsedTimeInMilisecondsMarker += GetAverageDeltaTimeInMiliseconds();
			if(m_elapsedTimeInMilisecondsMarker > 1000.0 / m_markerImageSpeed)
			{
				m_elapsedTimeInMilisecondsMarker = 0.0;
				m_markerFrame = (m_markerFrame + 1) % m_markerImageNumber;
			}
			// Draw a small white box on the bottom right corner to indicate that the text is finished
			draw_sprite(m_textBoxMarkerSpriteIndex, m_markerFrame, x + sprite_width - m_markerWidth, y + sprite_height - m_markerHeight);
		}
	}
	
	// Draw the sprite if it's valid
	if(m_textContext.m_avatarSpriteIndex != noone)
	{
		m_elapsedTimeInMiliseconds += GetAverageDeltaTimeInMiliseconds();
		if(m_elapsedTimeInMiliseconds > 1000.0 / m_textContext.m_avatarImageSpeed)
		{
			m_elapsedTimeInMiliseconds = 0.0;
			m_drawFrame = clamp(m_drawFrame + 1, 0, sprite_get_number(m_textContext.m_avatarSpriteIndex) - 1);
		}
		
		// Hardcoded offset
		var offset = 10;
		draw_sprite(m_textContext.m_avatarSpriteIndex, m_drawFrame, x - sprite_get_width(m_textContext.m_avatarSpriteIndex) - offset, y + m_textContext.m_avatarYOffset);
	}
}

m_sameFrame -= 1;
m_sameFrame = clamp(m_sameFrame, 0, 1);