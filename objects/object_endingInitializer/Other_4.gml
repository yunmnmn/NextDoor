// Inherit the parent event
event_inherited();

// Reset the TextContext in case the screaming is still happening
if(GetCurrentTextContext() != noone)
{
	GetCurrentTextContext().Reset();
}

// Play the ending conversation ab it later after transitioning the room
PlayTimeline(timeline_endingConversation);