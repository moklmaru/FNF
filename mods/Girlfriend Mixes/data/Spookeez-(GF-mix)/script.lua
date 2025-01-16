function onCreate()
    makeLuaSprite('black', '', -700, -600)
	scaleObject('black', 5, 5);
	makeGraphic('black',5000,5000,'000000')
	addLuaSprite('black', false)
	setProperty('black.visible', false);

    makeLuaSprite('red', '', -700, -600)
	scaleObject('red', 5, 5);
	makeGraphic('red',5000,5000,'ff0000')
	addLuaSprite('red', false)
	setProperty('red.visible', false);

    makeLuaSprite('blue', '', -700, -600)
	scaleObject('blue', 5, 5);
	makeGraphic('blue',5000,5000,'0100ff')
	addLuaSprite('blue', false)
	setProperty('blue.visible', false);

    makeLuaSprite('yellow', '', -700, -600)
	scaleObject('yellow', 5, 5);
	makeGraphic('yellow',5000,5000,'fffb00')
	addLuaSprite('yellow', false)
	setProperty('yellow.visible', false);
end

function onStepHit()
    if curStep == 576 then 
    cameraFlash('hud', 'ffffff', 0.5, 'true')
    setProperty('black.visible', true)
    setProperty('gf.visible', false)

    elseif curStep == 592 then 
        setProperty('black.visible', false)
        setProperty('red.visible', true)

    elseif curStep == 608 then 
        setProperty('red.visible', false)
        setProperty('blue.visible', true)
        
    elseif curStep == 624 then 
        setProperty('blue.visible', false)
        setProperty('yellow.visible', true)
        
    elseif curStep == 640 then 
        setProperty('yellow.visible', false)
        setProperty('black.visible', true)

    elseif curStep == 656 then 
        setProperty('black.visible', false)
        setProperty('red.visible', true)

    elseif curStep == 672 then 
        setProperty('red.visible', false)
        setProperty('blue.visible', true)


    elseif curStep == 688 then 
        setProperty('blue.visible', false)
        setProperty('yellow.visible', true)


    elseif curStep == 704 then 
        cameraFlash('hud', 'ffffff', 0.5, 'true')
        setProperty('yellow.visible', false)
        setProperty('gf.visible', true) 

    elseif curStep == 832 then 
        setProperty('cameraSpeed', 100)

    elseif curStep == 960 then 
        cameraFlash('other', 'ffffff', 0.5, 'true')
        setProperty('cameraSpeed', 0.5)
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end