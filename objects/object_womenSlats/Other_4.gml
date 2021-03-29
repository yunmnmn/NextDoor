// Start invisible and disabled
visible = false;
image_speed = 0;

// -------------------------- Sounds --------------------------

// Set the sound for the women screwing
var womenSlatsSoundContext = new SoundContext(foley_womenHole, anim_womenSlats, 1);
womenSlatsSoundContext.SetPersistent(false);
AddSoundContext(womenSlatsSoundContext);
