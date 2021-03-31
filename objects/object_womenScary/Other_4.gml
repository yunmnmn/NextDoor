enum WomenScaryAnimationState
{
	Looping,
	NoticeMimi,
}

m_switchAvatarAnimationCount = 50;

m_dirty = false;

m_womenAnimationState = WomenScaryAnimationState.Looping;

function NoticesMimi()
{
	BackToMimi = function()
	{
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
		
		SetGlobalGameState(GlobalGameStates.MimiIsShocked);
		instance_peepholeTrigger.MimiIsSpooked();
	}
	
	PlayTurnAvatar = function()
	{
		// Freeze at the last turn animation
		FreezeAnimationAtEnd2(anim_womenTurn);
		
		if(GetTextboxInstance() != noone)
		{
			GetTextboxInstance().Reset();
		}
	
		var c19_3 = new TextContext(anim_womanTurnAvatar, false, noone);
		c19_3.m_avatarYOffset = - 16;
		c19_3.m_progressable = false;
		c19_3.AddSubText(new SubText("!", 0.6, true));
		c19_3.m_animationCallback = BackToMimi;
		RenderText(c19_3);
		
		// Rumble the controller when Women turns
		Rumble(0.9, 200);
	}
	
	PlayTurnAnimation = function()
	{
		// Play the turn of the avatar when this is done
		PlayAnimation2(anim_womenTurn, PlayTurnAvatar);
	}
	
	PlayAnimation2(anim_womenScrew, PlayTurnAnimation);
	m_womenAnimationState = WomenScaryAnimationState.NoticeMimi;
	
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
		
	var c19_1 = new TextContext(sprite_womenScrewAvatar, false, noone);
	c19_1.m_progressable = false;
	c19_1.AddSubText(new SubText("...", 0.2, true));
	RenderText(c19_1);
}

// -------------------------- Sounds --------------------------

// Set the sound for the women screwing
var womenScrews = new SoundContext(foley_womenScrews, anim_womenScrew, 3);
womenScrews.SetPersistent(false);
AddSoundContext(womenScrews);

// Set the sound for the women looking
var womenLooks = new SoundContext(foley_womenLook, anim_womenLook, 1);
womenLooks.SetPersistent(false);
AddSoundContext(womenLooks);

// Set the sound for the women looking
var womenScrews = new SoundContext(foley_womenLimbsExtend, anim_womenScrew, 52);
womenScrews.SetPersistent(false);
AddSoundContext(womenScrews);
