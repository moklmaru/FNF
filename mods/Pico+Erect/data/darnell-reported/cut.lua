negro = true
negroC=true
local camFollowTargetX = 350
local camFollowTargetY = 450
local camFollowStartX = 800
local camFollowStartY = 500
local camFollowSpeed = 2
local elapsedTime = 0
local totalLerpTime = 2
local cameraMoving = false

local camFollowTargetX2 = camFollowTargetX + 50
local camFollowStartX2 = camFollowTargetX
local camFollowStartY2 = camFollowTargetY
local elapsedTime2 = 0
local totalLerpTime2 = 0.25
local cameraMoving2 = false

function onStartCountdown()
    precacheImage('spraycanAtlas/spritemap1')
    if isStoryMode then
        if negroC then
            createInstance('video', 'hxvlc.flixel.FlxVideoSprite', 0, 0)
            callMethod('video.load', {callMethodFromClass('backend.Paths', 'modFolders', {'videos/darnellCutscene.mp4'})})
            callMethod('video.play')
            runHaxeCode('getVar("video").bitmap.onEndReached.add(()->remove(getVar("video")));')
            setProperty('video.camera', instanceArg('camOther'), false, true)
            setGraphicSize('video', 1, 1)
            addInstance('video', true)
            runTimer('CUTSCENEXD',85)
            negro = true
    negroC=false
    negro = true
        if not negro then
            return Function_Continue
        else
            return Function_Stop
        end
    end
end
end
risa = 0
risa2 = 0
idlen=0
function onTimerCompleted(tag)
    if isStoryMode then
    if tag == 'CUTSCENEXD' then
        playMusic('darnellCanCutscene')
        setProperty('myCutscene_video.alpha', 0) 
        setProperty('cameraSpeed', 999)
        makeAnimatedLuaSprite('xd', 'characters/Pico_Intro', getProperty('boyfriend.x') - 65, getProperty('boyfriend.y'))
        addAnimationByIndices('xd', 'bop', 'Pico Gets Pissed', '23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62', 24, false)
        addAnimationByIndices('xd', 'bop2', 'cutscene cock', '0,1,2,3,4,5,6,7,8', 48, false)
        addAnimationByPrefix ('xd', 'bop3', 'shoot and return', 24, false)
        addLuaSprite('xd', true)
        playAnim('xd','bop',true)
        setProperty('boyfriend.alpha', 0)
        setProperty('camHUD.alpha', 0)
        cameraFlash('other', '000000', 3)
        setProperty('camGame.zoom', 1.25)
        runTimer('idlen',0.1)
        runTimer('2da', 4)
        runTimer('skibidix', 1)
        setProperty('camFollow.x', camFollowStartX)
        setProperty('camFollow.y', camFollowStartY)
        end
    if tag == 'idlen' then
        idlen=idlen+1
        if idlen<=6 then
            runTimer('idlen',0.5)
        triggerEvent('Play Animation','idle','dad')
    end
    end
    if tag == 'shi' then
        triggerEvent('Play Animation','lightCan2','dad')
    end
    if tag == 'PORFINXD' then
        negro = false
        setProperty('camHUD.alpha', 1)
        doTweenZoom('smoothZoom', 'camGame', 0.77, 2, 'linear') 
        setProperty('cameraSpeed',1)
        startCountdown()
       runTimer('chaito',3)
        end
        if tag == 'chaito' then
            removeLuaSprite('xd', true)
            setProperty('boyfriend.alpha', 1)
        end
    if tag == '0.5' then
    makeLuaSprite('INasd', '', -590, -245)
    luaSpriteMakeGraphic('INasd', 3000, 2001, '000000')
    addLuaSprite('INasd', false)
    runTimer('PORFINXD',2)
    doTweenAlpha('PUUM', 'INasd', 0, 1, 'linear')  
        setProperty('xd.x',470)
        setProperty('xd.y',112)
        playAnim('xd','bop3',true)
        runTimer('jijijija',0.5)
        playSound('shot2')
    end
    if tag == 'jijijija' then
        removeLuaSprite('mySprite', false) 
        triggerEvent('Play Animation','laugh','dad')
