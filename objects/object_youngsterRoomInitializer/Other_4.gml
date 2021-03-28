// Call the parent Room Start(object_parentInitalizer)
event_inherited();

RescrictViewportX(910, 2376);

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks(id);