function onCreate()
    makeLuaSprite('objection', 'Extras/objection' ,0,0)
    addLuaSprite('objection', false)
    setProperty('objection.visible', false)

    setObjectCamera('objection', 'camHUD')
end

function onStepHit()
    if curStep == 378 then 
        setProperty('objection.visible', true)
    end
    if curStep == 384 then 
        setProperty('objection.visible', false)
    end
end