function onCreate()
	precacheSound('train_passes')


		makeLuaSprite('sky', 'phillyErect/sky', -100, -20);
		setScrollFactor('sky', 0.1, 0.1);

		makeLuaSprite('behindTrain', 'phillyErect/behindTrain', -40, 20);
	
	
	makeLuaSprite('city', 'phillyErect/city', -10, 0);
	setScrollFactor('city', 0.3, 0.3);
	scaleObject('city', 0.85, 0.85);
	
	makeLuaSprite('train', 'philly/train', 2000, 360);
	makeLuaSprite('street', 'phillyErect/street', -40, 50);
	
	addLuaSprite('sky', false);
	addLuaSprite('city', false);

  makeAnimatedLuaSprite('light', 'phillyErect/win-erect', -10, 0)
    setLuaSpriteScrollFactor('light', 0.3, 0.3)
    scaleObject('light', 0.85, 0.85)
    addAnimationByIndices('light', 'idle0', 'win-erect idle', '0', 24, true)
    addAnimationByIndices('light', 'idle1', 'win-erect idle', '1', 24, true)
    addAnimationByIndices('light', 'idle2', 'win-erect idle', '2', 24, true)
    addAnimationByIndices('light', 'idle3', 'win-erect idle', '3', 24, true)
    addAnimationByIndices('light', 'idle4', 'win-erect idle', '4', 24, true)
	addLuaSprite('light', false)
	addLuaSprite('behindTrain', false);
	addLuaSprite('train', false);
	addLuaSprite('street', false);
end

local currentAnimation = 0
local lightAlpha = 1
local alphaDecreasing = true

function triggerLightAnimation()
    currentAnimation = (currentAnimation + 1) % 5
    objectPlayAnimation('light', 'idle' .. currentAnimation, true)

    lightAlpha = 1
    setProperty('light.alpha', lightAlpha)
    
    alphaDecreasing = true
end

trainMoving = false;
trainFrameTiming = 0;
startedMoving = false;

trainCars = 8;
trainFinishing = false;
trainCooldown = 0;

curLight = 0;
function onUpdate(elapsed)
	local hueValue = -26
	local saturationValue = -16
	local contrastValue = 0
	local brightnessValue = -5
	
	setSpriteShader('dad', 'adjustColor')
	setShaderFloat('dad', 'hue', hueValue)
	setShaderFloat('dad', 'saturation', saturationValue)
	setShaderFloat('dad', 'contrast', contrastValue)
	setShaderFloat('dad', 'brightness', brightnessValue)
	
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
	if alphaDecreasing then
        lightAlpha = lightAlpha - (elapsed * 0.55)
        if lightAlpha <= 0 then
            lightAlpha = 0
            alphaDecreasing = false
        end
        setProperty('light.alpha', lightAlpha)
    end
	if trainMoving then
		trainFrameTiming = trainFrameTiming + elapsed;

		if trainFrameTiming >= 1 / 24 then
			updateTrainPos();
			trainFrameTiming = 0;
		end
	end
	setProperty('win'..curLight..'.alpha', getProperty('win'..curLight..'.alpha') - (crochet / 1000) * elapsed * 1.5);
end

function onBeatHit()
	if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	if not trainMoving then
		trainCooldown = trainCooldown + 1;
	end
    if curBeat % 4 == 0 then
        triggerLightAnimation()
    end
	if curBeat % 4 == 0 and curStep >=5 and songName == 'Pico Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	  if curBeat % 4 == 0 and curStep >=1 and songName == 'Philly Nice Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	  if curBeat % 4 == 0 and curStep >=128 and songName == 'Blammed Erect' then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	if curBeat % 4 == 0 then
		for i = 0, 4 do
			setProperty('win'..i..'.visible', false)
		end

		curLight = math.random(0, 4);
		setProperty('win'..curLight..'.visible', true)
		setProperty('win'..curLight..'.alpha', 1)
	end

	if curBeat % 8 == 4 and math.random(0, 9) <= 3 and not trainMoving and trainCooldown > 8 then
		trainCooldown = math.random(-4, 0);
		trainStart();
	end
end

function trainStart()
	trainMoving = true;
	playSound('train_passes', 1, 'trainSound');
end

function updateTrainPos()
	if getSoundTime('trainSound') >= 4700 then
		startedMoving = true;
		characterPlayAnim('gf', 'hairBlow');
		setProperty('gf.specialAnim', true);
	end

	if (startedMoving) then
		trainX = getProperty('train.x') - 400;
		setProperty('train.x', trainX);

		if trainX < -2000 and not trainFinishing then
			setProperty('train.x', -1150);
			trainX = -1150;
			trainCars = trainCars - 1;

			if trainCars <= 0 then
				trainFinishing = true;
			end
		end

		if trainX < -4000 and trainFinishing then
			trainReset();
		end
	end
end

function trainReset()
	setProperty('gf.danced', false); 
	characterPlayAnim('gf', 'hairFall');
	setProperty('gf.specialAnim', true);
	setProperty('train.x', screenWidth + 400);
	trainMoving = false;
	trainCars = 8;
	trainFinishing = false;
	startedMoving = false;
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
	  triggerEvent('Camera Follow Pos', '710', '520')
	elseif value == 'b' then
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
	  triggerEvent('Camera Follow Pos', '630', '480')
	elseif value == 'bf' then
		triggerEvent('Camera Follow Pos', '760', '520')
	end
  end
  function onSongStart()
	if songName == 'Blammed Erect' then
    doTweenZoom('songStartZoom', 'camGame', 0.95, 1, 'sineInOut')
end
end
function onTweenCompleted(name)
	if songName == 'Blammed Erect' then
    if name == 'songStartZoom' then
        setProperty('defaultCamZoom', getProperty('camGame.zoom'))
    end
end
end