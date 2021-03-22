if(GetMimiCaught())
{
	// Show this text when Mimi did get caught
	cb38_3 = function()
	{
		var c38_3 = new TextContext(noone, false, noone);
		c38_3.AddSubText(new SubText(" I'm moving away as fast as I can.", 0.2, true));
		c38_3.m_progressable = false;
		RenderText(c38_3);
	}
	
	cb38_2 = function()
	{
		var c38_2 = new TextContext(noone, false, cb38_3);
		c38_2.AddSubText(new SubText("As if nothing happened, the woman continued to reside nextdoor", 0.2, true));
		RenderText(c38_2);
	}
	
	// Show this text when Mimi did get caught
	var c38_1 = new TextContext(noone, false, cb38_2);
	c38_1.AddSubText(new SubText("I escaped just in time...", 0.3, true));
	RenderText(c38_1);
}
else
{
	// Show this text when Mimi did get caught
	cb40_3 = function()
	{
		var c40_3 = new TextContext(noone, false, noone);
		c40_3.AddSubText(new SubText("I'm moving away as fast as I can.", 0.3, true));
		c40_3.m_progressable = false;
		RenderText(c40_3);
	}
	
	cb40_2 = function()
	{
		var c40_2 = new TextContext(noone, false, cb40_3);
		c40_2.AddSubText(new SubText("As if nothing happened, the woman continued to reside nextdoor.", 0.3, true));
		RenderText(c40_2)
	}
	
	// Show this text when Mimi did get caught
	var c40_1 = new TextContext(noone, false, cb40_2);
	c40_1.AddSubText(new SubText("After that, I passed out...", 0.3, true));
	RenderText(c40_1);
}

// Set the women in black on the path
instance_endingWomen.SetPath(path_ending, 0.0, instance_endingWomen.m_speed);
// Play the carwling animation
instance_endingWomen.PlayAnimation(anim_womenWalk, true, noone);

// Play the callback when the women reached the end

reachedEnd = function()
{
	instance_endingWomen.path_speed = 0.0;
	instance_endingWomen.visible = false;
	instance_endingWomen.image_speed = 0.0;
}
instance_endingWomen.AddPathEndCallback(reachedEnd, false);