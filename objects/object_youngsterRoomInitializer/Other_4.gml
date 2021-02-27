// Call the parent Room Start(object_parentInitalizer)
event_inherited();

RescrictViewportX(910, 2376);

// Call the doorslam timeline
if(GetGlobalGameState() == GlobalGameStates.MimiEntersYoungstersRoom)
{
	PlayTimeline(timeline_doorslam);
}