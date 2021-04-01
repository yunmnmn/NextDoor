// Inherit the parent event
event_inherited();

// Set the credits invisible
instance_creditsCards.visible = false;

m_fader.SetFadingSpeed(0.0);

// Play the ending conversation ab it later after transitioning the room
PlayTimeline(timeline_endingConversation);

// Move the viewport too
//FollowPositionAndCallback
var viewportEndPosition = new Vector2(room_width - GetViewportWidth() / 2, 0);
FollowPositionAndDisable(viewportEndPosition);
SetViewportFollowSpeed(0.0);

// Play the footstep sounds in the hallway ending
instance_endingWomen.AddNormalWalkingSounds();

// Play the scary ambient music
PlayRoomMusic(GetAmbientScary(), "EndingAmbient", true, 1.0, false);
SoundGain(GetRoomMusic(), 0.0, 0.0);
SoundGain(GetRoomMusic(), 1.0, 1000);