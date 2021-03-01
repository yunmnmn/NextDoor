cbe_2 = function()
{
	var ce_2 = new TextContext(noone, true, noone);
	ce_2.AddSubText(new SubText("The End", 0.2, true));
	ce_2.m_progressable = false;
	RenderText(ce_2);
}

if(GetMimiCaught())
{
	// Show this text when Mimi did get caught
	cbe_1_1 = function()
	{
		var ce_1_1 = new TextContext(noone, true, cbe_2);
		ce_1_1.AddSubText(new SubText("I haven't seen her since", 0.2, true));
		RenderText(ce_1_1);
	}
	
	// Show this text when Mimi did get caught
	var ce_1 = new TextContext(noone, true, cbe_1_1);
	ce_1.AddSubText(new SubText("I fainted when she came close. When I woke up she was gone...", 0.2, true));
	RenderText(ce_1);
}
else
{
	// Show this text when Mimi wasn't caught
	var ce_1 = new TextContext(noone, true, cbe_2);
	ce_1.AddSubText(new SubText("I haven't seen her since", 0.2, true));
	RenderText(ce_1);
}
