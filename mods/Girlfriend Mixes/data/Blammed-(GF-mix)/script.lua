function onCreate()
    makeLuaSprite('black', '', -700, -600)
	scaleObject('black', 5, 5);
	makeGraphic('black',5000,5000,'000000')
	addLuaSprite('black', false)
	setProperty('black.visible', false);

    precacheimage('notes/Bullet_Note')
end 

function onStartCountdown()
    doTweenAlpha('camGame','camGame', 0, 0.01, 'linear')
end

function onBeatHit()
    if curBeat == 2 then 
    doTweenAlpha('camGame','camGame', 1, 3, 'linear')
    end
end

function onStepHit()
    if curStep == 448 then 
        playSound('reload', 1, 'bang')

    elseif curStep == 512 then 
        setProperty('gf.visible', false)
        cameraFlash('hud', 'FFFFFF', 0.5, true)
        setProperty('black.visible', true);
        runHaxeCode([[
            FlxTween.tween(game.boyfriend.colorTransform, { redOffset: 255, greenOffset: 0, blueOffset: 0, redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0 }, 0.01);
            FlxTween.tween(game.dad.colorTransform, { redOffset: 0, greenOffset: 255, blueOffset: 0, redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0 }, 0.01);
        ]])

    elseif curStep == 784 then 
        setProperty('gf.visible', true)
        cameraFlash('hud', 'FFFFFF', 0.5, true)
        setProperty('black.visible', false);
        runHaxeCode([[
            FlxTween.tween(game.boyfriend.colorTransform, { redOffset: 0, greenOffset: 0, blueOffset: 0, redMultiplier: 1, greenMultiplier: 1, blueMultiplier: 1 }, 0.01);
            FlxTween.tween(game.dad.colorTransform, { redOffset: 0, greenOffset: 0, blueOffset: 0, redMultiplier: 1, greenMultiplier: 1, blueMultiplier: 1 }, 0.01);
        ]])

    elseif curStep == 576 then 
        playSound('reload', 1, 'bang')

    elseif curStep == 832 then 
        playSound('reload', 1, 'bang')

    elseif curStep == 960 then 
        playSound('reload', 1, 'bang')

    elseif curStep == 1032 then 
        playSound('reload', 1, 'bang')
    end
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end