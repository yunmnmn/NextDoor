if(keyboard_check(vk_space) && m_dirtyFlag == false)
{
	m_dirtyFlag = true;
	// TODO: remove the extra node from the HallwayUp path
	var doorTriggerIndex = instance_find(object_doorKnockWomenTrigger, 0);
	knockPositionX = doorTriggerIndex.x;
	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to a fixed position
	player = GetPlayerInstance();
	var position = SnapToClosestPosition(knockPositionX, player.y);
	player.m_position = position;
	
	// Play the knocking animation, and set the callback when the animation is finished
	{
		// When the knocking animation is finished, execute this callback
		var animationEndCallback = function()
		{
			PlayerPlayAnimation(sprite_mimiIdle, noone);
			// HACK: slightly move mimi to the right when she finishes, so the knock -> idle matches
			var position = SnapToClosestPosition(knockPositionX - 60, player.y);
			player.m_position = position;

			MimiAndYoungsterConversation();
		}

		// Play the knocking animation
		PlayerPlayAnimation(anim_mimiKnock, animationEndCallback);
	}
}

function MimiAndYoungsterConversation()
{
	conversationFinished = function()
	{
		// Disable the control the player has
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	cb2_10 = function()
	{
		var c2_10 = new TextContext(sprite_youngsterAvatarNormal, conversationFinished);
		c2_10.AddSubText(new SubText("Sometimes I hear the door opening and closing", 0.2));
		RenderText(c2_10);
	}
	
	cb2_9 = function()
	{
		var c2_9 = new TextContext(sprite_youngsterAvatarNormal, cb2_10);
		c2_9.AddSubText(new SubText("I don't think it's empty", 0.2));
		RenderText(c2_9);
	}
	
	cb2_8 = function()
	{
		var c2_8 = new TextContext(sprite_mimiAvatarAngry, cb2_9);
		c2_8.AddSubText(new SubText("Ofcourse they don't complain, if nobody lives there!", 0.2));
		RenderText(c2_8);
	}
	
	cb2_7 = function()
	{
		var c2_7 = new TextContext(sprite_mimiAvatarTroubled, cb2_8);
		c2_7.AddSubText(new SubText("You sure it's not just an empty room?", 0.2));
		RenderText(c2_7);
	}
	
	cb2_6 = function()
	{
		var c2_6 = new TextContext(sprite_mimiAvatarTroubled, cb2_7);
		c2_6.AddSubText(new SubText("Away?!", 0.2));
		RenderText(c2_6);
	}
	
	cb2_5 = function()
	{
		var c2_5 = new TextContext(sprite_youngsterAvatarSmirk, cb2_6);
		c2_5.AddSubText(new SubText("That neighbour seems to be away a lot", 0.2));
		RenderText(c2_5);
	}
	
	cb2_4 = function()
	{
		var c2_4 = new TextContext(sprite_youngsterAvatarNormal, cb2_5);
		c2_4.AddSubText(new SubText("Probably not home", 0.2));
		RenderText(c2_4);
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, cb2_4);
		c2_3.AddSubText(new SubText("Anybody there?", 0.2));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, cb2_3);
		c2_2.AddSubText(new SubText("Are you home?!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarAngry, cb2_2);
	c2_1.AddSubText(new SubText("Excuse me! ", 0.2));

	// Call the parent text context
	if(RenderText(c2_1))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
	}
}