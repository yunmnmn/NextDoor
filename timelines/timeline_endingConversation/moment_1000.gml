cb40_3 = function()
{
	var c40_3 = new TextContext(noone, false, noone);
	c40_3.AddSubText(new SubText("I'm moving away as fast as I can.", 0.3, true));
	c40_3.m_progressable = false;
	RenderText(c40_3);
}
	
var c40_2 = new TextContext(noone, false, cb40_3);
c40_2.AddSubText(new SubText("As if nothing happened, the woman continued to reside nextdoor.", 0.3, true));
RenderText(c40_2)