// Calculate the average Delta time
AverageDeltaTimeInMiliseconds();

// Check if the input device changed
var lastDevice = CheckLastControlDevicePressed();
if(lastDevice != m_controlDevice && lastDevice != noone)
{
	// Stop the rumble if it was the controller
	StopRumble();
	
	// Set the control device that was last pressed
	m_controlDevice = lastDevice;
}