luaDebugMode = true
luaDeprecatedWarnings = true
canPlayCS = true;
cutsceneShowed = false
lockedLmao = false
picoUnlocked = true
startIdlePico = true
WeAreNintendoYouCannotCancelUs = false
local confirmed = false
local characters5 = {'bfChill', 'gfChill'} 
local characters4 = {'picoChill', 'neneChill'} 
function blend(nombreSprite)
    setBlendMode(nombreSprite, 'add')
end

function crearLuaSprite(nombreSprite, ruta, x, y, escalaX, escalaY, camara)
    makeLuaSprite(nombreSprite, ruta, x, y)
    scaleObject(nombreSprite, escalaX, escalaY)
    addLuaSprite(nombreSprite)
    if camara then
        setProperty(nombreSprite .. '.camera', instanceArg(camara), false, true)
    end
end

function crearAtlasSprite(nombreSprite, ruta, x, y, animacion, velocidad, camara)
    makeFlxAnimateSprite(nombreSprite, x, y, ruta)
    loadAnimateAtlas(nombreSprite, ruta)
    addAnimationBySymbol(nombreSprite, "idle", animacion, velocidad, true)
    addLuaSprite(nombreSprite)
    playAnim(nombreSprite, "idle")
    if camara then
        setProperty(nombreSprite .. '.camera', instanceArg(camara), false, true)
    end
end
function crearAtlasSpriteNoLoop(nombreSprite, ruta, x, y, animacion, velocidad, camara)makeFlxAnimateSprite(nombreSprite, x, y, ruta)loadAnimateAtlas(nombreSprite, ruta)addAnimationBySymbol(nombreSprite, "idle", animacion, velocidad, false)addLuaSprite(nombreSprite)playAnim(nombreSprite, "idle")if camara then    setProperty(nombreSprite .. '.camera', instanceArg(camara), false, true)end end

function crearAnimatedLuaSprite(nombreSprite, ruta, x, y, animacion, velocidad, camara, indices)
    makeAnimatedLuaSprite(nombreSprite, ruta, x, y)
    if indices then
        addAnimationByIndices(nombreSprite, nombreSprite, animacion, indices, velocidad, true)
    else
        addAnimationByPrefix(nombreSprite, nombreSprite, animacion, velocidad, true)
    end

    addLuaSprite(nombreSprite)
    if camara then
        setProperty(nombreSprite .. '.camera', instanceArg(camara), false, true)
    end
end
function Animated(nombreSprite, ruta, x, y, animacion, velocidad, camara, indices, loop)    makeAnimatedLuaSprite(nombreSprite, ruta, x, y)    if indices then addAnimationByIndices(nombreSprite, nombreSprite, animacion, indices, velocidad, loop)    else addAnimationByPrefix(nombreSprite, nombreSprite, animacion, velocidad, loop)    end    addLuaSprite(nombreSprite)        if camara then setProperty(nombreSprite .. '.camera', instanceArg(camara), false, true)end end

