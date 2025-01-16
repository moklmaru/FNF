local extrasOffsetY = -5; --listen, your guess is as good as mine when it comes to lua sprites being weirdly positioned
local extrasOffsetX = 41;
local tordOffsets = {
	['singLEFT'] = {x = 58, y = 11},
	['singDOWN'] = {x = 31, y = -8},
	['singUP'] = {x = -115, y = 74},
	['singRIGHT'] = {x = 0, y = -8},
	['laugh'] = {x = 0, y = 21},
	['wtf'] = {x = (-21*-1)-extrasOffsetX, y = 7+extrasOffsetY},
	['harpoonHit'] = {x = (-21*-1)-extrasOffsetX, y = 38+extrasOffsetY},
	['ohNo'] = {x = (-21*-1)-extrasOffsetX, y = 32+extrasOffsetY},
	['buttonPress'] = {x = 0, y = 21}
}
local scaleMultiplier = 0.65;
local shakeMul = 0;
local doShake = false;
local skipDance = true;
local healthDrain = false;
local playDirectionals = false;
local flashRed = false;
local flashTime = 0.4
local theRed = 'FFBFBF'; -- the red it flashes to

function onCreate()
	precacheImage('characters/tordbot/tordMain');
	precacheImage('characters/tordbot/tordExtras');
	
	makeAnimatedLuaSprite('tordMain', 'characters/tordbot/tordMain', getProperty('tordBG.x')-35, getProperty('tordBG.y')+40);
	addAnimationByPrefix('tordMain', 'idle', 'TordIdle', 24, false);
	--addAnimationByIndices('tord', 'idle-loop', 'TordIdle', '
	addAnimationByPrefix('tordMain', 'singLEFT', 'TordLeft', 24, false);
	addAnimationByPrefix('tordMain', 'singUP', 'TordUp', 24, false);
	addAnimationByPrefix('tordMain', 'singDOWN', 'TordDown', 24, false);
	addAnimationByPrefix('tordMain', 'singRIGHT', 'TordRight', 24, false);
	addAnimationByPrefix('tordMain', 'buttonPress', 'TordButtonPress', 24, false);
	addAnimationByIndices('tordMain', 'laugh', 'TordHa', '1, 2, 3, 4, 5, 5, 5, 5', 12);
	--addAnimationByIndices('tordMain', 'laugh-trans', 'TordHa', '6, 7, 8, 9, 10, 11, 12, 13', 18);
	
	makeAnimatedLuaSprite('tordExtras', 'characters/tordbot/tordExtras', getProperty('tordMain.x'), getProperty('tordMain.y'));
	addAnimationByPrefix('tordExtras', 'harpoonHit', 'TordHarpoonShot', 24, false);
	addAnimationByPrefix('tordExtras', 'ohNo', 'TordOhNo', 24, false);
	addAnimationByPrefix('tordExtras', 'wtf', 'TordPissed', 24, false);
	addAnimationByIndices('tordExtras', 'wtf-loop', 'TordPissed', '6, 7, 8, 9', 24);
	
	setObjectOrder('tordMain', getObjectOrder('boyfriend'));
	updateHitbox('tordMain');
	scaleObject('tordMain', scaleMultiplier, scaleMultiplier);
	setObjectOrder('tordExtras', getObjectOrder('tordMain'));
	updateHitbox('tordExtras');
	scaleObject('tordExtras', scaleMultiplier, scaleMultiplier);
end
function onTweenCompleted(tag)
	if string.find(tag, 'tordColor') and flashRed == true then
		if string.find(tag, 'white') then -- if we JUST flashed from white, let's flash to red
			doTweenColor('tordColor-red', 'tordExtras', theRed, flashTime, 'linear');
		else -- above but opposite
			doTweenColor('tordColor-white', 'tordExtras', 'FFFFFF', flashTime, 'linear');
		end
	end
end
function onBeatHit()
	if curBeat % 2 == 0 then -- every other beat
		if skipDance == false then
			if (getProperty('tordMain.animation.curAnim.name') == 'idle' or getProperty('tordMain.animation.curAnim.name') == 'laugh') or (string.find(getProperty('tordMain.animation.curAnim.name'), 'sing') and getProperty('tordMain.animation.curAnim.finished') == true and (not string.find(getProperty('tordMain.animation.curAnim.name'), 'miss'))) then
				setProperty('tordMain.offset.x', 0);
				setProperty('tordMain.offset.y', 0);
				objectPlayAnimation('tordMain', 'idle', true);
			end
		end
	end
end
local finishedAnimFuncs = {
	['laugh'] = function()
		skipDance = false;
		playDirectionals = true;
	end, ['buttonPress'] = function()
		skipDance = false;
		playDirectionals = true;
	end
}
function onUpdatePost(elapsed) -- so animations can play as soon as possible
	if getProperty('tordExtras.animation.curAnim.finished') == true then
		if string.find(getProperty('tordExtras.animation.curAnim.name'), 'wtf') and getProperty('tordMain.visible') == false then
			objectPlayAnimation('tordExtras', 'wtf-loop', false);
		end
	end
	if getProperty('tordMain.animation.curAnim.finished') == true then
		finishedAnimFuncs[getProperty('tordMain.animation.curAnim.name')]();
	end
end
local singDirections = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('tordMain.visible') == true then
		if playDirectionals == true then
			local directionString = singDirections[direction+1];
			objectPlayAnimation('tordMain', directionString, true);
			setProperty('tordMain.offset.x', tordOffsets[directionString].x*scaleMultiplier);
			setProperty('tordMain.offset.y', tordOffsets[directionString].y*scaleMultiplier);
		end
		shakeMul = 1
	end
	if healthDrain == true then
		if getProperty('health') > 0.05 then
			setProperty('health', getProperty('health')-0.04);
		end
	end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if healthDrain == true then
		if getProperty('health') < 1 then
			setProperty('health', getProperty('health')+0.05);
		end
	end
end
local animFuncs = {
	['laugh'] = function(value2)
		healthDrain = true;
		setProperty('tordMain.offset.x', tordOffsets['laugh'].x*scaleMultiplier);
		setProperty('tordMain.offset.y', tordOffsets['laugh'].y*scaleMultiplier);
		objectPlayAnimation('tordMain', 'laugh', value2);
		--skipDance = true;
	end, ['pissed'] = function(value2)
		addLuaSprite('tordExtras');
		setProperty('tordMain.visible', false);
		setProperty('tordExtras.offset.x', tordOffsets['wtf'].x*scaleMultiplier);
		setProperty('tordExtras.offset.y', tordOffsets['wtf'].y*scaleMultiplier);
		objectPlayAnimation('tordExtras', 'wtf', value2);
	end, ['harpoonHit'] = function(value2)
		addLuaSprite('tordExtras');
		setProperty('tordExtras.offset.x', tordOffsets['harpoonHit'].x*scaleMultiplier);
		setProperty('tordExtras.offset.y', tordOffsets['harpoonHit'].y*scaleMultiplier);
		objectPlayAnimation('tordExtras', 'harpoonHit', value2);
		removeLuaSprite('tordMain', true);
		doTweenColor('tordColor-red', 'tordExtras', theRed, flashTime, 'linear');
		flashRed = true;
		triggerEvent('Screen Shake', '3, 0.005', 'camGame');
	end, ['ohNo'] = function(value2)
		setProperty('tordExtras.offset.x', tordOffsets['ohNo'].x*scaleMultiplier);
		setProperty('tordExtras.offset.y', tordOffsets['ohNo'].y*scaleMultiplier);
		objectPlayAnimation('tordExtras', 'ohNo', value2);
	end, ['buttonPress'] = function(value2)
		if string.find(getProperty('tordExtras.animation.curAnim.name'), 'wtf') then
			removeLuaSprite('tordExtras', false);
			setProperty('tordMain.visible', true);
		end
		skipDance = true;
		playDirectionals = false;
		setProperty('tordMain.offset.x', tordOffsets['buttonPress'].x*scaleMultiplier);
		setProperty('tordMain.offset.y', tordOffsets['buttonPress'].y*scaleMultiplier);
		objectPlayAnimation('tordMain', 'buttonPress', true);
	end
}
local eventFuncs = {
	['Tordbot Animations'] = function(value1, value2)
		if string.find(value1,'shake') then -- toggle for cam shake
			if value1 == 'shake' then
				doShake = true;
			else
				doShake = false;
			end
		else -- otherwise, we're probably doing some other animation for tord
			if value2 == 'true' then
				value2 = true;
			else
				value2 = false;
			end
			skipDance = true;
			animFuncs[value1](value2);
		end
	end, ['Tordbot'] = function(value1, value2)
		if value1 == 'explode' then
			flashRed = false;
		end
	end
}
function onEvent(name, value1, value2)
	eventFuncs[name](value1, value2);
end

function onUpdate() -- smooth shaking transition :] thank you shrimpsketti
	if getProperty('tordMain.visible') == true and doShake then
		setProperty('camGame.x',math.random(-6,6)*shakeMul);
		setProperty('camGame.y',math.random(-6,6)*shakeMul);
		if shakeMul > 0 then 
			shakeMul = shakeMul - 0.05
		else
			shakeMul = 0
		end
	end
end