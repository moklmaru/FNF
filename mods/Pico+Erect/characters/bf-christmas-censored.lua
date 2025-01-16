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
                triggerEvent('Camera Follow Pos', '192', '391')
                runTimer('1x',0.5)
            else
                if getProperty("defaultCamZoom") >0.92 then
                triggerEvent('Camera Follow Pos', '500', '400')
                else
                    triggerEvent('Camera Follow Pos', '500', '350')
                end
            end
            toggleFocus = not toggleFocus
        elseif value1 == '0' then
            runTimer('2x',0.5)
            k('Camera Follow Pos', '1068', '520')
            toggleFocus = true
        elseif value1 == '2' then
            runTimer('1x',0.5)
            triggerEvent('Camera Follow Pos', '192', '391')
            toggleFocus = true
        end

        lastValue1 = value1
    end
    
    if name == "Set Camera Zoom" then    
        if value1 == '0.82' then
            triggerEvent('Camera Follow Pos', '500', '410')
        end
        
        if value2 == '' then
            setProperty("defaultCamZoom", value1-0.12)
            debugPrint(value2)
        else
            if value1 == '0.82' then
                doTweenZoom('camz', 'camGame', tonumber(value1-0.12), tonumber(value2) /32, 'sineInOut')
            else
            doTweenZoom('camz', 'camGame', tonumber(value1-0.21), tonumber(value2) /32, 'sineInOut')
            end
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