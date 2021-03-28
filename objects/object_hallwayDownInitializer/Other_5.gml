// Inherit the parent event
event_inherited();

var postRoomLoadContext = new PostRoomLoadContext(noone);
postRoomLoadContext.m_musicPosition = m_roomMusicPosition;
AddPostRoomLoadCallback(postRoomLoadContext);

