// Play the Youngster gasp animation
var animationEndCallback = function()
{
	// Freeze at the last frame
	instance_youngsterOutside.FreezeAnimationAtEnd(anim_youngsterCornerGasp);
};
instance_youngsterOutside.PlayAnimation2(anim_youngsterCornerGasp, animationEndCallback);

var c11_19 = new TextContext(sprite_youngsterAvatarGasp, true, cb11_20);
c11_19.AddSubText(new SubText("AH!", 0.6, true));
RenderText(c11_19);