function onCreate()
    playMusic('stayFunky',1,true)

    createInstance('camSkibidi', 'flixel.FlxCamera', {1120, 690, 220, 24, zoom})
    setProperty('camSkibidi.bgColor', 0x0)
    
    createInstance('camUlin', 'flixel.FlxCamera')
    setProperty('camUlin.bgColor', 0x0)

    createInstance('newCamOther', 'flixel.FlxCamera')
    setProperty('newCamOther.bgColor', 0x0)
    
    createInstance('camUi', 'flixel.FlxCamera')
    setProperty('camUi.bgColor', 0x0)

    createInstance('camTop', 'flixel.FlxCamera')
    setProperty('camTop.bgColor', 0x0)

    createInstance('camLua', 'flixel.FlxCamera')
    setProperty('camLua.bgColor', 0x0)

    callMethodFromClass('flixel.FlxG', 'cameras.remove', {instanceArg('camGame'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.remove', {instanceArg('camOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('newCamOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camUi'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camUlin'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camLua'), false})
    setProperty('luaDebugGroup.camera', instanceArg('camLua'), false, true)

    makeLuaSprite('byebye', '', 0, 0)
    makeGraphic('byebye', 1280, 720, '000000')
    addLuaSprite('byebye', true)
    setProperty('byebye.camera', instanceArg('camLua'), false, true)
   setProperty('byebye.alpha',0)

    makeLuaSprite('intensity', '', 20, 0)
    makeGraphic('intensity', 0, 0, '000000')
    addLuaSprite('intensity', true)

    makeLuaSprite('intensityPico', '', 20, 0)
    makeGraphic('intensityPico', 0, 0, '000000')
    addLuaSprite('intensityPico', true)

    makeLuaSprite('intensityLock', '', 20, 0)
    makeGraphic('intensityLock', 0, 0, '000000')
    addLuaSprite('intensityLock', true)

    crearLuaSprite('charSelectBG', 'UpDaTe/charSelect/charSelectBG', -160, -150, 1, 1, 'newCamOther')
    crearAtlasSprite("crowd", "UpDaTe/charSelect/crowd", -70, 250, "crowd", 24, 'newCamOther')
    crearAnimatedLuaSprite('charSelectStage', 'UpDaTe/charSelect/charSelectStage', -50, 390, '', 24, 'newCamOther')
    crearLuaSprite('tankBuildings', 'UpDaTe/charSelect/curtains', -50, 0, 1, 1, 'newCamOther')
    crearLuaSprite('foregroundBlur', 'UpDaTe/charSelect/foregroundBlur', -125, 250, 1, 1, 'newCamOther')
    blend('foregroundBlur')
    crearAtlasSprite("charSelectSpeakers", "UpDaTe/charSelect/charSelectSpeakers", -70, 420, "Speakers ALL", 24, 'newCamOther')
    setObjectOrder('charSelectSpeakers',getObjectOrder("charSelectSpeakers")+20)

    crearAtlasSprite("barThing", "UpDaTe/charSelect/barThing", 35, 0, "barThing", 24, 'newCamOther')
    scaleObject("barThing",1.1,1)

    crearLuaSprite('charLight', 'UpDaTe/charSelect/charLight', 100, 250, 1, 1, 'newCamOther')
    crearLuaSprite('charLight2', 'UpDaTe/charSelect/charLight', 800, 250, 1, 1, 'newCamOther')
    crearAnimatedLuaSprite('dipshitBacking', 'UpDaTe/charSelect/dipshitBacking', 445, 0, '', 24, 'camUi')
    crearLuaSprite('chooseDipshit', 'UpDaTe/charSelect/chooseDipshit', 450, 0, 1, 1, 'camUi')
    Animated('charSelectorConfirm', 'UpDaTe/charSelect/charSelectorConfirm', 445, 0, '', 24, 'camUi',false)
    scaleObject("charSelectorConfirm",0.75,0.75)
    crearLuaSprite('charSelector', 'UpDaTe/charSelect/charSelector', 595, 300, 0.75, 0.75, 'camUi')
    Animated('charSelectorDenied', 'UpDaTe/charSelect/charSelectorDenied', 445, 0, '', 24, 'camUi')

    scaleObject("charSelectorDenied",0.75,0.75)
    setProperty('charSelectorDenied.alpha',0)
-- Candado 1
crearAnimatedLuaSprite('locks1', 'UpDaTe/charSelect/locks', 475, 150, 'LOCK FULL 1 instance 1', 0, 'camUi')
addAnimationByIndices('locks1', 'anim_lock1', 'LOCK FULL 1 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 2
crearAnimatedLuaSprite('locks2', 'UpDaTe/charSelect/locks', 580, 150, 'LOCK FULL 2 instance 1', 0, 'camUi')
addAnimationByIndices('locks2', 'anim_lock2', 'LOCK FULL 2 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 3
crearAnimatedLuaSprite('locks3', 'UpDaTe/charSelect/locks', 680, 150, 'LOCK FULL 3 instance 1', 0, 'camUi')
addAnimationByIndices('locks3', 'anim_lock3', 'LOCK FULL 3 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 4
crearAnimatedLuaSprite('locks4', 'UpDaTe/charSelect/locks', 475, 265, 'LOCK FULL 2 instance 1', 0, 'camUi')
addAnimationByIndices('locks4', 'anim_lock4', 'LOCK FULL 2 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 5
crearAnimatedLuaSprite('locks5', 'UpDaTe/charSelect/locks', 580, 265, 'LOCK FULL 2 instance 1', 0, 'camUi')
addAnimationByIndices('locks5', 'anim_lock5', 'LOCK FULL 2 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)
setProperty('locks5.alpha',0)

-- Candado 6
crearAnimatedLuaSprite('locks6', 'UpDaTe/charSelect/locks', 680, 265, 'LOCK FULL 4 instance 1', 0, 'camUi')
addAnimationByIndices('locks6', 'anim_lock6', 'LOCK FULL 4 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 7
crearAnimatedLuaSprite('locks7', 'UpDaTe/charSelect/locks', 475, 375, 'LOCK FULL 4 instance 1', 0, 'camUi')
addAnimationByIndices('locks7', 'anim_lock7', 'LOCK FULL 4 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 8
crearAnimatedLuaSprite('locks8', 'UpDaTe/charSelect/locks', 580, 375, 'LOCK FULL 5 instance 1', 0, 'camUi')
addAnimationByIndices('locks8', 'anim_lock8', 'LOCK FULL 5 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

-- Candado 9
crearAnimatedLuaSprite('locks9', 'UpDaTe/charSelect/locks', 680, 375, 'LOCK FULL 5 instance 1', 0, 'camUi')
addAnimationByIndices('locks9', 'anim_lock9', 'LOCK FULL 5 instance 1', {4,5,6,7,8,9,10,11,12,13,14,15,15,15,15,15,15,15,15,15,15,15,15}, 20, true)

crearAnimatedLuaSprite('bfIcon', 'UpDaTe/freeplay/icons/bfpixel',585, 275, 'idle', 24, 'camUi','0,1,2')
scaleObject('bfIcon',2.5,2.5)
setProperty('bfIcon.antialiasing', false)

crearAtlasSprite("bfChill", "UpDaTe/charSelect/bfChill", 650, 350, "bf cs idle", 24, 'newCamOther')
addAnimationBySymbol("bfChill", "confirm", "bf cs confirm", 24, false)
addAnimationBySymbol("bfChill", "deselect", "bf cs deselect", 24, false)
addAnimationBySymbolIndices("bfChill", "out", "BOYFRIEND CS", "49,47", 24, false)
addAnimationBySymbol("bfChill", "in", "bf slide in", 24,false)

addOffset("bfChill",'idle',0,0)
addOffset("bfChill",'in',-5,-15)

crearLuaSprite('lockedNametag', 'UpDaTe/charSelect/lockedNametag', 950, 40, 0.76, 0.76, 'newCamOther')
crearLuaSprite('boyfriendNametag', 'UpDaTe/charSelect/boyfriendNametag', 850, 40, 0.76, 0.76, 'newCamOther')
crearLuaSprite('picoNametag', 'UpDaTe/charSelect/picoNametag', 890, 40, 0.76, 0.76, 'newCamOther')
setProperty('picoNametag.alpha',0)

crearAtlasSprite("gfChill", "UpDaTe/charSelect/gfChill", 650, 350, "bf cs idle", 24, 'newCamOther')
addAnimationBySymbol("gfChill", "idle", "Partner GF idle", 24, true)
addAnimationBySymbol("gfChill", "confirm", "Partner GF confirm", 24, true)
addAnimationBySymbol("gfChill", "deselect", "Partner GF deselect", 28, false)
addAnimationBySymbol("gfChill", "select", "GF character select", 24, true)
setObjectOrder('gfChill',getObjectOrder('chooseDipshit')-2)

crearAnimatedLuaSprite('randomChill', 'UpDaTe/charSelect/randomChill', 800, 200, '', 24, 'newCamOther')
setProperty('ramdonChill.alpha',0)
playAnim('gfChill','idle')
    blend('charLight')
    blend('dipshitBacking')
    blend('charLight2')

    crearAnimatedLuaSprite('picoIconN', 'UpDaTe/freeplay/icons/picopixel',505, 310, 'idle', 24, 'camUi','0,1,2')
    scaleObject('picoIconN',2,2)
    setProperty('picoIconN.antialiasing', false)
    setProperty('picoIconN.alpha',0)
    --
    crearAtlasSprite("neneChill", "UpDaTe/charSelect/neneChill", 710, 405, "NENE CS", 24, 'newCamOther')
    addAnimationBySymbolIndices("neneChill", "idle", "NENE CS", '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29',24, true)
    addAnimationBySymbolIndices("neneChill", "confirm", "NENE CS", '30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46',24, true)
    addAnimationBySymbolIndices("neneChill", "deselect", "NENE CS", '47,48,49,50,51',24, false)
    playAnim('neneChill','idle')
setObjectOrder('neneChill',getObjectOrder('chooseDipshit')-3)

crearAtlasSprite("picoChill", "UpDaTe/charSelect/picoChill", 650, 350, "pico cs idle", 24, 'newCamOther')
addAnimationBySymbolIndices("picoChill", "idle", "PICO CS", '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14',24, true)
addAnimationBySymbolIndices("picoChill", "confirm", "PICO CS", '16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28',24, false)
addAnimationBySymbol("picoChill", "deselect", "pico cs deselect", 24, false)
addAnimationBySymbol("picoChill", "in", "pico slide in", 24, false)
addAnimationBySymbolIndices("picoChill", "out", "PICO CS", '41,39,39,39,39',24, false)
addAnimationBySymbol("picoChill", "unl", "pico unlocked", 24, false)
playAnim('picoChill','out')

addOffset("picoChill",'confirm',-110,-30)
addOffset("picoChill",'idle',-110,-30)
addOffset("picoChill",'deselect',-170,130)
addOffset("picoChill",'in',5,5)
addOffset("picoChill",'out',-50,5)
addOffset("picoChill",'unl',-110,-30)

setProperty('lockedNametag.x',9999)
setProperty('randomChill.x',9999)
setProperty('locks4.alpha',0)
Animated('picoIcon', 'UpDaTe/charSelect/picoIcon', 480, 290, 'Pico Icon instance 1', 24, 'camUi','0,1,2,3,4,5',false)
scaleObject('picoIcon',0.7,0.7)
    --
end
selectedLock = 5
lockPositions = {
    {475+15, 150+35}, {580+15, 150+35}, {680+15, 150+35},
    {475+15, 265+35}, {580+15, 265+35}, {680+15, 265+35},
    {475+15, 375+35}, {580+15, 375+35}, {680+15, 375+35}
}

function moveSelector(newPosition)
    local xPos, yPos = unpack(lockPositions[newPosition])
    doTweenX('moveX', 'charSelector', xPos, 0.3, 'circOut')
    doTweenY('moveY', 'charSelector', yPos, 0.3, 'circOut')
end

function onStartCountdown()
    return Function_Stop
end
function cambiar(objeto, destinoX, duracion)
    duracion = duracion or 1
    local inicioX = getProperty(objeto .. '.x')
    local pasos = 30  
    local intervalo = duracion / pasos 
    local incremento = (destinoX - inicioX) / pasos

    local pasoActual = 0
    function tweenX()
        if pasoActual < pasos then
            inicioX = inicioX + incremento
            setProperty(objeto .. '.x', inicioX)
            pasoActual = pasoActual + 1
            runTimer('tweenX_timer', intervalo)
        else
            setProperty(objeto .. '.x', destinoX)
        end
    end
    tweenX()
end
function onTimerCompleted(tag)
    if tag == 'tweenX_timer' then
        tweenX()
    end
    if tag == 'loadToFreeplayUlisegasHateYall' then
        WeAreNintendoYouCannotCancelUs = true
        runTimer('realLoad',1.4)
        setProperty('camHUD.alpha',0)
        doTweenAlpha('byebye', 'byebye', 1, 1, 'backIn')
        doTweenY('crowd', 'crowd', 150, 1, 'backIn')
        doTweenY('barThing', 'barThing', -50, 1, 'backIn')
        doTweenY('boyfriendNametag', 'boyfriendNametag', -350, 1, 'backIn')
        doTweenY('picoNametag', 'picoNametag', -350, 1, 'backIn')
        doTweenY('charSelectBG', 'charSelectBG', 50, 1, 'backIn')
        doTweenY('_up', 'camUi', -350, 1, 'backIn')
        doTweenY('_up2', 'newCamOther', 350, 1, 'backIn')
    end
    if tag == 'realLoad' then
        if selectedLock == 4 then
            if confirmed then
            loadSong('friday-night-funkin-game-pico')
            end
        end
        if selectedLock == 5 then
            if confirmed then
            loadSong('friday-night-funkin-game')
        end
    end
    end
if tag == 'candado' then
    crearAtlasSpriteNoLoop("lock", "UpDaTe/charSelect/lock", 485, 273, "LOCK TA", 34, 'camUi')
    setProperty('locks4.alpha',0)
    runTimer('unlockidk',0.4)
    runTimer('getPico',3)
    runTimer('uash',1.9)
end
if tag == 'uash' then
    startTween('tweenTag', 'randomChill.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 1, {})
end
if tag == 'getPico' then

picoUnlocked = true
end
if tag == 'picoIdling' then
    lockedLmao = false
    startIdlePico = true
    playAnim('picoChill','idle')
end
if tag == 'unlockidk' then
    playSound('CS_unlock')
end
end
function onUpdatePost()
--
doTweenX('asdasd','charSelectorConfirm',getProperty('charSelector.x'),0.065,'linear')
doTweenY('asdasd2','charSelectorConfirm',getProperty('charSelector.y'),0.065,'linear')

doTweenX('asdasd22','charSelectorDenied',getProperty('charSelector.x'),0.07,'linear')
doTweenY('asdasd222','charSelectorDenied',getProperty('charSelector.y'),0.07,'linear')
if canPlayCS then
if keyboardJustPressed('ENTER') and selectedLock ~= 4 and selectedLock ~= 5 then
    playSound('CS_locked')
end

if keyboardJustPressed('ENTER') and not confirmed and selectedLock == 5 then
    playSound('CS_confirm')
    setProperty('charSelectorDenied.alpha',0)
    setProperty('charSelectorConfirm.alpha',1)
    soundFadeOut(nil, 1, 0)
    runTimer('loadToFreeplayUlisegasHateYall',1)
    confirmed = true
    for _, character in ipairs(characters5) do
        playAnim(character, 'confirm', false)
    end
end

if keyboardJustPressed('ENTER') and not confirmed and selectedLock == 4 and picoUnlocked then
    setProperty('charSelectorDenied.alpha',0)
    setProperty('charSelectorConfirm.alpha',1)
    playSound('CS_confirm')
    soundFadeOut(nil, 1, 0)
    runTimer('loadToFreeplayUlisegasHateYall',1)
    confirmed = true
    for _, character in ipairs(characters4) do
        playAnim(character, 'confirm', false)
    end
end
if WeAreNintendoYouCannotCancelUs == false then
if keyboardJustPressed('ESCAPE') and confirmed and selectedLock == 5 then
    playSound('CS_hihat')
    setProperty('charSelectorDenied.alpha',1)
    setProperty('charSelectorConfirm.alpha',0)
    soundFadeOut(nil, 1, 1)
    cancelTimer('loadToFreeplayUlisegasHateYall')
    confirmed = false
    for _, character in ipairs(characters5) do
        playAnim(character, 'deselect', false,false,1)
    end
end

if keyboardJustPressed('ESCAPE') and confirmed and selectedLock == 4 and picoUnlocked then
    setProperty('charSelectorDenied.alpha',1)
    setProperty('charSelectorConfirm.alpha',0) 
    playSound('CS_hihat')
    soundFadeOut(nil, 1, 1)
    confirmed = false
    cancelTimer('loadToFreeplayUlisegasHateYall')
    for _, character in ipairs(characters4) do
        playAnim(character, 'deselect', false)
    end
end
end
end
--

    setSpriteShader('boyfriendNametag','mainPixel')
    setShaderFloat("boyfriendNametag", 'pxSize',getProperty('intensity.x'))

    setSpriteShader('lockedNametag','mainPixel')
    setShaderFloat("lockedNametag", 'pxSize',getProperty('intensityLock.x'))

    setSpriteShader('picoNametag','mainPixel')
    setShaderFloat("picoNametag", 'pxSize',getProperty('intensityPico.x'))

end
local prevSelectedLock = -1
local picoChillAnimState = ''
local isInAnimationPlaying = false
function onUpdate()
    if canPlayCS == true then
    if keyboardJustPressed('TWO') then
        exitSong()
    end
   if not lockedLmao then
    if not confirmed then
    if keyboardJustPressed('UP') then
        playSound('CS_select')
        if selectedLock > 3 then
            selectedLock = selectedLock - 3
        elseif selectedLock == 1 then
            selectedLock = 7
        elseif selectedLock == 2 then
            selectedLock = 8
        elseif selectedLock == 3 then
            selectedLock = 9
        end
    elseif keyboardJustPressed('DOWN') then
        playSound('CS_select')
        if selectedLock < 7 then
            selectedLock = selectedLock + 3
        elseif selectedLock == 7 then
            selectedLock = 1
        elseif selectedLock == 8 then
            selectedLock = 2
        elseif selectedLock == 9 then
            selectedLock = 3
        end
    elseif keyboardJustPressed('LEFT') then
        playSound('CS_select')
        if selectedLock == 1 then
            selectedLock = 3
        elseif selectedLock == 2 then
            selectedLock = 1
        elseif selectedLock == 3 then
            selectedLock = 2
        elseif selectedLock == 4 then
            selectedLock = 6
        elseif selectedLock == 5 then
            selectedLock = 4
        elseif selectedLock == 6 then
            selectedLock = 5
        elseif selectedLock == 7 then
            selectedLock = 9
        elseif selectedLock == 8 then
            selectedLock = 7
        elseif selectedLock == 9 then
            selectedLock = 8
        end
    elseif keyboardJustPressed('RIGHT') then
        playSound('CS_select')
        if selectedLock == 1 then
            selectedLock = 2
        elseif selectedLock == 2 then
            selectedLock = 3
        elseif selectedLock == 3 then
            selectedLock = 1
        elseif selectedLock == 4 then
            selectedLock = 5
        elseif selectedLock == 5 then
            selectedLock = 6
        elseif selectedLock == 6 then
            selectedLock = 4
        elseif selectedLock == 7 then
            selectedLock = 8
        elseif selectedLock == 8 then
            selectedLock = 9
        elseif selectedLock == 9 then
            selectedLock = 7
        end
    end
end
end
end
    moveSelector(selectedLock)
    for i = 1, 9 do
        local lockName = 'locks' .. i
        if i == selectedLock then
            playAnim(lockName, 'anim_lock' .. i) 
        else
            playAnim(lockName, 'locks' .. i)  
        end
    end
   if picoUnlocked then
    if selectedLock ~= 4  then
        setProperty('lockedNametag.x',950)
        setProperty('randomChill.x',800)
        startTween('tweenTag', 'randomChill.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 1, {})
    else
        setProperty('lockedNametag.x',9999)
        setProperty('randomChill.x',9999)
    end


    if selectedLock == 4 then
        setProperty('picoNametag.alpha', 1)
        setProperty('neneChill.alpha', 1)
        
        if startIdlePico then  -- Mantener control inicial de animación con startIdlePico
if getProperty('picoChill.anim.finished') and not confirmed then
    playAnim('picoChill', 'idle', true)
    playAnim('neneChill', 'idle', true)
end
            if picoChillAnimState ~= 'in' then
                if not confirmed then
                playAnim('picoChill', 'in', false)
                picoChillAnimState = 'in'
                end
            elseif picoChillAnimState == 'in' and getProperty('picoChill.anim.finished') then
                if not confirmed then
                playAnim('picoChill', 'idle', true)
                picoChillAnimState = 'idle'
                end
            end
        end
        
        setProperty('picoIconN.alpha', 0)
        setProperty('picoIcon.alpha', 1)
        cambiar('intensityPico', 0.1, 0.1)
    else
        setProperty('picoIconN.alpha', 1)
        setProperty('picoIcon.alpha', 0)
        setProperty('picoNametag.alpha', 0)
        setProperty('neneChill.alpha', 0)

        -- Cambiar a 'out' si no está en ese estado
        if picoChillAnimState ~= 'out' then
            playAnim('picoChill', 'out', false)
            picoChillAnimState = 'out'
        end
        
        cambiar('intensityPico', 20, 0.5)
    end
end

    if selectedLock ~= 5 then
        setProperty('randomChill.alpha',1)
        setProperty('lockedNametag.alpha',1)
    else
        setProperty('lockedNametag.alpha',0)
        setProperty('randomChill.alpha',0)
    end
    


    if selectedLock ~= prevSelectedLock then
        if selectedLock == 5 then
            isInAnimationPlaying = false
            if getProperty('bfChill.anim.lastPlayedAnim') ~= 'in' then
                playAnim('bfChill', 'in', false)
            end
            setProperty('boyfriendNametag.alpha', 1)
            setProperty('gfChill.alpha', 1)
            setProperty('bfIcon.x', 585)
            setProperty('bfIcon.y', 275)
            scaleObject('bfIcon', 2.5, 2.5)
            cambiar('intensity', 0.1, 0.1)
        else
            if getProperty('bfChill.anim.lastPlayedAnim') ~= 'out' then
              if not isInAnimationPlaying then
                playAnim('bfChill', 'out', false)
                isInAnimationPlaying = true
              end
            end
            setProperty('boyfriendNametag.alpha', 0)
            setProperty('gfChill.alpha', 0)
            scaleObject('bfIcon', 2, 2)
            setProperty('bfIcon.x', 595)
            setProperty('bfIcon.y', 285)
            cambiar('intensity', 20, 0.5)
        end
        prevSelectedLock = selectedLock
    end
    if selectedLock == 5 then
        cambiar('intensity',0.1,0.1)
    else
        cambiar('intensity', 20,0.5)
    end
    if getProperty('bfChill.anim.finished') and not confirmed  and selectedLock == 5  then
        playAnim('bfChill', 'idle', true)
        playAnim('gfChill', 'idle', true)
    end

    if selectedLock == 5 then
        cambiar('intensityLock', 20,0.1)
    else
        cambiar('intensityLock', 0.1,3)
    end

    

end