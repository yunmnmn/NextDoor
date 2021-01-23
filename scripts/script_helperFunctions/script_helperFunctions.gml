// Returns the width and height from a sprite index
function GetSpriteSize(p_spriteIndex)
{	
	assert(p_spriteIndex != noone, "spriteIndex is invalid");
	return new Vector2(sprite_get_width(p_spriteIndex), sprite_get_height(p_spriteIndex));
}

// Returns the world position of the instance
function GetWorldPosition(p_instanceIndex)
{
	assert(p_instanceIndex != noone, "instanceIndex is invalid");
	return new Vector2(p_instanceIndex.x, p_instanceIndex.y);
}

// Returns the delta time in miliseconds rather than the default (microsecond)
function DeltaTimeInMiliseconds()
{
	return delta_time / 1000;
}