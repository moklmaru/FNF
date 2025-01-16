
zoom1=false
zoom2=false
function onEvent(eventName, v1)
	if eventName == 'Screen Shake' then
	  handleScreenShake(v1)
	elseif eventName == 'Set GF Speed' then
	  handleSetGFSpeed(v1)
	end
  end
  
  function handleScreenShake(value)
	if value == '1' then
	  zoom1 = true
	  zoom2 = false
	elseif value == '2' then
	  zoom1 = false
	  zoom2 = true
	elseif value == '3' then
	  zoom1 = false
	  zoom2 = false
	end
  end
  
  function handleSetGFSpeed(value)
	if value == 'g' then
	  triggerEvent('Camera Follow Pos', '700', '510')
	elseif value == 'b' then
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
	  triggerEvent('Camera Follow Pos', '630', '480')
	elseif value == 'bf' then
	  triggerEvent('Camera Follow Pos', '750', '480')
	end
  end
  
function onCreate()


	makeAnimatedLuaSprite('halloweenBG', 'spooky-erect/bgtrees', 200, 50)
	addAnimationByPrefix('halloweenBG', 'idle', 'bgtrees0', 6, true)
	scaleObject('halloweenBG',1,1)
	addLuaSprite('halloweenBG', false)

	makeLuaSprite('hola', 'spooky-erect/bgDark', -400, -200)
	scaleObject('hola',1,1)
	addLuaSprite('hola', false)
	
	makeLuaSprite('bgLight', 'spooky-erect/bgLight', -400, -200)
	scaleObject('bgLight',1,1)
	addLuaSprite('bgLight', false)
setProperty('bgLight.alpha',0)


makeLuaSprite('stairsDark', 'spooky-erect/stairsDark', 950, -150)
scaleObject('stairsDark',1,1)
addLuaSprite('stairsDark', true)

makeLuaSprite('stairsLight', 'spooky-erect/stairsLight', 950, -150)
scaleObject('stairsLight',1,1)
addLuaSprite('stairsLight', true)
setProperty('stairsLight.alpha',0)

	        makeFlxAnimateSprite("abot2", 354,412, "characters/abot/dark/abotSystem")
            loadAnimateAtlas("abot2", "characters/abot/dark/abotSystem")
            addAnimationBySymbol("abot2","lomatan", "Abot System", 24, true)
            addLuaSprite("abot2",false) 

			makeFlxAnimateSprite("abotEffect", 354,412, "abot/abotEffect")
            loadAnimateAtlas("abotEffect", "abot/abotEffect")
            addAnimationBySymbol("abotEffect","lomatan", "Abot System", 24, true)
            addLuaSprite("abotEffect",true) 
            setProperty('abotEffect.alpha',0.3)
	setBlendMode('halloweenBG', 'add')
	precacheSound('thunder_1')
	precacheSound('thunder_2')
end
skibidiULISEGAS=false
h=0
function onUpdate()
	if not skibidiULISEGAS then

		setProperty('abot.color', getColorFromHex('a0a0a0'))

		setObjectOrder('abot2',getObjectOrder('abot')+1)
setObjectOrder('abof',getObjectOrder('abot')-1)
setObjectOrder('abotEffect',getObjectOrder('abot')+1)
else

end
end
local lightningStrikeBeat = 0
local lightningOffset = 8

function onBeatHit()
    if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 4 == 0 and curStep >=63 and songName == 'Spookeez Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	  if curBeat % 4 == 0 and curStep >=127 and songName == 'South Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	if getRandomBool(10) and curBeat > lightningStrikeBeat + lightningOffset then
		if stringStartsWith(getProperty('boyfriend.animation.name'), 'sing') or getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		triggerLightningStrike()
	end
end
end
function onTimerCompleted(tag)
if tag == 'blackt' then
	cameraFlash('camGame','000000',0.05)
setProperty('camGame.alpha',0.8)
runTimer('blackt2',0.05)
end
if tag == 'blackt2' then
	setProperty('camGame.alpha',1)
	runTimer('blackt3',0.05)
end
if tag == 'blackt3' then
	cameraFlash('camGame','000000',0.05)
	setProperty('camGame.alpha',0.8)
	runTimer('blackt4',0.05)
end
if tag == 'blackt4' then
	setProperty('camGame.alpha',1)
