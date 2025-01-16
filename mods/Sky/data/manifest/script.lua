function onCreate()
	if isStoryMode then
		makeLuaSprite('black', nil, 0, 0)
		makeGraphic('black', screenWidth * 2, screenHeight * 2, '000000');
		screenCenter('black')
	end
end

local allowCountdown = false
local stops = 0;
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
        
		setProperty('inCutscene', true);

    if stops == 0 then
        triggerEvent('dialogue.setSkin', 'manifest', '');
        addLuaSprite('black', true)
        doTweenAlpha('lessgo', 'black', 0, 2, 'linear')
	doTweenZoom('screenZoom', 'camGame', 3.2, 0.000001, 'quadInOut');
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)

        setProperty('camFollowPos.x', 630)
        setProperty('camFollowPos.y', 270)
        runTimer('dezoom', 3.4)
    end

    if stops == 1 then

        setProperty('healthBar.visible', true)
        setProperty('healthBarBG.visible', true)
        setProperty('iconP1.visible', true)
        setProperty('iconP2.visible', true)
        setProperty('scoreTxt.visible', true)
        allowCountdown = true;
        startCountdown()
    end
        stops = stops + 1
		return Function_Stop;
	end
	return Function_Continue;
end



function onTimerCompleted(tag)
	if tag == 'dezoom' then
		doTweenZoom('screenZoom', 'camGame', 0.85, 1.7, 'quadInOut');
		doTweenY('wazaaa', 'camFollowPos', 460, 1.5, 'smoothStepInOut')
		runTimer('dial1', 2)
	end
	if tag == 'dial1' then
		triggerEvent('startDialogue', 'dialogue', '');
	end
end	

function onTweenCompleted(tag)
	if tag == 'lessgo' then
		removeLuaSprite('black', true)
	end
end