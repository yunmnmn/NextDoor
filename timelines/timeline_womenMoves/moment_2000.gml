// If the current TextContext is occupied, go back a second
if(GetCurrentTextContext() != noone)
{
	timeline_position = timeline_position - 1000;
}
else
{
	// Start of the conversation. Doesn't require a function
	var c24_1 = new TextContext(sprite_mimiAvatarScared, true, noone);	
	c24_1.AddSubText(new SubText("She's walking through the hallway", 0.6, true));
	c24_1.m_progressable = false;
	RenderText(c24_1);
}
