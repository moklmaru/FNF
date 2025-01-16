function onCreate()
    makeLuaSprite('white', '', -700, -600)
	scaleObject('white', 5, 5);
	makeGraphic('white',5000,5000,'ffffff')
	addLuaSprite('white', false)
	setProperty('white.visible', false);
end 

function onStepHit()
    if curStep == 416 then 
        cameraFlash('camHUD', 'ffffff', 0.5, true)
        setProperty('white.visible', true);
        setProperty('gf.visible', false);

    elseif curStep == 928 then 
        cameraFlash('camHUD', 'ffffff', 0.5, 'true')
        setProperty('white.visible', false);
        setProperty('gf.visible', true);
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end