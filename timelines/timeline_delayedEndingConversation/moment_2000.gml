transitionToEndingRoom = function()
{
	// Delete the fader
	fader.instance_destroy();
		
	// Reset the textbox
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
		
	// Change to the ending Room
	ChangeRooms(room_ending);
}

if(GetMimiCaught())
{
	var c40_1 = new TextContext(noone, false, transitionToEndingRoom);
	c40_1.AddSubText(new SubText("After that, I passed out...", 0.3, true));
	RenderText(c40_1);
}
else
{
	var c38_1 = new TextContext(noone, false, transitionToEndingRoom);
	c38_1.AddSubText(new SubText("I escaped just in time...", 0.3, true));
	RenderText(c38_1);
}

