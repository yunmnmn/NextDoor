// Inherit the parent event
event_inherited();

// Play the ending conversation ab it later after transitioning the room
PlayTimeline(timeline_endingConversation);

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

// Move the viewport too
var viewportEndPosition = new Vector2(room_width - GetViewportWidth(), 0);
FollowPositionAndDisable(viewportEndPosition);
SetViewportFollowSpeed(0.000048);