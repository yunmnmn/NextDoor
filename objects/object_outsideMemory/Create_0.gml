m_blinkingLightVisible = false;
m_youngsterOutsideVisible = false;
m_womenOutsideVisible = false;

function SetBlinkingLightVisible(p_visible)
{
	m_blinkingLightVisible = p_visible;
	instance_blinkingLight.visible = p_visible;
}

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