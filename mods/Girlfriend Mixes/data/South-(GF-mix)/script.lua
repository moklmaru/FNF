function onCreate()
    makeLuaSprite('vignette', 'Extras/vignette', 0,0)
    addLuaSprite('vignette', false)
    setObjectCamera('vignette', 'hud')
    setProperty('vignette.alpha', 0)
end

function onStepHit()
    if curStep == 256 then 
        doTweenAlpha('vignettealpha', 'vignette', 1, 1, 'linear')

    elseif curStep == 512 then 
        doTweenAlpha('vignettealpha', 'vignette', 0, 1, 'linear')

    elseif curStep == 768 then 
        doTweenAlpha('vignettealpha', 'vignette', 1, 1, 'linear')

    elseif curStep == 896 then 
        doTweenAlpha('vignettealpha', 'vignette', 0, 1, 'linear')
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end