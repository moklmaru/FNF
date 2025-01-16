function onCreate() 
    if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        scaleObject("camShader", 20.0, 20.0)
        setSpriteShader('camShader', ShaderName)
        

        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            //FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
skibidi=0.0001
local memuerotio = false

function onUpdate(elapsed)
    setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pico');
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
            if skibidi <=0.45 and curStep >=1 then
                skibidi=skibidi+0.00001*1.5
            end
            setShaderFloat('camShader', 'iTime', os.clock())
            setShaderFloat('camShader', 'iIntensity', skibidi)
            setShaderFloat('camShader', 'iTimescale', 0.7)
            
        end
    end
end
function onGameOverStart()
    setProperty('camFollow.x',1600) 
    setProperty('boyfriend.x',780)
    setProperty('boyfriend.y',144)
    makeAnimatedLuaSprite('NeneKnifeToss', 'characters/NeneKnifeToss',getProperty('boyfriend.x')-400,getProperty('boyfriend.y')-200);
	addAnimationByPrefix('NeneKnifeToss', 'a', 'knife toss', 24, false)
	scaleObject('NeneKnifeToss', 1,1)
    setObjectOrder('NeneKnifeToss',998)
	addLuaSprite('NeneKnifeToss', false);
    --
    makeAnimatedLuaSprite('Pico_Death', 'characters/Pico_Death',700,150);
    addAnimationByIndices('Pico_Death', 'start', 'Pico Death Stab', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50', 24, false);
	addAnimationByIndices('Pico_Death', 'loop', 'Pico Death Stab', '50,51,52,53,54,55,56,57,58,59,60,61,62,63,64', 24, true);
    scaleObject('Pico_Death', 1,1)

	addLuaSprite('Pico_Death', false);
    runTimer('loop',2.08)
    playAnim('Pico_Death', 'start',true)
    --
runTimer('ded',1.4)
runTimer('kxd',0.75)
    function onUpdate(elapsed)
        setShaderFloat('camShader', 'iTime',0)
        setShaderFloat('camShader', 'iIntensity', 0)
        setShaderFloat('camShader', 'iTimescale', 0)
    end
end
function onGameOverConfirm(retry)
    makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1170,200-30);
	addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
	addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true);
	scaleObject('dead', 1,1)
    cancelTimer('ded')
    setObjectOrder('dead',999)
	addLuaSprite('dead', true);
playAnim('dead','a',true)
setProperty('dead.x',900)
setProperty('dead.y',-50)
end
function onTimerCompleted(tag)
    if tag == 'loop' then
        playAnim('Pico_Death', 'loop',true)
    end
    if tag == 'kxd' then
        setProperty('NeneKnifeToss.alpha',0)
    end
if tag == 'ded' then
 
    makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1130,200-30);
    addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true);
	addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
	scaleObject('dead', 1,1)
    setObjectOrder('dead',999)
	addLuaSprite('dead', true);
end
end
function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end
