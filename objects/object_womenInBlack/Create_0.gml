// Inherit the parent event
event_inherited();

PlayFootstepSound = function()
{
	// Appartment footstep sounds
	appartmentWalkSounds[0] = foley_appartmentWalkingStep1;
	appartmentWalkSounds[1] = foley_appartmentWalkingStep2;
	appartmentWalkSounds[2] = foley_appartmentWalkingStep3;
	appartmentWalkSounds[3] = foley_appartmentWalkingStep4;
	appartmentWalkSounds[4] = foley_appartmentWalkingStep5;
	
	// Hallway footstep sounds
	hallwayWalkSounds[0] = foley_hallwayWalkingStep1;
	hallwayWalkSounds[1] = foley_hallwayWalkingStep2;
	hallwayWalkSounds[2] = foley_hallwayWalkingStep3;
	hallwayWalkSounds[3] = foley_hallwayWalkingStep4;
	hallwayWalkSounds[4] = foley_hallwayWalkingStep5;
	
	// Outside footstep sounds
	outsideWalkSounds[0] = foley_outsideWalkingStep1;
	outsideWalkSounds[1] = foley_outsideWalkingStep2;
	outsideWalkSounds[2] = foley_outsideWalkingStep3;
	outsideWalkSounds[3] = foley_outsideWalkingStep4;
	outsideWalkSounds[4] = foley_outsideWalkingStep5;

	var array = noone;
	
	// Play Appartment footsteps
	if(GetRoomType() == RoomType.Appartment)
	{
		array = appartmentWalkSounds;
	}
	else if(GetRoomType() == RoomType.Hallway)
	{
		array = hallwayWalkSounds;
	}
	else // It's outside
	{
		array = outsideWalkSounds;
	}
	
	var arrayLength = array_length(array);
	var arrayIndex = floor(random(arrayLength));
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = array[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundSpider = function()
{
	// Appartment footstep sounds
	spiderWalkSounds[0] = foley_womenSpiderWalk1;
	spiderWalkSounds[1] = foley_womenSpiderWalk2;
	spiderWalkSounds[2] = foley_womenSpiderWalk3;
	spiderWalkSounds[3] = foley_womenSpiderWalk4;
	spiderWalkSounds[4] = foley_womenSpiderWalk5;
	
	var arrayLength = array_length(spiderWalkSounds);
	var arrayIndex = floor(random(arrayLength));
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex2)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex2 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = spiderWalkSounds[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundGiant = function()
{
	// Appartment footstep sounds
	giantWalkSounds[0] = foley_womenGiantWalk1;
	giantWalkSounds[1] = foley_womenGiantWalk2;
	giantWalkSounds[2] = foley_womenGiantWalk3;
	giantWalkSounds[3] = foley_womenGiantWalk4;
	giantWalkSounds[4] = foley_womenGiantWalk5;
	
	var arrayLength = array_length(giantWalkSounds);
	var arrayIndex = floor(random(arrayLength));
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex3)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex3 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = giantWalkSounds[arrayIndex];
	return footstepSoundIndex;
}	

PlayFootstepSoundHallway = function()
{
	// Appartment footstep sounds
	hallwayWalkSoundsEcho[0] = foley_womenHallwayWalk1;
	hallwayWalkSoundsEcho[1] = foley_womenHallwayWalk2;
	hallwayWalkSoundsEcho[2] = foley_womenHallwayWalk3;
	hallwayWalkSoundsEcho[3] = foley_womenHallwayWalk4;
	hallwayWalkSoundsEcho[4] = foley_womenHallwayWalk5;
	
	var arrayLength = array_length(hallwayWalkSoundsEcho);
	var arrayIndex = floor(random(arrayLength));
	
	// If the footstep sound index is the same ast he last one, change it
	if(arrayIndex == m_cachedFootstepSoundIndex4)
	{
		arrayIndex = (arrayIndex + 1) % arrayLength;
	}
	
	// Cache the current footstepindex
	m_cachedFootstepSoundIndex4 = arrayIndex
	
	// Get the new footstep index
	var footstepSoundIndex = hallwayWalkSoundsEcho[arrayIndex];
	return footstepSoundIndex;
}	