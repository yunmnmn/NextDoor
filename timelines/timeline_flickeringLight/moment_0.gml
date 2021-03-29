instance_outsideMemory.SetLampOutsideNearStairsVisible(true);

// Change the sprite of the youngster
instance_youngsterOutside.PlayAnimation2(sprite_youngsterCornerIdle, noone);

// Play the lamp on sound
PlaySound(foley_outsideLampOn, 10, false);