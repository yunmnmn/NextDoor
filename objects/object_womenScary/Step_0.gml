if(m_womenAnimationState == WomenScaryAnimationState.NoticeMimi)
{
	if(floor(image_index) >= m_switchAvatarAnimationCount && m_dirty == false)
	{
		m_dirty = true;
		
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
	
		var c19_2 = new TextContext(sprite_womanTurnIdleAvatar, false, noone);
		c19_2.m_avatarYOffset = - 16;
		c19_2.m_progressable = false;
		c19_2.AddSubText(new SubText("...", 0.2, true));    
		RenderText(c19_2);
	}
}