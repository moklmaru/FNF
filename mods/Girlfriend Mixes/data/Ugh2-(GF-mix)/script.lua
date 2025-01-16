local beating = false;

function onCreate()
    makeLuaSprite('redlight','Extras/redlight', 0, 0)
	setProperty('redlight.alpha', 0);
	setObjectCamera('redlight', 'other');
	setBlendMode('redlight', 'add')

    addLuaSprite('redlight', true)
end

function onBeatHit()
    if beating == true then
    	setProperty('redlight.alpha', 0.5);
    	doTweenAlpha('redboom', 'redlight', 0, 0.5, 'linear');
    	end
    end

function onStepHit()
    if curStep == 256 then 
        cameraFlash('hud', 'ffffff', 0.5, true)

    elseif curStep == 384 then 
        cameraFlash('hud', 'ffffff', 0.5, true)

    elseif curStep == 512 then 
        cameraFlash('hud', 'ffffff', 0.5, true)
    
    elseif curStep == 640 then
        beating = true
    
    elseif curStep == 892 then
        beating = false
    end
end


function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end