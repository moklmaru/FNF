local spawnEdd = false;
local flipped = true;

function onCreate()
	precacheImage('characters/annoyedd');
	--addCharacterToList('dedd', 'bf'); -- preloads the anim of edd blueballing in case it's used
	makeAnimatedLuaSprite('pretendedd', 'characters/edd', 0, 0);
	addAnimationByIndices('pretendedd', 'heIsLooking', 'EddTurnAround', '12', 24);
	
	makeAnimatedLuaSprite('fakedd', 'characters/annoyedd', 0, 0);
	addAnimationByPrefix('fakedd', 'idle', 'EddSideIdle', 24, false);
	
	addAnimationByPrefix('fakedd', 'singLEFT', 'EddSideLeft', 24, false);
	addAnimationByPrefix('fakedd', 'singDOWN', 'EddSideDown', 24, false);
	addAnimationByPrefix('fakedd', 'singUP', 'EddSideUp', 24, false);
	addAnimationByPrefix('fakedd', 'singRIGHT', 'EddSideRight', 24, false);
end
local singDirections = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
local singOffsets = {
	[1] = {x = 5, y = 4},
	[2] = {x = 20, y = -61},
	[3] = {x = -28, y = 39},
	[4] = {x = -8, y = 0}
}
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'No Animation' then
		objectPlayAnimation('fakedd', singDirections[noteData+1], true);
		setProperty('fakedd.offset.x', singOffsets[noteData+1].x);
		setProperty('fakedd.offset.y', singOffsets[noteData+1].y);
	end
end
function onBeatHit() 
	if curBeat % 2 == 0 then
		if (getProperty('fakedd.animation.curAnim.name') == 'idle') or (string.find(getProperty('fakedd.animation.curAnim.name'), 'sing') and getProperty('fakedd.animation.curAnim.finished') == true and (not string.find(getProperty('fakedd.animation.curAnim.name'), 'miss'))) then
			setProperty('fakedd.offset.x', 0);
			setProperty('fakedd.offset.y', 0);
			objectPlayAnimation('fakedd', 'idle', true);
		end
	end
end

local eventFuncs = {
	['Eduardo Jumpscare'] = function(value1, value2)
		triggerEvent('Play Animation', 'turnaround', 'edd');
	end,['Camera Follow Pos'] = function(value1, value2)
		if spawnEdd == false then -- if we didn't spawn in the fake edd yet, spawn him in for this bit
			spawnEdd = true;
			setProperty('pretendedd.x', defaultOpponentX-5);
			setProperty('pretendedd.y', defaultOpponentY-10+80);
			addLuaSprite('pretendedd');
			setObjectOrder('pretendedd', getObjectOrder('car')-1);
			objectPlayAnimation('pretendedd', 'heIsLooking');
		end
	end,['Set Cam Zoom'] = function(value1, value2)
		if value1 == '0.7' then
			removeLuaSprite('pretendedd', true);
			setProperty('fakedd.x', defaultOpponentX-5);
			setProperty('fakedd.y', defaultOpponentY-10+80);
			setObjectOrder('fakedd', getObjectOrder('car')-1);
		end
	end,
}
function onEvent(name,value1,value2)
	eventFuncs[name](value1, value2);
end