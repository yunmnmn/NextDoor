// Calculate the average Delta time
AverageDeltaTimeInMiliseconds();

// Check if the input device changed
var lastDevice = CheckLastControlDevicePressed();
if(lastDevice != m_controlDevice && lastDevice != noone)
{
	m_controlDevice = lastDevice;
}