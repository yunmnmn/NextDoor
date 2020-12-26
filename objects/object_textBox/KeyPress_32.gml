// Only draw something if the TextContext is valid
if(m_textContext != noone)
{
	if(m_state == TextboxState.RenderingContext)
	{
		// HACK: Don't register space twice because of ordering of events
		if(m_sameFrame == 0)
		{
			m_text = "";
		
			for(i = 0; i < ds_list_size(m_textContext.m_subTexts); i++)
			{
				var subText = ds_list_find_value(m_textContext.m_subTexts, i).m_text;
				m_text = m_text + subText;
			}
	
			m_state = TextboxState.Waiting;
		}
	}
	else if(m_state == TextboxState.Waiting)
	{
		// Make a cached copy because this one will be deleted
		var tempTextContext = m_textContext;
	
		// Reset all the states back to default
		Reset();
	
		// Call the callback if there is one
		if(tempTextContext.m_callback != noone)
		{
			tempTextContext.m_callback();
		}
		
		m_sameFrame = 2;
	}
}


