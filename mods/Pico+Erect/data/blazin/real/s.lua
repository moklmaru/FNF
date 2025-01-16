local punchType = 1
local defaultDadOrder = getObjectOrder('dad')
local defaultBfOrder = getObjectOrder('boyfriend')

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'punchlow' then
		playAnim('boyfriend', 'punchLow'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowblocked' then
		playAnim('boyfriend', 'punchLow'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowdodged' then
		playAnim('boyfriend', 'punchLow'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchlowspin' then
		playAnim('boyfriend', 'punchLow'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'punchhigh' then
		playAnim('boyfriend', 'punchHigh'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
			cameraShake('game', 0.0025, 0.1)
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighblocked' then
		playAnim('boyfriend', 'punchHigh'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
			cameraShake('game', 0.0025, 0.1)
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighdodged' then
		playAnim('boyfriend', 'punchHigh'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'punchhighspin' then
		playAnim('boyfriend', 'punchHigh'..punchType);
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end

	if noteType == 'blockhigh' then
		playAnim('boyfriend', 'block');
		cameraShake('game', 0.0025, 0.1)
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'blocklow' then
		playAnim('boyfriend', 'block');
		cameraShake('game', 0.0025, 0.1)
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'blockspin' then
		playAnim('boyfriend', 'block');
		cameraShake('game', 0.0025, 0.1)
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'dodgehigh' then
		playAnim('boyfriend', 'dodge');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'dodgelow' then
		playAnim('boyfriend', 'dodge');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'dodgespin' then
		playAnim('boyfriend', 'dodge');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'picouppercutprep' then
		playAnim('boyfriend', 'uppercutPrep');
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'picouppercut' then
		playAnim('boyfriend', 'uppercut');
		cameraShake('game', 0.0025, 0.1)
		setObjectOrder('boyfriend', defaultBfOrder)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'hithigh' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitlow' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitspin' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'darnelluppercutprep' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'bf', '-alt')
	end
	if noteType == 'darnelluppercut' then
		triggerEvent('Screen Shake','0.5, 0.002','')
		playAnim('boyfriend', 'uppercutHit');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
		setProperty('boyfriend.flipX', true);
	else
		setProperty('boyfriend.flipX', false);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'bf', '-alt')
	end
	if noteType == 'fakeout' then
		playAnim('boyfriend', 'fakeout');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle'); -- TODO: Which anim?
		setProperty('boyfriend.specialAnim', true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	setObjectOrder('boyfriend', defaultDadOrder)
	if noteType == 'punchlow' then
		playAnim('boyfriend', 'hitLow');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchlowblocked' then
		playAnim('boyfriend', 'hitLow');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchlowdodged' then
		playAnim('boyfriend', 'hitLow');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchlowspin' then
		playAnim('boyfriend', 'hitSpin');
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'punchhigh' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchhighblocked' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchhighdodged' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'punchhighspin' then
		playAnim('boyfriend', 'hitSpin');
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'blockhigh' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'blocklow' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'blockspin' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('boyfriend', 'hitSpin');
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'dodgehigh' then
		cameraShake('game', 0.0025, 0.1)
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'dodgelow' then
		playAnim('boyfriend', 'hitLow');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'dodgespin' then
		playAnim('boyfriend', 'hitSpin');
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'picouppercutprep' then
		playAnim('boyfriend', 'punchHigh'..punchType);
		setProperty('boyfriend.specialAnim', true);
		if punchType == 2 then
			punchType = 1
		else
			punchType = 2
		end
	end
	if noteType == 'picouppercut' then
		playAnim('boyfriend', 'uppercut');
		cameraShake('game', 0.0025, 0.1)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'hithigh' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitlow' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitspin' then
		playAnim('boyfriend', 'hitHigh');
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'darnelluppercutprep' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'bf', '-alt')
	end
	if noteType == 'darnelluppercut' then
		playAnim('boyfriend', 'uppercutHit');
		setProperty('boyfriend.specialAnim', true);
		setProperty('boyfriend.flipX', true);
	else
		setProperty('boyfriend.flipX', false);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	else
		triggerEvent('Alt Idle Animation', 'bf', '-alt')
	end
	if noteType == 'fakeout' then
		playAnim('boyfriend', 'fakeout');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle'); -- TODO: Which anim?
		setProperty('boyfriend.specialAnim', true);
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'hithigh' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitlow' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'hitspin' then
		playAnim('boyfriend', 'hitHigh');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
	end

	if noteType == 'darnelluppercutprep' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'darnelluppercut' then
		playAnim('boyfriend', 'uppercutHit');
		setObjectOrder('boyfriend', defaultDadOrder)
		setProperty('boyfriend.specialAnim', true);
		setProperty('boyfriend.flipX', true);
	else
		setProperty('boyfriend.flipX', false);
	end

	if noteType == 'idle' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'fakeout' then
		playAnim('boyfriend', 'fakeout');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'taunt' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'tauntforce' then
		playAnim('boyfriend', 'taunt');
		setProperty('boyfriend.specialAnim', true);
	end
	if noteType == 'reversefakeout' then
		triggerEvent('Alt Idle Animation', 'bf', '')
		playAnim('boyfriend', 'idle'); -- TODO: Which anim?
		setProperty('boyfriend.specialAnim', true);
	end
end