// Inherit the parent event
event_inherited();

// Remove the pressing button prompt
instance_global.DrawActionPressPrompt(false, 0, 0);
// Remove the moving button prompt
instance_global.DrawMovingPrompt(false, 0, 0);

var postRoomLoadContext = new PostRoomLoadContext(noone);
postRoomLoadContext.m_musicPosition = m_roomMusicPosition;
AddPostRoomLoadCallback(postRoomLoadContext);
