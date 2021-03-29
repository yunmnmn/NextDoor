// Inherit the parent event
event_inherited();

// Set the credits invisible
instance_creditsCards.visible = false;

m_fader.SetFadingSpeed(0.0);

// Play the ending conversation ab it later after transitioning the room
PlayTimeline(timeline_endingConversation);

// Move the viewport too
var viewportEndPosition = new Vector2(room_width - GetViewportWidth() / 2, 0);
FollowPositionAndDisable(viewportEndPosition);
SetViewportFollowSpeed(0.0);