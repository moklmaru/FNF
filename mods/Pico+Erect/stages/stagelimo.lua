function onCreate()
	makeLuaSprite('skyBG', 'limo/erect/limoSunset', -220, -80)
	setScrollFactor('skyBG', 0.1, 0.1)
	
	makeAnimatedLuaSprite('bgLimo', 'limo/erect/bgLimo', -150, 480)
	addAnimationByPrefix('bgLimo', 'drive', 'background limo blue', 24, true)
	setScrollFactor('bgLimo', 0.4, 0.4)
	
	if not lowQuality then -- sprites that only load if lowQuality's off
		makeLuaSprite('limoMetalPole', 'gore/metalPole', -500, 220)
		setScrollFactor('limoMetalPole', 0.4, 0.4);
		
		makeAnimatedLuaSprite('bgLimo', 'limo/erect/bgLimo', -150, 480)
		addAnimationByPrefix('bgLimo', 'drive', 'background limo blue', 24, true)
		setScrollFactor('bgLimo', 0.4, 0.4)
		
		makeAnimatedLuaSprite('limoCorpse', 'gore/noooooo', -500, getProperty('limoMetalPole.y') - 130)
		makeAnimatedLuaSprite('limoCorpseTwo', 'gore/noooooo', -500, getProperty('limoMetalPole.y') - 130)
		addAnimationByPrefix('limoCorpse', 'die', 'Henchman on rail', 24, true)
		addAnimationByPrefix('limoCorpseTwo', 'die', 'henchmen death', 24, true)
		setScrollFactor('limoCorpse', 0.4, 0.4)
		
		for i = 0, 5 do
			makeAnimatedLuaSprite('dancers-'..i, 'limo/limoDancer', 370 * i + 130, getProperty('bgLimo.y') - 400)
			setScrollFactor('dancers-'..i, 0.4, 0.4)
			addAnimationByIndices('dancers-'..i, 'danceLeft', 'bg dancer sketch PINK', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14', 24)
			addAnimationByIndices('dancers-'..i, 'danceRight', 'bg dancer sketch PINK', '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29', 24)
			playAnim('dancers-'..i, 'danceLeft', true)
			setProperty('dancers-'..i..'.x', (370 * i) + getProperty('bgLimo.x') + 280)
		end
		
		makeLuaSprite('limoLight', 'gore/coldHeartKiller', getProperty('limoMetalPole.x') - 180, getProperty('limoMetalPole.y') - 80)
		setScrollFactor('limoLight', 0.4, 0.4)
		
		makeAnimatedLuaSprite('particle0', 'gore/stupidBlood', -400, -400)
		addAnimationByPrefix('particle0', 'b', 'blood', 24, false)
		setProperty('particle0.alpha', 0.01)
		resetLimoKill()
		
		precacheSound('dancerdeath')
	end
	
	makeAnimatedLuaSprite('limo', 'limo/erect/limoDrive', -120, 550)
	addAnimationByPrefix('limo', 'drive', 'Limo stage', 24, true)
	
	makeLuaSprite('fastCar', 'limo/fastCarLol', -300, 160)
	setProperty('fastCar.active', true)
	limoKillingState = 0
	
	addLuaSprite('skyBG', false)
	addLuaSprite('limoMetalPole', false)
	addLuaSprite('bgLimo', false)
	makeAnimatedLuaSprite('shooting star', 'limo/erect/shooting star', 450, 0)
	addAnimationByPrefix('shooting star', 'drive', 'shooting star', 24, false)
	setScrollFactor('shooting star', 0.4, 0.4)
	addLuaSprite('shooting star',false)

	addLuaSprite('limoCorpse', false)
	addLuaSprite('limoCorpseTwo', false)
	for i = 0, 5 do
		addLuaSprite('dancers-'..i, false)
	end
	addLuaSprite('dancers-0', false)
	addLuaSprite('limoLight', false)
	addLuaSprite('limo', false)
	addLuaSprite('fastCar', false)
	addLuaSprite('particle0', false)
	
	setObjectOrder('limo', getObjectOrder('gfGroup'))
	setObjectOrder('fastCar', getObjectOrder('gfGroup') - 1)
	resetFastCar()


	
end

local limoKillingState = 0
function onEvent(n, v1, v2)
	if n == 'Kill Henchmen' then
		killHenchmen()
	end
end
function onCreatePost()
	createInstance('Sky', 'flixel.addons.display.FlxBackdrop', {nil, axis})
	loadGraphic('Sky', 'limo/erect/mistBack')
	addInstance('Sky')
	setProperty('Sky.velocity.x',1700)
	setProperty('Sky.y',-100)
	setProperty('Sky.blend',0)
	setProperty('Sky.color', getColorFromHex('c6bfde'))

setObjectOrder('Sky',getObjectOrder('dadGroup')+5)

---------
createInstance('mist2', 'flixel.addons.display.FlxBackdrop', {nil, axis})
loadGraphic('mist2', 'limo/erect/mistBack')
addInstance('mist2')

setProperty('mist2.velocity.x', 2100)
setProperty('mist2.y', -100)
setProperty('mist2.blend', 0)
setProperty('mist2.color', getColorFromHex('6a4da1')) 
setProperty('mist2.alpha', 1)
setProperty('mist2.scrollFactor.x', 1.2)
setProperty('mist2.scrollFactor.y', 1.2)
setProperty('mist2.scale.x', 1.3)
setProperty('mist2.scale.y', 1.3)

createInstance('mist3', 'flixel.addons.display.FlxBackdrop', {nil, axis})
loadGraphic('mist3', 'limo/erect/mistMid')
addInstance('mist3')

setProperty('mist3.velocity.x', 900)
setProperty('mist3.y', -100)
setProperty('mist3.blend', 0)
setProperty('mist3.color', getColorFromHex('a7d9be')) 
setProperty('mist3.alpha', 0.5)
setProperty('mist3.scrollFactor.x', 0.8)
setProperty('mist3.scrollFactor.y', 0.8)
setProperty('mist3.scale.x', 1.5)
setProperty('mist3.scale.y', 1.5)

  end
local limoSpeed = 0
function onUpdate(elapsed)
	if getProperty('shooting star.curAnin.animation.finished') == true then
		removeLuaSprite('shooting star', false)
	end
	
	local hueValue = -30;
	local saturationValue = -20;
	local contrastValue = 0;
	local brightnessValue = -30;

	setSpriteShader('dad', 'adjustColor')
	setShaderFloat('dad', 'hue', hueValue)
	setShaderFloat('dad', 'saturation', saturationValue)
	setShaderFloat('dad', 'contrast', contrastValue)
	setShaderFloat('dad', 'brightness', brightnessValue)
	for i = 0, 5 do
	setSpriteShader('dancers-'..i, 'adjustColor')
	setShaderFloat('dancers-'..i, 'hue', hueValue)
	setShaderFloat('dancers-'..i, 'saturation', saturationValue)
	setShaderFloat('dancers-'..i, 'contrast', contrastValue)
	setShaderFloat('dancers-'..i, 'brightness', brightnessValue)
	end
	setSpriteShader('gf', 'adjustColor')
	setShaderFloat('gf', 'hue', hueValue)
	setShaderFloat('gf', 'saturation', saturationValue)
	setShaderFloat('gf', 'contrast', contrastValue)
	setShaderFloat('gf', 'brightness', brightnessValue)
	
	setSpriteShader('boyfriend', 'adjustColor')
	setShaderFloat('boyfriend', 'hue', hueValue)
	setShaderFloat('boyfriend', 'saturation', saturationValue)
	setShaderFloat('boyfriend', 'contrast', contrastValue)
	setShaderFloat('boyfriend', 'brightness', brightnessValue)
	if limoKillingState == 1 then
		setProperty('limoMetalPole.x', getProperty('limoMetalPole.x') + 5000 * elapsed)
		setProperty('limoLight.x', getProperty('limoMetalPole.x') - 180)
		setProperty('limoCorpse.x', getProperty('limoLight.x') - 50)
		setProperty('limoCorpseTwo.x', getProperty('limoLight.x') + 35)
		for i = 0, 5 do
			if getProperty('dancers-'..i..'.x') < screenWidth * 1.5 and getProperty('limoLight.x') > (370 * i) + 130 then
				diffStr = i == 3 and ' 2 ' or ' ' -- thx soup
				if i == 0 or i == 1 or i == 2 or i == 3 then
					if i == 0 then playSound('dancerdeath', 0.5) end
					
					-- Create Particles
					makeAnimatedLuaSprite('particle-0'..i, 'gore/noooooo', getProperty('dancers-'..i..'.x') + 200, getProperty('dancers-'..i..'.y'))
					makeAnimatedLuaSprite('particle-1'..i, 'gore/noooooo', getProperty('dancers-'..i..'.x') + 160, getProperty('dancers-'..i..'.y') + 200)
					makeAnimatedLuaSprite('particle-2'..i, 'gore/noooooo', getProperty('dancers-'..i..'.x'), getProperty('dancers-'..i..'.y') + 50)
					makeAnimatedLuaSprite('particle-3'..i, 'gore/stupidBlood', getProperty('dancers-'..i..'.x') - 110 + 20, getProperty('dancers-'..i..'.y') + 20)
					
					-- Add Anims
					addAnimationByPrefix('particle-0'..i, 'spin', 'hench leg spin'..diffStr..'PINK', 24, false)
					addAnimationByPrefix('particle-1'..i, 'spin', 'hench arm spin'..diffStr..'PINK', 24, false)
					addAnimationByPrefix('particle-2'..i, 'spin', 'hench head spin'..diffStr..'PINK', 24, false)
					addAnimationByPrefix('particle-3'..i, 'bl', 'blood', 24, false)
					
					-- Set Properties
					setProperty('particle-3'..i..'.flipX', true)
					setProperty('particle-3'..i..'.angle', -57.5)
					
					-- Parallax
					setScrollFactor('particle-0'..i, 0.4, 0.4)
					setScrollFactor('particle-1'..i, 0.4, 0.4)
					setScrollFactor('particle-2'..i, 0.4, 0.4)
					setScrollFactor('particle-3'..i, 0.4, 0.4)
					
					-- Add
					addLuaSprite('particle-0'..i, false)
					addLuaSprite('particle-1'..i, false)
					addLuaSprite('particle-2'..i, false)
					addLuaSprite('particle-3'..i, false)
				end
				if i == 1 then
					setProperty('limoCorpse.visible', true)
				end
				if i == 2 then
					setProperty('limoCorpseTwo.visible', true)
				end
				setProperty('dancers-'..i..'.x', getProperty('dancers-'..i..'.x') + screenWidth * 2)
			end
		end
		if getProperty('limoMetalPole.x') > screenWidth * 2 then
			resetLimoKill()
			limoSpeed = 800
			limoKillingState = 2
		end		
	end
	if limoKillingState == 2 then
		limoSpeed = limoSpeed - 4000 * elapsed;
		setProperty('bgLimo.x', getProperty('bgLimo.x') - limoSpeed * elapsed)
		if getProperty('bgLimo.x') > screenWidth * 1.5 then
			limoSpeed = 3000
			limoKillingState = 3
			runTimer('resetState', 5.2, 1)
		end
	end
	if limoKillingState == 3 then
		limoSpeed = limoSpeed - 2000 * elapsed
		if limoSpeed < 1000 then limoSpeed = 1000 setProperty('bgLimo.x', getProperty('bgLimo.x') - limoSpeed * elapsed) end
		if getProperty('bgLimo.x') < -275 then
			limoKillingState = 4
			limoSpeed = 800
		end
	end
	if limoKillingState == 4 then
		setProperty('bgLimo.x', lerp(getProperty('bgLimo.x'), -150, boundTo(elapsed * 9, 0, 1)))
		if getProperty('bgLimo.x') == -150 then -- resetState exists cause this Is unknowingly broken, I can remove it to fix it but also it'll remove that smooth pushback
			setProperty('bgLimo.x', -150)
			limoKillingState = 0
		end
	end
	if limoKillingState > 2 then
		for i = 0, 5 do
			setProperty('dancers-'..i..'.x', (370 * i) + getProperty('bgLimo.x') + 280)
		end
	end
	if not lowQuality then
		for i = 0, 3 do
			if getProperty('particle-0'..i..'.animation.curAnim.finished') then
				removeLuaSprite('particle-0'..i, true)
			end
			if getProperty('particle-1'..i..'.animation.curAnim.finished') then
				removeLuaSprite('particle-1'..i, true)
			end
			if getProperty('particle-2'..i..'.animation.curAnim.finished') then
				removeLuaSprite('particle-2'..i, true)
			end
			if getProperty('particle-3'..i..'.animation.curAnim.finished') then
				removeLuaSprite('particle-3'..i, true)
			end
		end
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
		setProperty("defaultCamZoom",0.85)
		setProperty('cameraSpeed',0.8)
	  triggerEvent('Camera Follow Pos', '700', '470')
	elseif value == 'b' then
		setProperty('cameraSpeed',1)
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
		triggerEvent('Camera Follow Pos', '429', '406')
		setProperty('cameraSpeed',0.2)
	elseif value == 'milf' then
		triggerEvent('Camera Follow Pos', '429', '406')
		setProperty('cameraSpeed',1)
	elseif value == 'bf' then
	  triggerEvent('Camera Follow Pos', '1017', '311')
	  setProperty('cameraSpeed',0.2)
	end
  end
  
local fastCarCanDrive = true
local danceDir = true
function onBeatHit()
	if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 4 == 0 and curStep >=32 and songName == 'High Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	  if curBeat % 4 == 0 and curStep >=1 and songName == 'Satin Panties Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	  if getRandomBool(1)  then
		addLuaSprite('shooting star', false)
		playAnim('shooting star','drive',true)
	end
	if getRandomBool(10) and fastCarCanDrive then
		fastCarDrive()
	end
	
	if not lowQuality then
		if danceDir then
			danceDir = false
			for i = 0, 5 do
				playAnim('dancers-'..i, 'danceRight', true)
			end
		else
			danceDir = true
			for i = 0, 5 do
				playAnim('dancers-'..i, 'danceLeft', true)
			end
		end
	end
end

function resetLimoKill()
	setProperty('limoMetalPole.x', -500)
	setProperty('limoMetalPole.visible', false)
	setProperty('limoLight.x', -500)
	setProperty('limoLight.visible', false)
	setProperty('limoCorpse.x', -500)
	setProperty('limoCorpseTwo.x', -500)
	setProperty('limoCorpse.visible', false)
	setProperty('limoCorpseTwo.visible', false)
end

function resetFastCar()
	setProperty('fastCar.x', -12600)
	setProperty('fastCar.y', getRandomInt(140, 250))
	setProperty('fastCar.velocity.x', 0)
	fastCarCanDrive = true;
end

function fastCarDrive() -- vroom
	sound = string.format('carPass%i', getRandomInt(0, 1))
	playSound(sound, 0.7)
	setProperty('fastCar.velocity.x', getRandomInt(170, 22) / getPropertyFromClass('flixel.FlxG', 'elapsed') * 3)
	fastCarCanDrive = false
	runTimer('carTimer', 2, 1)
end

function killHenchmen()
	if not lowQuality then
		if limoKillingState < 1 then
			setProperty('limoMetalPole.x', -400)
			setProperty('limoMetalPole.visible', true)
			setProperty('limoLight.visible', true)
			limoKillingState = 1
		end
	end
end

function onTimerCompleted(t, l, ll)
	if t == 'carTimer' then
		resetFastCar()
	elseif t == 'resetState' then
		limoKillingState = 0
	end
end

function lerp(a, b, ratio)
  return math.floor(a + ratio * (b - a))
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end
