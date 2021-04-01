instance_splash.visible = false;
instance_disclaimer.visible = false;

m_currentFrame = 0;
m_warmupFrames = 30;

m_dirty = false;

// HACK: pre-load all the musics, so they play immediately on the browser when needed
var sound1 = PlaySound(GetMetal(), 1.0, false);
SoundGain(sound1, 0.0, 0.0);
StopSound(sound1);

var sound2 = PlaySound(GetMetalMimiRoom(), 1.0, false);
SoundGain(sound2, 0.0, 0.0);
StopSound(sound2);

var sound3 = PlaySound(GetMetalHallway(), 1.0, false);
SoundGain(sound3, 0.0, 0.0);
StopSound(sound3);

var sound4 = PlaySound(GetAmbientScary(), 1.0, false);
SoundGain(sound4, 0.0, 0.0);
StopSound(sound4);

var sound5 = PlaySound(GetAmbientScary(), 1.0, false);
SoundGain(sound5, 0.0, 0.0);
StopSound(sound5);

var sound6 = PlaySound(GetCicade(), 1.0, false);
SoundGain(sound6, 0.0, 0.0);
StopSound(sound6);

var sound7 = PlaySound(GetChase(), 1.0, false);
SoundGain(sound7, 0.0, 0.0);
StopSound(sound7);