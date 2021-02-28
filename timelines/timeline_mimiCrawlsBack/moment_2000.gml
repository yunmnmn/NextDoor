var animationCrawlFinished = function()
{
	PlayerFreezeAnimationEnd2(anim_mimiCrawlStart);
}
// Start the crawl animation at the same time
PlayerPlayAnimation2(anim_mimiCrawlStart, animationCrawlFinished);