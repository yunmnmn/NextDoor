m_doorYoungsterVisible = false;
m_doorWomenVisible = false;
m_doorOldtimerVisible = false;
m_youngsterVisible = false;
m_womenVisible = false;
m_oldtimerVisible = false;


function SetDoorYoungsterVisible(p_visible)
{
	m_doorYoungsterVisible = p_visible;
	instance_doorYoungster.visible = p_visible;
}

function SetDoorWomenVisible(p_visible)
{
	m_doorWomenVisible = p_visible;
	instance_doorWomen.visible = p_visible;
}

function SetDoorOldtimerVisible(p_visible)
{
	m_doorOldtimerVisible = p_visible;
	instance_doorOldtimer.visible = p_visible;
}

function SetYoungsterVisible(p_visible)
{
	m_youngsterVisible = p_visible;
	instance_youngster.visible = p_visible;
}

function SetWomenVisible(p_visible)
{
	m_womenVisible = p_visible;
	instance_women.visible = p_visible;
}

function SetOldtimerVisible(p_visible)
{
	m_oldtimerVisible = p_visible;
	instance_oldtimer.visible = p_visible;
}

m_playedCockroach = false;
m_playedCan = false;