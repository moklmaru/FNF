local allowCountdown = false

function onStartCountdown()
if isStoryMode and not allowCountdown then
 startVideo('2hotCutscene');
 allowCountdown = true;
 return Function_Stop;
 end
 return Function_Continue;
 end