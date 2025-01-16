function onCreate()
    local skyX, skyY = 580, 1100
    local flashingX, flashingY = 1000, 1000
    local streetX, streetY = 580, 1100
    local rainX, rainY = -200, 150
    local introX, introY = 90, 645
    local scaleValue = 0.95
    local rainScale = 2
    local introWidth, introHeight = 3000, 2001
    local introAlpha = 0.2
	createInstance('Sky', 'flixel.addons.display.FlxBackdrop', {nil, axis})
	loadGraphic('Sky', 'phillyStreets/phillyBlazin/skyBlur')
	addInstance('Sky')
	setProperty('Sky.velocity.x',-100)
	setProperty('Sky.y',-200)

    makeLuaSprite('skyBackground', 'phillyStreets/phillyBlazin/skyBlur', skyX, skyY)
    scaleObject('skyBackground', scaleValue, scaleValue)

    makeAnimatedLuaSprite('flashingLightning', 'phillyStreets/phillyBlazin/lightning', flashingX, flashingY)
    addAnimationByPrefix('flashingLightning', 'flash', 'lightning', 24, false)
    scaleObject('flashingLightning', scaleValue, scaleValue)
    objectPlayAnimation('flashingLightning', 'flash', true)

    makeLuaSprite('streetForeground', 'phillyStreets/phillyBlazin/streetBlur', streetX, streetY)
    scaleObject('streetForeground', scaleValue, scaleValue)

    addLuaSprite('flashingLightning', true)
    addLuaSprite('streetForeground', false)

    makeLuaSprite('introOverlay', '', introX, introY)
    makeGraphic('introOverlay', introWidth, introHeight, '000000')
    addLuaSprite('introOverlay', true)
    setProperty('introOverlay.alpha', introAlpha)

    cameraFlash('other', '000000', 2)
end


local sounds = {'Lightning1', 'Lightning2', 'Lightning3'}

function onBeatHit()
    if curBeat % 27 == 0 then
        local randomSound = sounds[math.random(#sounds)]
        local randomX = math.random(950, 1500)

        playSound(randomSound, 2)
        cameraFlash('camGame', 'FFFFFF', 0.75)
        playAnim('flashingLightning', 'flash', true)
        setProperty('flashingLightning.x', randomX)
    end
end

local allowCountdown = false

function onEndSong()
    if isStoryMode and not seenCutscene then
        function onBeatHit()end
        startVideo('blazinCutscene')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
function onUpdate()
	if isStoryMode then

end
end