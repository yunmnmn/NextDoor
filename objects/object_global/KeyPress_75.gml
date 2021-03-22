scared = function()
{
	// Hack: move mimi 64 pixels to the left to match the CrawlToIdle animation
	SetControlState(PlayerControlState.PlayerControl);
}

idleToScared = function()
{
	// Hack: move mimi 64 pixels to the left to match the CrawlToIdle animation
	PlayerPlayAnimation2(anim_mimiIdleToScared, scared);
}

crawlToidle = function()
{
	// Hack: move mimi 64 pixels to the left to match the CrawlToIdle animation
	PlayerSnapToClosestPosition(GetPlayerInstance().x + 64, GetPlayerInstance().y, true);
	PlayerPlayAnimation2(anim_mimiCrawlToIdle, idleToScared);
}

// Disable the control the player has
SetControlState(PlayerControlState.PlayerNoControl);

PlayerPlayAnimation2(anim_mimiCrawlStart, crawlToidle);