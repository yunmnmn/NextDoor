instance_outsideMemory.SetLampOutsideNearDoorVisible(true);

// Set the women behind to a visible sprite
instance_womenOutside.PlayAnimation2(sprite_womenIdleTall, noone);

// Play the lamp on sound
PlaySound(foley_outsideLampOn, 10, false);