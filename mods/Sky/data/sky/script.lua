function onCreate()
	if isStoryMode then
		makeLuaSprite('black', nil, 0, 0)
		makeGraphic('black', screenWidth * 2, screenHeight * 2, '000000');
		screenCenter('black')

		makeLuaSprite('white', nil, 0, 0)
		makeGraphic('white', screenWidth * 2, screenHeight * 2, 'FFFFFF');
		screenCenter('white')
		setProperty('white.alpha', 0)
		addLuaSprite('white', true)
	end
	makeAnimatedLuaSprite('bg', 'bg/bg_annoyed', -370, -100)
	scaleObject('bg', 1.1, 1)
	addAnimationByPrefix('bg', 'anim', 'bg2', 24, false)
	addAnimationByPrefix('bg', 'boom', 'bgBOOM', 24, false)

	makeAnimatedLuaSprite('bg2', 'bg/bg_annoyed', -670, -100)
	scaleObject('bg2', 1.1, 1)
	addAnimationByPrefix('bg2', 'anim', 'bg2', 24, false)
	addAnimationByPrefix('bg2', 'boom', 'bgBOOM', 24, false)

	addLuaSprite('bg2', false)
	addLuaSprite('bg', false)
end

local allowCountdown = false
local stops = 0;
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
        
		setProperty('inCutscene', true);

    if stops == 0 then
        characterPlayAnim('dad', 'oh', true)
        addLuaSprite('black', true)
        doTweenAlpha('lessgo', 'black', 0, 1.2, 'linear')
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)
        runTimer('dialogue1', 1.8)
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

local ends = 0
function onEndSong()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowEnd and isStoryMode then
        
		setProperty('inCutscene', true);

    if ends == 0 then 
	for i = 0,7 do
		setStrumVisibilty(i,false)
	end
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)
        runTimer('dialogue2', 1.3)
    end

    if ends == 1 then
        doTweenX('wazaaX', 'camFollowPos', 430, 1, 'smoothStepInOut')
        doTweenY('wazaaY', 'camFollowPos', 500, 1, 'smoothStepInOut')
        runTimer('berzerk', 1)
    end
        ends = ends + 1
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag)
	if tag == 'dialogue1' then
		triggerEvent('startDialogue', 'dialogue', '');
	end
	if tag == 'dialogue2' then
		triggerEvent('startDialogue', 'dialogue2', '');
	end
	if tag == 'berzerk' then
		runTimer('BOOM', 0.9)
		playSound('manifest', 1)
		characterPlayAnim('dad', 'devil', true)
		doTweenZoom('screenZoom', 'camGame', 1.6, 0.5, 'linear');
	end
	if tag == 'BOOM' then
		removeLuaSprite('bg2', true)
		doTweenZoom('screenZoom', 'camGame', 0.8, 2.7, 'linear');
		setProperty('boyfriend.visible', false)
		setObjectOrder('bg', getObjectOrder('gfGroup'))
		cameraShake('game', 0.05, 3)
		objectPlayAnimation('bg', 'boom', true)
		doTweenAlpha('white-screen', 'white', 1, 2.8, 'linear')
		runTimer('peak', 3.8)
	end
	if tag == 'peak' then
		doTweenAlpha('white-screen', 'white', 0, 0.1, 'linear')
		doTweenZoom('screenZoom-zoop', 'camGame', 1.5, 0.1, 'quadInOut');
	end
end	

function onTweenCompleted(tag)
	if tag == 'lessgo' then
		removeLuaSprite('black', true)
	end
	if tag == 'screenZoom-zoop' then
		allowEnd = true;
		endSong()
	end
end

function onBeatHit()
	if curBeat % 4 == 2 then
		objectPlayAnimation('bg', 'anim', true)
	end
end

-- Code from VS Whitty go check them out --

function setStrumVisibilty(v1,vis)
		strum = v1
		strumset = 'opponentStrums'

		if strum > 3 then
			strumset = 'playerStrums'
		end
		
		strum = v1 % 4

		setPropertyFromGroup(strumset,strum,'visible',vis)
end