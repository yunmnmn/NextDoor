if(keyboard_check(vk_space) && m_dirtyFlag == false)
{
	m_dirtyFlag = true;
	// TODO: remove the extra node from the HallwayUp path
	var doorTriggerIndex = instance_find(object_doorKnockYoungsterTrigger, 0);
	knockPositionX = doorTriggerIndex.x;
	
	m_youngster = instance_find(object_youngster, 0);
	
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
			
			// TODO: set the door open sprite visible
			// TODO: set the youngster sprite visible
			m_youngster.visible = true;
			instance_find(object_openDoor, 0).visible = true;

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
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
		
		PlayerPlayAnimation(sprite_mimiIdle, noone);
		
		// Set the youngster back to idle
		var animationEndCallback = function()
		{
			m_youngster.PlayAnimation(sprite_youngsterIdle, noone);
			m_youngster.image_speed = 1;
		};
		// Reverse the youngster point
		m_youngster.PlayAnimation(anim_youngsterPoint, animationEndCallback);
		m_youngster.image_index = 7;
		m_youngster.image_speed = -1;
		
		// Set the player image speed back
		player.image_speed = 1;
	}
	
	cb2_10 = function()
	{
		var c2_10 = new TextContext(sprite_mimiAvatarAngry, conversationFinished);
		c2_10.AddSubText(new SubText("Watch me! You wait right here!", 0.2));
		RenderText(c2_10);
	}
	
	cb2_9 = function()
	{
		var c2_9 = new TextContext(sprite_youngsterAvatarSmirk, cb2_10);
		c2_9.AddSubText(new SubText("If the neighbour says it's too loud, I'll think about it.", 0.2));
		RenderText(c2_9);
	}
	
	cb2_8 = function()
	{
		var c2_8 = new TextContext(sprite_youngsterAvatarNormal, cb2_9);
		c2_8.AddSubText(new SubText("Maybe you're just too uptight.", 0.2));
		RenderText(c2_8);
		
		var animationEndCallback = function()
		{
			m_youngster.image_speed = 0;
			m_youngster.image_index = 7;
		};
		m_youngster.PlayAnimation(anim_youngsterPoint, animationEndCallback);
	}
	
	cb2_7 = function()
	{
		var c2_7 = new TextContext(sprite_mimiAvatarAngry, cb2_8);
		c2_7.AddSubText(new SubText("You're disturbing the peace!", 0.2));
		RenderText(c2_7);
	}
	
	cb2_6 = function()
	{
		var c2_6 = new TextContext(sprite_mimiAvatarAngry, cb2_7);
		c2_6.AddSubText(new SubText("Yes it is!", 0.2));
		RenderText(c2_6);
		
		// Play the angry animation
		var callbackAngryEnd = function()
		{
			// Only set the imgae speed to 0 if the angry animation is still set
			var player = GetPlayerInstance();
			if(player.sprite_index == anim_mimiAngry)
			{
				player.image_speed = 0;
				player.image_index = 4;
			}
		}
		PlayerPlayAnimation(anim_mimiAngry, callbackAngryEnd);
	}
	
	cb2_5 = function()
	{
		var c2_5 = new TextContext(sprite_youngsterAvatarNormal, cb2_6);
		c2_5.AddSubText(new SubText("I don't think it's so loud.", 0.2));
		RenderText(c2_5);
	}
	
	cb2_4 = function()
	{
		var c2_4 = new TextContext(sprite_youngsterAvatarNormal, cb2_5);
		c2_4.AddSubText(new SubText("I do?", 0.2));
		RenderText(c2_4);
	}
	
	cb2_3 = function()
	{
		var c2_3 = new TextContext(sprite_mimiAvatarAngry, cb2_4);
		c2_3.AddSubText(new SubText("You always have it unbearably loud!", 0.2));
		RenderText(c2_3);
	}
	
	cb2_2 = function()
	{
		var c2_2 = new TextContext(sprite_mimiAvatarAngry, cb2_3);
		c2_2.AddSubText(new SubText("Could you please lower the volume?!", 0.2));
		RenderText(c2_2);
	}

	// Start of the conversation. Doesn't require a function
	var c2_1 = new TextContext(sprite_mimiAvatarAngry, cb2_2);
	c2_1.AddSubText(new SubText("Hello?!", 0.2));

	// Call the parent text context
	if(RenderText(c2_1))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
	}
}