local maricada = false  
local quependejo = false
local spritesGenerated = 0
local sounds = {'shot1', 'shot2', 'shot3', 'shot4'} 
ttt=0.7
local shadersEnabled = true
local skibidi = 0.35
local memuerotio = false
local gameover = false
local shader = os.clock
local sis = 0.5
function onEvent(name, v1, v2)
    if name == 'beat' then
        if v1 == 'cam' then
            runTimer('MIGRANPOLLAAAAAAAAAAAAAAAAAAAAAAAAA',ttt)
            maricada = true
        end
    end
end

function onCreate()
precacheImage('spraycanAtlas/spritemap1')
    if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        scaleObject("camShader", 20.0, 20.0)
        setSpriteShader('camShader', ShaderName)

        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
    end
    makeLuaSprite('INTRO2', '', -590, -245)
    makeGraphic('INTRO2', 3000, 2001, '000000')
    addLuaSprite('INTRO2', false)
    setProperty('INTRO2.alpha', 0)

    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'pum' then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
        end
    end
end
function onUpdatePost(elapsed)
    if maricada then
        setProperty('camFollow.x', 360) 
        setProperty('camFollow.y', 330) 
    end
end
function onUpdate(elapsed)
    local health = getProperty('health')
    if getProperty('gf.animation.curAnim.finished') and getProperty('gf.animation.curAnim.name') == 'knifeRaise' and memuerotio then
        triggerEvent('Play Animation', 'knife', 'gf')
    end

    if health < 0.5 and not memuerotio then
        memuerotio = true
        triggerEvent('Play Animation', 'knifeRaise', 'gf')
    elseif health >= 0.5 and memuerotio then
        memuerotio = false
        triggerEvent('Play Animation', 'knifelower', 'gf')
    end

    if shadersEnabled then
        setShaderFloat('camShader', 'iTime', shader())
        setShaderFloat('camShader', 'iIntensity', skibidi)
        setShaderFloat('camShader', 'iTimescale', sis)
    end
    if maricada then
        setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'pico-boom');
        setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pico-explode')
        setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOverStart-pico-explode'); 
        setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pico');
    else
        setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'pico-dead2');
        setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pico')
        setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pico'); 
        setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pico');
    end

    setProperty('strumsBlocked',{quependejo,quependejo,quependejo,quependejo})
end
function onGameOverStart()
    shader=0
    skibidi=0
    sis=0
    setShaderFloat('camShader', 'iTime', shader)
    setShaderFloat('camShader', 'iIntensity', skibidi)
    setShaderFloat('camShader', 'iTimescale', sis)
    if maricada  then
        setPropertyFromClass('flixel.FlxG', 'camera.scroll.y', 0) 
        runTimer('yeah', 0.1)
        setProperty('boyfriend.y', 144)
        setProperty('boyfriend.x', 1080)
    
    else 
        setProperty('camFollow.x', 1600) 
        setProperty('boyfriend.x', 780)
        setProperty('boyfriend.y', 144)
    
        makeAnimatedLuaSprite('NeneKnifeToss', 'characters/NeneKnifeToss', getProperty('boyfriend.x') - 400, getProperty('boyfriend.y') - 200)
        addAnimationByPrefix('NeneKnifeToss', 'a', 'knife toss', 24, false)
        scaleObject('NeneKnifeToss', 1, 1)
        setObjectOrder('NeneKnifeToss', 998)
        addLuaSprite('NeneKnifeToss', false)
        --
        makeAnimatedLuaSprite('Pico_Death', 'characters/Pico_Death',700,150);
        addAnimationByIndices('Pico_Death', 'start', 'Pico Death Stab', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50', 24, false);
        addAnimationByIndices('Pico_Death', 'loop', 'Pico Death Stab', '50,51,52,53,54,55,56,57,58,59,60,61,62,63,64', 24, true);
        scaleObject('Pico_Death', 1,1)
    
        addLuaSprite('Pico_Death', false);
        runTimer('loop',2.08)
        playAnim('Pico_Death', 'start',true)
        --
        runTimer('ded', 1.4)
        runTimer('kxd', 0.75)
    end
end

function onGameOverConfirm(retry)
    if not maricada then
    makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1170, 170)
    addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
    addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true)
    scaleObject('dead', 1, 1)
    cancelTimer('ded')
    setObjectOrder('dead', 999)
    addLuaSprite('dead', false)
    playAnim('dead', 'a', true)
    setProperty('dead.x', 900)
    setProperty('dead.y', -50)