runTimer('darnellLoop',0.25)
playSound('darnell_laugh')
playSound('nene_laugh')
triggerEvent('Play Animation','ja','gf')
runTimer('neneLoop',0.45)
    end
    if tag == 'darnellLoop' then
        risa = risa + 1
        if risa <= 3 then
            triggerEvent('Play Animation','laugh','dad')
            runTimer('darnellLoop',0.25)
        end
            end
    if tag == 'neneLoop' then
risa2 = risa2 + 1
if risa2 <= 5 then
    triggerEvent('Play Animation','ja2','gf')
    runTimer('neneLoop',0.2)
end
    end
    if tag == 'penesecuela2' then
        triggerEvent('Play Animation','kneeCan','dad')
        playAnim('mySprite','b',true)
        playSound('Kick_Can_FORWARD')
        runTimer('0.5',0.45)
    end
    if tag == 'penesecuela' then
        playSound('Kick_Can_UP')
        makeFlxAnimateSprite("mySprite", 300, 350, "spraycanAtlas")
        loadAnimateAtlas("mySprite", "spraycanAtlas")
        addAnimationBySymbolIndices("mySprite","idle", "Can with Labels", {0, 1, 2, 3, 4, 5, 6, 7}, 18, false)
        addAnimationBySymbolIndices("mySprite","b", "Can with Labels", {7,8,9,10,11,12,13,14,15,16,17,18,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}, 24, false)
        addLuaSprite("mySprite", true)
        playAnim('mySprite','idle',true)
        triggerEvent('Play Animation','kickCan','dad')
    end
    if tag == 'pene' then
        local randomX = math.random(840,940)
        makeAnimatedLuaSprite('PicoBullet', 'phillyStreets/PicoBullet', randomX, 448)
        addAnimationByPrefix('PicoBullet', 'sa', 'Pop', 24, false)
        scaleObject('PicoBullet', 1, 1)
        addLuaSprite('PicoBullet', true)
        playAnim('xd','bop2',true)
        setProperty('xd.x',730)
        setProperty('xd.y',342)
        playSound('Gun_Prep')
        elapsedTime2 = 0
        cameraMoving2 = true
    end
    if tag == '2da' then
        playSound('Darnell_Lighter')
        runTimer('shi', 0.5)
        runTimer('penesecuela',1.25)
        runTimer('penesecuela2',1.65)
        runTimer('pene', 0.75)
        triggerEvent('Play Animation','lightCan','dad')
    end
    if tag == 'skibidix' then
        doTweenZoom('smoothZoom', 'camGame', 0.65, totalLerpTime, 'linear') 
        elapsedTime = 0 
        cameraMoving = true 
    end
end
end
function onUpdate(elapsed)
    if isStoryMode then
    if cameraMoving then
        if elapsedTime < totalLerpTime then
            elapsedTime = elapsedTime + elapsed
            local t = elapsedTime / totalLerpTime
            local currentX = lerp(camFollowStartX, camFollowTargetX, t)
            local currentY = lerp(camFollowStartY, camFollowTargetY, t)
            setProperty('camFollow.x', currentX)
            setProperty('camFollow.y', currentY)
        else
            cameraMoving = false 
        end
    end

    if cameraMoving2 then
        if elapsedTime2 < totalLerpTime2 then
            elapsedTime2 = elapsedTime2 + elapsed
            local t = elapsedTime2 / totalLerpTime2
            local currentX = lerp(camFollowStartX2, camFollowTargetX2, t)
            setProperty('camFollow.x', currentX)
            setProperty('camFollow.y', camFollowTargetY) 
        else
            cameraMoving2 = false
        end
    end
end
end

function lerp(a, b, t)
    return a + (b - a) * t
end
