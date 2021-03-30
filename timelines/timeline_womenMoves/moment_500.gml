// Play the sound that the door is opening in the hallway
PlaySound(foley_hallwayDoorOpenDistance, 10.0, false);

// Add the hallway footsteps to the women
instance_youngsetRoomWomenOutside.AddHallwayWalkingSounds();

// Set the path for the women to walk to the window
instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomenFootsteps, 0.0, 1.0);
// Play the walking animation
instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenWalkHallwayProxy, false, noone);


// Play the softer footsteps
function StopWalkingInHallway()
{
	instance_youngsetRoomWomenOutside.m_playSoftFootstepsHallway = true;
}
instance_youngsetRoomWomenOutside.AddPathPointCallback(3, StopWalkingInHallway, false);

function StopWalkingInHallway()
{
	instance_youngsetRoomWomenOutside.image_speed = 0.0;
}
// Set the callback to play the Movie when the women reaches the end of the path
instance_youngsetRoomWomenOutside.AddPathPointCallback(4, StopWalkingInHallway, false);