end
end
local blinkCount = 10
local blinkDuration = 0.05 
local currentBlink = 0
function noteMiss(id, noteData, noteType, isSustainNote)
    if noteType == 'peneuwu' then
        if noteData == 1 then
            triggerEvent('Play Animation', 'singDOWNmiss', 'bf')
        end
        quependejo = true
        runTimer('ca',0.5)
    end
    if noteType == 'pum' then
        runTimer('malaso',0.0001)
        playAnim('mySprite','m',true)
        setProperty('health', getProperty('health') - 0.5)
        runTimer('blinkBoyfriend', blinkDuration)
        runTimer('eks', 0.25)
        triggerEvent('Change Character', '0', 'pico-player')
        triggerEvent('Play Animation', 'CanHit', 'bf')
    end
end
local bfx = 730-10
local bfy = 340-5


function createBoyfriendEffect()

    makeAnimatedLuaSprite('bfEffect', 'characters/picoBlazin/pico_optimizedbynil', bfx, bfy)
    addAnimationByPrefix('bfEffect', 'idle', 'Pico Reload', 24, true) 
    scaleObject('bfEffect', 1, 1) 
    addLuaSprite('bfEffect', false)

    doTweenY('bfEffectMoveY', 'bfEffect', bfy - 15, 1/2, 'linear')
    doTweenX('bfEffectMoveX', 'bfEffect', bfx + 25, 1/2, 'linear')
    doTweenAlpha('bfEffectFade', 'bfEffect', 0, 1/2.6, 'linear') 
    doTweenX('bfEffectScaleX', 'bfEffect.scale', 1.25, 1/2, 'linear')
    doTweenY('bfEffectScaleY', 'bfEffect.scale', 1.25, 1/2, 'linear') 
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'peneuwu' then
        triggerEvent('Play Animation', 'cock', 'bf')
        createBoyfriendEffect()
        playSound('Gun_Prep')
        ---
        spritesGenerated = spritesGenerated + 1
            local randomX = math.random(840,940)
            makeAnimatedLuaSprite('PicoBullet'..spritesGenerated, 'phillyStreets/PicoBullet', randomX, 448)
            addAnimationByPrefix('PicoBullet'..spritesGenerated, 'sa', 'Pop', 24, false)
            scaleObject('PicoBullet'..spritesGenerated, 1, 1)
            addLuaSprite('PicoBullet'..spritesGenerated, true)
    end
    if noteType == 'pum' then
        playAnim('mySprite','b',true)
        local randomIndex = getRandomInt(1, #sounds)
        local randomSound = sounds[randomIndex]
        playSound(randomSound)
        doTweenAlpha('PUUM', 'INTRO2', 1, 0.125, 'linear')
        runTimer('eks', 0.25)
        triggerEvent('Play Animation', 'shoot', 'bf')
    end
end

function onTimerCompleted(tag)
    if tag == 'malaso' then
        playSound('Pico_Bonk')
        playAnim('mySprite','boom',true)
        setProperty('mySprite.x',900)
        setProperty('mySprite.y',650)
    end
    if tag == 'loop' then
        playAnim('Pico_Death', 'loop',true)
    end
    if tag == 'yeah' then
        runTimer('ef',0.01)
        runTimer('yee',3)
    elseif tag == 'kxd' then
        setProperty('NeneKnifeToss.alpha', 0)
    elseif tag == 'ded' then
        makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1130, 170)
        addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true)
        addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
        scaleObject('dead', 1, 1)
        setObjectOrder('dead', 999)
        addLuaSprite('dead', false)
    end
    if tag == 'MIGRANPOLLAAAAAAAAAAAAAAAAAAAAAAAAA' then
        makeFlxAnimateSprite("mySprite", 300, 350, "spraycanAtlas")
        loadAnimateAtlas("mySprite", "spraycanAtlas")
        addAnimationBySymbolIndices("mySprite","idle", "Can with Labels", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,14,15,16,17,18}, 24, false)
        addAnimationBySymbolIndices("mySprite","b", "Can with Labels", {24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42}, 24, false)
        addAnimationBySymbolIndices("mySprite","m", "Can with Labels", {18, 23}, 24, false)
        addAnimationBySymbolIndices("mySprite","boom", "Can with Labels", {28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42}, 24, false)
        addLuaSprite("mySprite", true)
        runTimer('bodo',0.4)
        playAnim('mySprite','idle',true)
    end
    if tag == 'blinkBoyfriend' then
        local isVisible = getProperty('boyfriend.visible')
        setProperty('boyfriend.visible', not isVisible)
        currentBlink = currentBlink + 1

        if currentBlink < blinkCount * 2 then
            runTimer('blinkBoyfriend', blinkDuration)
        else
            setProperty('boyfriend.visible', true)
            currentBlink = 0
            runTimer('resetBlink', 1.0)
        end
    end
    if tag == 'ca' then
quependejo=false
    end
    if tag == 'eks' then
        maricada = false
        doTweenAlpha('PUUM2', 'INTRO2', 0, 1, 'linear')  
    end
end
function onTweenCompleted(skibidi)
if skibidi == 'PUUM2' then
    removeLuaSprite('mySprite', false) 
end
end
function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end
