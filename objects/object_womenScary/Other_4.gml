enum WomenScaryAnimationState
{
	Looping,
	NoticeMimi,
}

function NoticesMimi()
{
	BackToMimi = function()
	{
		instance_textbox.Reset();
		
		SetGlobalGameState(GlobalGameStates.MimiIsShocked);
		instance_peepholeTrigger.MimiIsSpooked();
	}
	
	PlayTurnAvatar = function()
	{
		// Freeze at the last turn animation
		FreezeAnimationAtEnd2(anim_womenTurn);
		
		instance_textbox.Reset();
	
		var c19_3 = new TextContext(anim_womanTurnAvatar, false, noone);
		c19_3.m_avatarYOffset = - 16;
		c19_3.m_progressable = false;
		c19_3.AddSubText(new SubText("!", 0.2, true));
		c19_3.m_animationCallback = BackToMimi;
		RenderText(c19_3);
	}
	
	PlayTurnAnimation = function()
	{
		// Play the turn of the avatar when this is done
		PlayAnimation2(anim_womenTurn, PlayTurnAvatar);
	}
	
	PlayAnimation2(anim_womenScrew, PlayTurnAnimation);
	m_womenAnimationState = WomenScaryAnimationState.NoticeMimi;
	
	instance_textbox.Reset();
	var c19_1 = new TextContext(sprite_womenScrewAvatar, false, noone);
	c19_1.m_progressable = false;
	c19_1.AddSubText(new SubText("...", 0.2, true));
	RenderText(c19_1);
}

m_loopAnimationCount = 9;
m_switchAvatarAnimationCount = 50;

m_dirty = false;

m_womenAnimationState = WomenScaryAnimationState.Looping;

