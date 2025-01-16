function onCreate() 
    if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        setSpriteShader('halloweenBG', ShaderName)
    end
end
function onUpdate(elapsed)
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