function onCreate()
    --Iterate over all notes
    for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet' then  --Checks if the note is the one in the script. Set this to the name of your file.
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/Bullet_Note'); --Changes the texture to your own
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
            end
        end
    end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Bullet' then
        triggerEvent('Play Animation', 'Shoot', 'dad')
        triggerEvent('Play Animation', 'gf dodge', 'boyfriend')
        cameraShake('camGame', 0.01, 0.2);
        playSound('hankshoot', 1)
        setProperty('health', getProperty('health') + 0.4);
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'Bullet' then
        triggerEvent('Play Animation', 'Shoot', 'dad')
        triggerEvent('Play Animation', 'gf hit', 'boyfriend')
        cameraShake('camGame', 0.01, 0.2);
        playSound('hankshoot', 1)
        setProperty('health', getProperty('health') - 0.4);
    end
end