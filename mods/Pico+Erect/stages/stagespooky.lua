
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

		makeAnimatedLuaSprite('halloweenBG', 'halloween_bg', -200, -100)
		addAnimationByPrefix('halloweenBG', 'idle', 'halloweem bg0', 24, false)
		addAnimationByPrefix('halloweenBG', 'thunder', 'halloweem bg lightning strike', 24, false)
		scaleObject('halloweenBG',1,1)
		setBlendMode('halloweenBG', 'add')

		makeLuaSprite('halloweenWhite', nil, -300, -350)
		setScrollFactor('halloweenWhite', 0, 0)
		makeGraphic('halloweenWhite', screenWidth * 3, screenHeight * 3, 'FFFFFF')
		setProperty('halloweenWhite.alpha', 0)
		setBlendMode('halloweenWhite', 'add')
	
	addLuaSprite('halloweenBG', false)
	addLuaSprite('halloweenWhite', true)
	setBlendMode('halloweenBG', 'add')
	precacheSound('thunder_1')
	precacheSound('thunder_2')


    makeLuaSprite('INTRO2', '', -590, 900-4)
    luaSpriteMakeGraphic('INTRO2', 3000, 2001, 'FFFFFF')
    addLuaSprite('INTRO2', false)
	setBlendMode('INTRO2', 'add')
	setProperty('INTRO2.alpha', 0.1)
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
		triggerLightningStrike()
	end
end

function triggerLightningStrike()
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
		objectPlayAnimation('halloweenBG', 'thunder')
	local soundName = string.format('thunder_%i', getRandomInt(1, 2))
	playSound(soundName, 1, 'thundah')
    triggerEvent('Play Animation','scared','GF')
	characterPlayAnim('boyfriend', 'scared')
	
	if cameraZoomOnBeat then
		setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
		
		if not getProperty('camZooming') then
			doTweenZoom('cG', 'camGame', getProperty('defaultCamZoom'), 0.5, 'linear')
			doTweenZoom('cH', 'camHUD', 1, 0.5, 'linear')
		end
	end
	
		setProperty('halloweenWhite.alpha', 0.4)
		doTweenAlpha('hWA', 'halloweenWhite', 0.5, 0.075, 'linear')
	
end

function onTweenCompleted(tween)
	if tween == 'hWA' then
		doTweenAlpha('hWA0', 'halloweenWhite', 0, 0.25, 'linear')
	end
end