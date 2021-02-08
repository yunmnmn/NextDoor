enum WomenScaryAnimationState
{
	Looping,
	NoticeMimi,
}

function NoticesMimi()
{
	BackToMimi = function()
	{
		instance_peepholeTrigger.m_lockedToWomen = false;
		SetGlobalGameState(GlobalGameStates.MimiFallsBack);
	}
	
	PlayTurnAvatar = function()
	{
		instance_textbox.Reset();
	
		var c19_2 = new TextContext(anim_womanTurnAvatar, false, noone);
		c19_1.AddSubText(new SubText("!", 0.2));
		AddSubText.m_progressable = false;
		RenderText(c19_2);
	}
	
	PlayTurnAnimation = function()
	{
		// Play the turn of the avatar when this is done
		PlayAnimation2(anim_womenTurn, PlayTurnAnimation);
	}
	
	PlayAnimation2(anim_womenScrew, PlayTurnAnimation);
	m_womenAnimationState = WomenScaryAnimationState.NoticeMimi;
	
	instance_textbox.Reset();
	
	var c19_1 = new TextContext(sprite_womanArmAvatar, false, noone);
	c19_1.AddSubText(new SubText("...", 0.2));
	AddSubText.m_progressable = false;
	RenderText(c19_1);
}

m_loopAnimationCount = 9;
m_switchAvatarAnimationCount = 18;

m_womenAnimationState = WomenScaryAnimationState.Looping;

