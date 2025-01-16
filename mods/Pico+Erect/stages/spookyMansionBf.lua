luaDebugMode=true
local dadName = 'spooky' -- Nombre del personaje que imita a Dad
local bfName = 'gf' -- Nombre del personaje que imita a Boyfriend
local gfName = 'bf' -- Nombre del personaje que imita a Girlfriend

local xDad, yDad = getProperty('dad.x'), getProperty('dad.y') -- Posición del personaje Dad
local xBF, yBF = 400, -8 + 140 -- Posición del personaje BF
local xGF, yGF = 1000, getProperty('boyfriend.y') -- Posición del personaje GF
local isPlayerDad, isPlayerBF, isPlayerGF = false, false, true -- Configuración del lado del jugador
local orderDad, orderBF, orderGF = 11, 10, 12 -- Órdenes de capa para cada personaje

-- Crear instancias de los personajes
createInstance(dadName, 'objects.Character', {xDad, yDad, dadName, isPlayerDad})
createInstance(bfName, 'objects.Character', {xBF, yBF, bfName, isPlayerBF})
createInstance(gfName, 'objects.Character', {xGF, yGF, gfName, isPlayerGF})
setProperty(dadName..'.alpha', 0)
setProperty(bfName..'.alpha', 0)
setProperty(gfName..'.alpha', 0)
if orderDad <= -1 then
    addInstance(dadName)
else
    setObjectOrder(dadName, orderDad)
end

if orderBF <= -1 then
    addInstance(bfName)
else
    setObjectOrder(bfName, orderBF)
end

if orderGF <= -1 then
    addInstance(gfName)
else
    setObjectOrder(gfName, orderGF)
end
function onCountdownTick(counter)
    if getProperty(dadName..'.danceIdle') or counter % 2 == 0 then
        callMethod(dadName..'.dance', {''})
    end
    if getProperty(bfName..'.danceIdle') or counter % 2 == 0 then
        callMethod(bfName..'.dance', {''})
    end
    if getProperty(gfName..'.danceIdle') or counter % 2 == 0 then
        callMethod(gfName..'.dance', {''})
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
    setScrollFactor('gf',1,1)
	setScrollFactor('gfGroup',1,1)
	makeAnimatedLuaSprite('halloweenBG', 'spooky-erect/bgtrees', 150, 50)
	addAnimationByPrefix('halloweenBG', 'idle', 'bgtrees0', 6, true)
	scaleObject('halloweenBG',1,1)
	addLuaSprite('halloweenBG', false)
setScrollFactor('halloweenBG',0.8,0.8)

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

	setBlendMode('halloweenBG', 'add')
	precacheSound('thunder_1')
	precacheSound('thunder_2')
	if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        setSpriteShader('halloweenBG', ShaderName)
    end
end
skibidiULISEGAS=false
local lightningStrikeBeat = 0
local lightningOffset = 8
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
	if tag == 'anim' then
		characterPlayAnim('gf', 'danceLeft', true)
		setProperty('gf.specialAnim', true)
		
		if string.sub(gfName, 1, 4) == "gf" then
			playAnim('gf', 'danceLeft', true)
			setProperty('gf.specialAnim', true)
		end
	end
	end
function onBeatHit()
	if curBeat % 4 == 0 then
        local currentAnim = getProperty('gf.animation.curAnim.name')
        if currentAnim == 'scared' and getProperty('gf.animation.curAnim.finished') then
playAnim('gf','idle',false)
		end
        if currentAnim ~= 'cheer' and currentAnim ~= 'fawn' and currentAnim ~= 'QUERISAWEY' and currentAnim ~= 'sad' then
        end
    end
	if curBeat % getProperty(dadName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(dadName..'.animation.name'), 'sing') and not getProperty(dadName..'.stunned') then
        callMethod(dadName..'.dance', {''})
    end
    if curBeat % getProperty(bfName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(bfName..'.animation.name'), 'sing') and not getProperty(bfName..'.stunned') then
        callMethod(bfName..'.dance', {''})
    end
    if curBeat % getProperty(gfName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(gfName..'.animation.name'), 'sing') and not getProperty(gfName..'.stunned') then
        callMethod(gfName..'.dance', {''})
    end
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
	runTimer('blackt',0.05)
	lightningStrikeBeat = curBeat
	lightningOffset = getRandomInt(8, 24)
	local soundName = string.format('thunder_%i', getRandomInt(1, 2))
	playSound(soundName, 1, 'thundah')
	playAnim('boyfriend', 'scared')
	playAnim('gf', 'scared')
	
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
	doTweenAlpha('gf', 'gf', 1, 0.075, 'linear')
	doTweenAlpha('bf', 'bf', 1, 0.075, 'linear')

	doTweenAlpha('dad', 'dad', 0.5, 0.075, 'linear')
	doTweenAlpha('gfGroup', 'gfGroup', 0.5, 0.075, 'linear')
	doTweenAlpha('boyfriend', 'boyfriend', 0.5, 0.075, 'linear')
	skibidiULISEGAS=true
end

function onTweenCompleted(tween)
	if tween == 'hWA' then
		doTweenAlpha('hWA2', 'stairsLight', 0, 2, 'linear')
		doTweenAlpha('hWA0', 'bgLight', 0, 2, 'linear')

		doTweenAlpha('spooky', 'spooky',0, 2, 'linear')
		doTweenAlpha('gf', 'gf',0, 2, 'linear')
		doTweenAlpha('bf', 'bf',0, 2, 'linear')

		doTweenAlpha('dad', 'dad', 1, 2, 'linear')
		doTweenAlpha('gfGroup', 'gfGroup', 1, 2, 'linear')
		doTweenAlpha('boyfriend', 'boyfriend', 1, 2, 'linear')
		skibidiULISEGAS=false
	end
end
function extraNoteHit(isOpponent, d, miss)
    if isOpponent then
        -- Activar animación de spooky cuando sea un opponentNoteHit
        playAnim(dadName, getProperty('singAnimations')[d + 1]..(miss and 'miss' or ''), true)
        setProperty(dadName..'.holdTimer', 0)
    else
        -- Activar animación de bf cuando sea un goodNoteHit
        playAnim(gfName, getProperty('singAnimations')[d + 1]..(miss and 'miss' or ''), true)
        setProperty(gfName..'.holdTimer', 0)
    end
end

-- Eventos de hit o miss para cada
function goodNoteHit(_, d)
    extraNoteHit(false, d, false) 
end

function opponentNoteHit(_, d)
    extraNoteHit(true, d, false) 
end

function noteMiss(_, d)
    extraNoteHit(false, d, true) 
end
function onUpdate(elapsed)
	setProperty('bf.y',getProperty('boyfriend.y'))
	setProperty('bf.x',getProperty('boyfriend.x'))
	setProperty('spooky.y',getProperty('dad.y'))
	setProperty('spooky.x',getProperty('dad.x'))

    if getProperty(gfName..'.animation.curAnim.finished') and stringStartsWith(getProperty(gfName..'.animation.name'), 'sing') then
        playAnim(gfName, 'idle', true)
    end

    -- Repetir el mismo proceso para el personaje Dad si es necesario
    if getProperty(dadName..'.animation.curAnim.finished') and stringStartsWith(getProperty(dadName..'.animation.name'), 'sing') then
        playAnim(dadName, 'idle', true)
    end

	setShaderFloat('halloweenBG', 'iTime', os.clock())
    setShaderFloat('halloweenBG', 'iIntensity', 0.5)
    setShaderFloat('halloweenBG', 'iTimescale', 10.7)
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end