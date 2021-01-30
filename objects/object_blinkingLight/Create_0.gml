function PlayAnimation(p_spriteIndex, p_callbackEnd)
{
	sprite_index = p_spriteIndex;
	m_callbackAnimationEnd = p_callbackEnd;
}

m_callbackAnimationEnd = noone;

m_dirtyFlag = false;
m_player = GetPlayerInstance();