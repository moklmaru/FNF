local daPixelZoom = 6
function onCreate()
	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-pixel-dead')
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pixel')
	
	
	posX = 400
	posY = 200
	
	if not lowQuality then
		makeAnimatedLuaSprite('ulin', 'weeb/animatedEvilSchool', posX * -2.25, posY * -5.3)
		addAnimationByPrefix('ulin', 'ulin', 'background 2', 24, true)
		makeAnimatedLuaSprite('bgGhouls', 'weeb/bgGhouls', -100, 190)
		setScrollFactor('bgGhouls', 0.9, 0.9)
		addAnimationByPrefix('bgGhouls', 'bgGhouls', 'BG freaks glitch instance', 24, false)
		setGraphicSize('bgGhouls', getProperty('bgGhouls.width') * daPixelZoom)
		updateHitbox('bgGhouls')
		setProperty('bgGhouls.visible', false)
		setProperty('bgGhouls.antialiasing', false)
	else
		makeLuaSprite('ulin', 'weeb/animatedEvilSchool_low', posX, posY)
	end
	setScrollFactor('ulin', 0.8, 0.9)
	scaleObject('ulin', 6, 6)
	setProperty('bg.antialiasing', false)
	
	addLuaSprite('ulin', false)
	addLuaSprite('bgGhouls', false)
	
	runTimer('timerTrailDad', trailDelay, 0)
	
end

function onEvent(n)
	if n == 'Trigger BG Ghouls' then
		if not lowQuality then
			objectPlayAnimation('bgGhouls', 'bgGhouls', true)
			setProperty('bgGhouls.visible', true)
		end
	end
end


function onUpdate(e)
	if not lowQuality and getProperty('bgGhouls.animation.curAnim.finished') then
		setProperty('bgGhouls.visible', false)
	end
end

trailLength = 4
trailDelay = 0.069

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'timerTrailDad' then
		createTrailFrame('Dad')
	end
end

curTrailDad = 0
curTrailBF = 0
function createTrailFrame(tag)
	num = 0
	color = -1
	image = ''
	frame = 'BF idle dance'
	x = 0
	y = 0
	scaleX = 0
	scaleY = 0
	offsetX = 0
	offsetY = 0
	
	num = curTrailDad
	curTrailDad = curTrailDad + 1
	
	color = getColorFromHex('FFFFFF')
	image = getProperty('dad.imageFile')
	frame = getProperty('dad.animation.frameName')
	x = getProperty('dad.x')
	y = getProperty('dad.y')
	scaleX = getProperty('dad.scale.x')
	scaleY = getProperty('dad.scale.y')
	offsetX = getProperty('dad.offset.x')
	offsetY = getProperty('dad.offset.y')

	if num - trailLength + 1 >= 0 then
		for i = (num - trailLength + 1), (num - 1) do
			setProperty('psychicTrail'..tag..i..'.alpha', getProperty('psychicTrail'..tag..i..'.alpha') - (0.3 / (trailLength - 0.069)))
		end
	end
	removeLuaSprite('psychicTrail'..tag..(num - trailLength))

	if not (image == '') then
		trailTag = 'psychicTrail'..tag..num
		makeAnimatedLuaSprite(trailTag, image, x, y)
		setProperty(trailTag..'.offset.x', offsetX)
		setProperty(trailTag..'.offset.y', offsetY)
		setProperty(trailTag..'.scale.x', scaleX)
		setProperty(trailTag..'.scale.y', scaleY)
		setProperty(trailTag..'.alpha', 0.3)
		setProperty(trailTag..'.color', color)
		setBlendMode(trailTag, 'add')
		addAnimationByPrefix(trailTag, 'stuff', frame, 0, false)
		setObjectOrder(trailTag, getObjectOrder('dadGroup'))
		addLuaSprite(trailTag, false)
	end
end
function onBeatHit()
	if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 4 == 0 and curStep >=1 then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	end
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
	  triggerEvent('Camera Follow Pos', '620', '560')
	  setProperty("defaultCamZoom",0.85)
	elseif value == 'b' then
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
	  triggerEvent('Camera Follow Pos', '630', '480')
	elseif value == 'bf' then
		triggerEvent('Camera Follow Pos', '859', '539')
	end
  end
