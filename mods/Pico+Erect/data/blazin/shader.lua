function onCreate() 
    if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        scaleObject("camShader", 20, 20)
        setSpriteShader('camShader', ShaderName)
        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            //FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
skibidi=0.25
k=0
h=7
        function onUpdate(elapsed)

            setShaderFloat('camShader', 'iTime',k)
            if curStep >=1 then
                setShaderFloat('camShader', 'iTime',os.clock())
            else
                k = k + 0.0001
            end
            if curStep >=448 and curStep <=508 then
                k = k + 0.0001
                setShaderFloat('camShader', 'iTime',k)
            end
            if curStep >=508 and curStep<=1408 then
                setShaderFloat('camShader', 'iTime',os.clock())
            end
            if curStep >=1408 then
                k = k + 0.0001
                setShaderFloat('camShader', 'iTime',k)
            end
            setShaderFloat('camShader', 'iIntensity', skibidi)
            setShaderFloat('camShader', 'iTimescale', h)
            
        end
    end
end

function onGameOverStart()
    setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pico'); 
    skibidi = 0
    k = 0
    h = 0
    
    setPropertyFromClass('flixel.FlxG', 'camera.scroll.x', -30) 
    setProperty('camFollow.x', -30) 
    setPropertyFromClass('flixel.FlxG', 'camera.scroll.y', -250) 
    setProperty('camFollow.y', -250) 
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end