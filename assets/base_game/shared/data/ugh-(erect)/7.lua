local toggleFocus = true
local lastValue1 = ''
local bopInterval = 2

function onCreate()
    k = triggerEvent
end

function onEvent(name, value1, value2)
    if name == "Focus Camera" then
        if value1 == '1' then
            if lastValue1 ~= '1' then
                toggleFocus = true
            end

            if toggleFocus then
                runTimer('1x',0.5)
                k('Camera Follow Pos', 436.5,534.5)
            else
                k('Camera Follow Pos', '735', '567.5')
            end
            toggleFocus = not toggleFocus
        elseif value1 == '0' then
            runTimer('2x',0.5)
            k('Camera Follow Pos', '917.5', '559')
            toggleFocus = true
        elseif value1 == '2' then
            runTimer('1x',0.5)
            k('Camera Follow Pos', 436.5,534.5)
            toggleFocus = true
        end

        lastValue1 = value1
    end
    
    if name == "Set Camera Zoom" then    
        
        if value2 == '' then
            setProperty("defaultCamZoom", value1)
            debugPrint(value2)
        else
            doTweenZoom('camz', 'camGame', tonumber(value1-0.125), tonumber(value2) /32, 'sineInOut')
        end
    end
    
    if name == "Change Camera Bop" then
        bopInterval = tonumber(value1) or 2
    end
end

function onBeatHit()
    if curBeat % bopInterval == 0 then
        triggerEvent('Add Camera Zoom', '', '0.035')
    end
end

function onTweenCompleted(name)
    if name == 'camz' then
        setProperty("defaultCamZoom", getProperty('camGame.zoom'))
    end
end
function onUpdate(elapsed)
    local currentAnim = getProperty('dad.animation.curAnim.name')
    if currentAnim == 'laugh' or currentAnim == 'beat it' or currentAnim == 'augh' then
        setProperty('dad.flipX', false)
    else
        setProperty('dad.flipX', true)
    end
end
