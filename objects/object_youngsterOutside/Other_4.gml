if(GetGlobalGameState() == GlobalGameStates.MimiGetsDrink)
{
	instance_outsideMemory.SetYoungsterOutsideVisible(true);
}

if(GetGlobalGameState() == GlobalGameStates.MimiReturnsFromDrinking)
{
	instance_youngsterOutside.PlayAnimation2(sprite_youngsterCornerIdle, noone);
}
else
{
	instance_youngsterOutside.PlayAnimation2(sprite_youngsterCornerIdleShadow, noone);
}

if(GetGlobalGameState() == GlobalGameStates.MimiGetsDrink)
{
	m_useShadowMap = false;
}
else
{
	m_useShadowMap = true;
}
