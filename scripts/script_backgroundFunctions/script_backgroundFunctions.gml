// NOTE:
/*
For Sijbren: Some weird ass lingo for texture, sprites, texturemaps, object, instances blabla

object: acts as a template, in which instances can be created from. Objects can have references to
components(sprites, script, sounds, etc)

instances: data copy representative of an object's data and components. Each single instance is a hard-copy
meaning that changing an instance, won't change any other instances made from the object

texturemaps: GameMaker allocates images on texturemaps, instead of allocating each texture as its
resource. This means that GM allocates a really big texture, and suballocates small textures on it. 
This is probably due to optimizations (less binding information to shader etc)

image: Resource that refernces a piece of image from the texturemaps, and some meta data

sprite: Resource that references 1 or multiple textures. GM calls them subimages now... very confusing
*/

// Sets the backgroundInstance, this must be called once per level by the background instance
function RegisterBackgroundInstance(p_instance)
{
	// Check if the background instance is 0 first
	assert_fail(global.g_backgroundInstance != noone, "backgroundInstance variable should be initialized by the object_global to 0 first. Make sure that object_global is initialized first in the room order");
	
	// Check if the background instance's sprite has two frames (0 = background, 1 = shadowmap)
	var backgroundSpriteIndex = object_get_sprite(p_instance.object_index);
	var backgroundSpriteImageCount = sprite_get_number(backgroundSpriteIndex);
	assert_fail(backgroundSpriteImageCount != 2, "The sprite needs to have 2 images, 0 = background, and 1 = shadowmap.");
	
	global.g_backgroundInstance = p_instance;
}

function GetBackgroundInstance()
{
	// Check if the background instance is valid
	assert_fail(global.g_backgroundInstance == noone, "backgroundInstance variable should be initialized by the object_global to 0 first");
	
	return global.g_backgroundInstance;
}

// Resets the backgroundInstance
function ResetBackgroundInstance()
{
	global.g_backgroundInstance = noone;
}

// Returns the BackgroundSpriteIndex
function GetBackgroundSpriteIndex()
{
	assert_fail(global.g_backgroundInstance == noone, "backgroundInstance cannot be 0");
	
	var backgroundSpriteIndex = object_get_sprite(global.g_backgroundInstance.object_index);
	assert_fail(backgroundSpriteIndex == -1, "This shouldn't be -1, this means that the object did not have a sprite assigned to it");
	
	return backgroundSpriteIndex;
}

// Returns the Background texture (the one the player sees)
function GetBackgroundTexture()
{
	assert_fail(global.g_backgroundInstance == noone, "backgroundInstance cannot be 0");
	var backgroundTexture = sprite_get_texture(GetBackgroundSpriteIndex(), 0);
	return backgroundTexture;
}

// Returns the ShadowMap texture
function GetShadowMapTexture()
{
	assert_fail(global.g_backgroundInstance == noone, "backgroundInstance cannot be 0");
	var shadowMapTexture = sprite_get_texture(GetBackgroundSpriteIndex(), 1);
	return shadowMapTexture;
}