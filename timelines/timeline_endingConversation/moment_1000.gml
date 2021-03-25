// Set the women in black on the path
instance_endingWomen.SetPath(path_ending, 0.0, instance_endingWomen.m_endingSpeed);
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

// Set the viewport speed
SetViewportFollowSpeed(0.000048);

// Set the fading speed
m_fader.SetFadingSpeed(GetDefaultFadingSpeed());

// Start the conversation
var c40_2 = new TextContext(noone, false, noone);
c40_2.AddSubText(new SubText("As if nothing happened, the woman continued to reside", 0.2, true));
c40_2.AddSubText(new SubText("nextdoor.", 0.2, true));
c40_2.m_progressable = false;
RenderText(c40_2)