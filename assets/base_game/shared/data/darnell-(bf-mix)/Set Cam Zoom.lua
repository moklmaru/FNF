local toggleFocus = true
luaDebugMode = true
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
                k('Camera Follow Pos', '290.5', '400.5')
            else
                k('Camera Follow Pos', '351.5', '432.5')
            end
            toggleFocus = not toggleFocus
        elseif value1 == '0' then
            runTimer('2x',0.5)
            k('Camera Follow Pos', '648', '466')
            toggleFocus = true
        end

        lastValue1 = value1
    end
    
    if name == "Set Camera Zoom" then    
        if value1 == '0.75' then
            k('Camera Follow Pos', '351.5', '432.5')
        end
        
        if value2 == '' then
            setProperty("defaultCamZoom", value1)
            debugPrint(value2)
        else
            doTweenZoom('camz', 'camGame', tonumber(value1), tonumber(value2) /16, 'sineInOut')
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
