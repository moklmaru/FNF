function onStartCountdown()
    setCharacterX('boyfriend', 700)
    setCharacterY('boyfriend', 150)

    setCharacterY('dad', 150)
end

function onCreate()
    makeLuaSprite('black', '', -700, -600)
	scaleObject('black', 5, 5);
	makeGraphic('black',5000,5000,'000000')
	addLuaSprite('black', false)
	setProperty('black.visible', false);
end

function onStepHit()
    if curStep == 64 then 
        cameraFlash('hud', 'ffffff', 0.5, true)
        setProperty('black.visible', true);
        setProperty('gf.visible', false);

    elseif curStep == 192 then 
        cameraFlash('hud', 'ffffff', 0.5, true)
        setProperty('black.visible', false);
        setProperty('gf.visible', true);

    elseif curStep == 704 then 
        cameraFlash('hud', 'ffffff', 0.5, true)
        setProperty('black.visible', true);
        setProperty('gf.visible', false);

    elseif curStep == 764 then 
        cameraFlash('hud', 'ffffff', 0.5, true)
        setProperty('black.visible', false);
        setProperty('gf.visible', true);
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end