m_youngsterOutsideVisible = false;
m_womenOutsideVisible = false;
m_lampOutsideNearStairs = false;
m_lampOutsideNearDoor = false;

function SetYoungsterOutsideVisible(p_visible)
{
	m_youngsterOutsideVisible = p_visible;
	instance_youngsterOutside.visible = p_visible;
}

function SetWomenOutsideVisible(p_visible)
{
	m_womenOutsideVisible = p_visible;
	instance_womenOutside.visible = p_visible;
}

function SetLampOutsideNearStairsVisible(p_visible)
{
	m_lampOutsideNearStairs = p_visible;
	instance_lampOutsideNearStairs.visible = p_visible;
}

function SetLampOutsideNearDoorVisible(p_visible)
{
	m_lampOutsideNearDoor = p_visible;
	instance_lampOutsideNearDoor.visible = p_visible;
}

// Can and Cat values
m_playedCat = false;
m_talkedToCat = false;