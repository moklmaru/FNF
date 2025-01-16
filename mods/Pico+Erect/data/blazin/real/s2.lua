local punchType = 1
local defaultDadOrder = getObjectOrder('dad')
local defaultBfOrder = getObjectOrder('boyfriend')

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'punchlow' then
		playAnim('dad', 'hitLow');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchlowblocked' then
		playAnim('dad', 'block');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchlowdodged' then
		playAnim('dad', 'dodge');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchlowspin' then
		playAnim('dad', 'hitSpin');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'punchhigh' then
		playAnim('dad', 'hitHigh');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchhighblocked' then
		playAnim('dad', 'block');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchhighdodged' then
		playAnim('dad', 'dodge');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'punchhighspin' then
		playAnim('dad', 'hitSpin');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'blockhigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		cameraShake('game', 0.0025, 0.1)
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'blocklow' then
		playAnim('dad', 'punchLow'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'blockspin' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		cameraShake('game', 0.0025, 0.1)
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'dodgehigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		cameraShake('game', 0.0025, 0.1)
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgelow' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchLow'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgespin' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'picouppercutprep' then
		--triggerEvent('Alt Idle Animation', 'dad', '')
		--playAnim('dad', 'idle');
		--setProperty('dad.specialAnim', true);
	else
		--triggerEvent('Alt Idle Animation', 'dad', '-alt')
	end
	if noteType == 'picouppercut' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'uppercutHit');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'hithigh' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitlow' then
		playAnim('dad', 'punchLow'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitspin' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'darnelluppercutprep' then
		playAnim('dad', 'uppercutPrep');
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'darnelluppercut' then
		triggerEvent('Screen Shake','0.5, 0.002','')
		playAnim('dad', 'uppercut');
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'dad', '')
		setObjectOrder('dad', defaultDadOrder)
		playAnim('dad', 'idle');
		setProperty('dad.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'dad', '-alt')
	end
	if noteType == 'fakeout' then
		playAnim('dad', 'cringe');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		playAnim('dad', 'fakeout'); -- TODO: Which anim?
		setProperty('dad.specialAnim', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	setObjectOrder('dad', defaultBfOrder)
	cameraShake('game', 0.0025, 0.15)
	if noteType == 'punchlow' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowblocked' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowdodged' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowspin' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'punchhigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighblocked' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighdodged' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighspin' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'blockhigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'blocklow' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'blockspin' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'dodgehigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgelow' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgespin' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'picouppercutprep' then
		playAnim('dad', 'hitHigh');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'picouppercut' then
		playAnim('dad', 'dodge');
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'hithigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitlow' then
		playAnim('dad', 'punchLow'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitspin' then
		playAnim('dad', 'punchHigh'..punchType);
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'darnelluppercutprep' then
		playAnim('dad', 'uppercutPrep');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'darnelluppercut' then
		playAnim('dad', 'uppercut');
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'dad', '')
		playAnim('dad', 'idle');
		setProperty('dad.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'dad', '-alt')
	end
	if noteType == 'fakeout' then
		playAnim('dad', 'cringe');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		playAnim('dad', 'fakeout'); -- TODO: Which anim?
		setProperty('dad.specialAnim', true);
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'dodgehigh' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgelow' then
		playAnim('dad', 'punchLow'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'dodgespin' then
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'picouppercutprep' then
		--triggerEvent('Alt Idle Animation', 'dad', '')
		--playAnim('dad', 'idle');
		--setProperty('dad.specialAnim', true);
	else
		--triggerEvent('Alt Idle Animation', 'dad', '-alt')
	end
	if noteType == 'picouppercut' then
		playAnim('dad', 'uppercutHit');
		setObjectOrder('dad', defaultDadOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'hithigh' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitlow' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchLow'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'hitspin' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('dad', 'punchHigh'..punchType);
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'darnelluppercutprep' then
		playAnim('dad', 'uppercutPrep');
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'darnelluppercut' then
		playAnim('dad', 'uppercut');
		setObjectOrder('dad', defaultBfOrder)
		setProperty('dad.specialAnim', true);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'dad', '')
		playAnim('dad', 'idle');
		setProperty('dad.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'dad', '-alt')
	end
	if noteType == 'fakeout' then
		playAnim('dad', 'cringe');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('dad', 'pissed');
		setProperty('dad.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		playAnim('dad', 'fakeout'); -- TODO: Which anim?
		setProperty('dad.specialAnim', true);
	end
end