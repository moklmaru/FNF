function onStepHit()
    if curStep == 354 then 
        cameraFlash('other', 'ffffff', 0.5, 'linear')
        doTweenZoom('Zoom', 'camGame', 1.5, 0.01, 'linear')

    elseif curStep == 800 then 
        cameraFlash('other', 'ffffff', 0.5, 'linear')
        doTweenZoom('Zoomnormal', 'camGame', 1.05, 0.01, 'linear')
    end
end

function onTweenCompleted(t)
    if t == 'Zoom' then 
        setProperty('defaultCamZoom', 1.5)

    elseif t == 'Zoomnormal' then 
        setProperty('defaultCamZoom', 1.05)
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end