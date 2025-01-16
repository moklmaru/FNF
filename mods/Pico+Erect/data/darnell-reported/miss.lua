local missTimer = 0
local missDuration = 1

function noteMiss(id, noteData, noteType, isSustainNote)
    if noteData == 0 then
        triggerEvent('Play Animation', 'singLEFTmiss', 'bf')
    end
    if noteData == 1 then
        triggerEvent('Play Animation', 'singDOWNmiss', 'bf')
    end
    if noteData == 2 then
        triggerEvent('Play Animation', 'singUPmiss', 'bf')
    end
    if noteData == 3 then
        triggerEvent('Play Animation', 'singRIGHTmiss', 'bf')
    end
        triggerEvent('Change Character', '0', 'pico-miss')
        missTimer = missDuration
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    triggerEvent('Change Character', '0', 'pico-player')
end

function onUpdate(elapsed)

    if missTimer > 0 then
        missTimer = missTimer - elapsed
        if missTimer <= 0 then
            triggerEvent('Change Character', '0', 'pico-player')
        end
    end
end
