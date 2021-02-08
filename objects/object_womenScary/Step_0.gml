if(m_womenAnimationState == WomenScaryAnimationState.Looping)
{
	if(image_index == m_loopAnimationCount)
	{
		image_index = 0;
	}
}
else if(m_womenAnimationState == WomenScaryAnimationState.NoticeMimi)
{
	if(image_index == m_switchAvatarAnimationCount)
	{
		instance_textbox.Reset();
	
		var c19_2 = new TextContext(sprite_womanTurnIdleAvatar, false, noone);
		c19_1.AddSubText(new SubText("...", 0.2));
		AddSubText.m_progressable = false;
		RenderText(c19_2);
	}
}