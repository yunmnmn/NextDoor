x = m_xOffset;
y = m_yOffset;

// Only draw something if the TextContext is valid
if(ActionKeyPressed())
{
	if(m_textContext != noone)
	{
		if(m_state == TextboxState.RenderingContext)
		{
			// HACK: Don't register space twice because of ordering of events
			// Only allow skipping if it's true
			if(m_sameFrame == 0 && m_textContext.m_skippable)
			{
				m_text = "";
		
				for(var i = 0; i < ds_list_size(m_textContext.m_subTexts); i++)
				{
					var subText = ds_list_find_value(m_textContext.m_subTexts, i).m_text;
					m_text += subText + "\n";
				}
	
				m_state = TextboxState.Waiting;
			}
		}
		else if(m_state == TextboxState.Waiting)
		{
			// Only allow existing the current TextContext if it's progressable
			if(m_textContext.m_progressable)
			{
				// Make a cached copy because this one will be deleted
				var tempTextContext = m_textContext;
	
				// Reset all the states back to default
				ResetWithoutClearingMemory();
	
				// Call the callback if there is one
				if(tempTextContext.m_callback != noone)
				{
					tempTextContext.m_callback();
				}
				
				// Clean the memory
				tempTextContext.Free();
				delete tempTextContext;
			
				m_sameFrame = 2;
			}
		}
	}
}

// Execute the callback if the TextContext has a callback when the avatar finished playing
if(m_textContext != noone && m_textContext.m_animationCallback != noone)
{
	if(m_drawFrame == sprite_get_number(m_textContext.m_avatarSpriteIndex)-1)
	{
		var tmp = m_textContext.m_animationCallback;
		m_textContext.m_animationCallback = noone;
		tmp();
	}
}