//// Draw TextBox
//draw_sprite(sprite_textBox, 0, x, y);

// Draw the text
draw_set_font(font_textboxFont);

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
		if(string_length(text) == m_textPosition)
		{
			m_text = stringToRender;
			m_subTextIndex++;
			m_textPosition = 0;
		}
	}
	else
	{
		stringToRender = m_text;
	}
	
	var textHeight = string_height(stringToRender);
	draw_text_ext(x, y, stringToRender, textHeight, sprite_width);
}