end
end
function triggerLightningStrike()
	if songName == "South (Pico Mix)" then
		if curStep < 930 or curStep > 988 then
	runTimer('blackt',0.05)
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
	local soundName = string.format('thunder_%i', getRandomInt(1, 2))
	playSound(soundName, 1, 'thundah')
    triggerEvent('Play Animation','scared','GF')
	playAnim('boyfriend', 'scared')
	
	if cameraZoomOnBeat then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
		
		if not getProperty('camZooming') then
			doTweenZoom('cG', 'camGame', getProperty('defaultCamZoom'), 0.5, 'linear')
			doTweenZoom('cH', 'camHUD', 1, 0.5, 'linear')
		end
	end
	
	doTweenAlpha('hWA', 'bgLight', 1, 0.075, 'linear')
	doTweenAlpha('hWA2', 'stairsLight', 1, 0.075, 'linear')

	doTweenAlpha('spooky', 'spooky', 1, 0.075, 'linear')
	doTweenAlpha('nene', 'nene', 1, 0.075, 'linear')
	doTweenAlpha('pico-mix', 'pico-mix', 1, 0.075, 'linear')
--
doTweenAlpha('dad', 'dad', 0.25, 0.075, 'linear')
doTweenAlpha('boyfriend', 'boyfriend', 0, 0.075, 'linear')
--
	doTweenAlpha('abotEffect', 'abotEffect', 0.01, 0.1, 'linear')
	doTweenAlpha('abot', 'abot', 0.01, 0.075, 'linear')
	doTweenAlpha('abot2', 'abot2', 0.01, 0.075, 'linear')

	doTweenColor('asd','stereoBG','ffffff',0.075)
	skibidiULISEGAS=true
end
else
	runTimer('blackt',0.05)
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
	local soundName = string.format('thunder_%i', getRandomInt(1, 2))
	playSound(soundName, 1, 'thundah')
    triggerEvent('Play Animation','scared','GF')
	playAnim('boyfriend', 'scared')
	
	if cameraZoomOnBeat then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
		
		if not getProperty('camZooming') then
			doTweenZoom('cG', 'camGame', getProperty('defaultCamZoom'), 0.5, 'linear')
			doTweenZoom('cH', 'camHUD', 1, 0.5, 'linear')
		end
	end
	
	doTweenAlpha('hWA', 'bgLight', 1, 0.075, 'linear')
	doTweenAlpha('hWA2', 'stairsLight', 1, 0.075, 'linear')

	doTweenAlpha('spooky', 'spooky', 1, 0.075, 'linear')
	doTweenAlpha('nene', 'nene', 1, 0.075, 'linear')
	doTweenAlpha('pico-mix', 'pico-mix', 1, 0.075, 'linear')
--
doTweenAlpha('dad', 'dad', 0, 0.075, 'linear')
doTweenAlpha('boyfriend', 'boyfriend', 0, 0.075, 'linear')
--
	doTweenAlpha('abotEffect', 'abotEffect', 0.01, 0.1, 'linear')
	doTweenAlpha('abot', 'abot', 0.01, 0.075, 'linear')
	doTweenAlpha('abot2', 'abot2', 0.01, 0.075, 'linear')

	doTweenColor('asd','stereoBG','ffffff',0.075)
	skibidiULISEGAS=true
end
end
function onTweenCompleted(tween)
	if tween == 'hWA' then
		doTweenAlpha('dad', 'dad', 1, 1.5, 'linear')
doTweenAlpha('boyfriend', 'boyfriend', 1, 2, 'linear')

		doTweenAlpha('hWA2', 'stairsLight', 0, 2, 'linear')
		doTweenAlpha('hWA0', 'bgLight', 0, 2, 'linear')
		doTweenAlpha('abotEffect2', 'abotEffect', 0.3,4, 'linear')
		doTweenAlpha('spooky', 'spooky',0, 2, 'linear')
		doTweenAlpha('nene', 'nene',0, 2, 'linear')
		doTweenAlpha('pico-mix', 'pico-mix',0, 2, 'linear')
		doTweenAlpha('abot', 'abot', 1,5, 'linear')
		doTweenAlpha('abot2', 'abot2', 1, 2, 'linear')

		doTweenColor('asd','stereoBG','596274',2)
		skibidiULISEGAS=false
	end
end