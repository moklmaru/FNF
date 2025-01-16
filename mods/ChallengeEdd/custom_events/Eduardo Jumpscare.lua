local neighbores = false;
local eduX = -950;
local eduY = 56;
function onCreate()
	addCharacterToList('eduardo', 'dad');
	precacheImage('characters/jon');
	precacheImage('characters/mark');
	precacheImage('characters/andherecomesthegiantfist');
	
	makeAnimatedLuaSprite('jon', 'characters/jon', -780, 202);
	scaleObject('jon', 0.93, 0.93);
	addAnimationByPrefix('jon', 'jonBop', 'JohnIdle', 24, false);
	
	makeAnimatedLuaSprite('mark', 'characters/mark', -619, 231);
	scaleObject('mark', 0.84, 0.84);
	addAnimationByPrefix('mark', 'markBop', 'MarkIdle', 24, false);
	
	makeAnimatedLuaSprite('patrickno', 'characters/andherecomesthegiantfist', eduX, eduY+70);
	addAnimationByPrefix('patrickno', 'sickspongebobreference', 'EduardoPunch', 24, false);
	scaleObject('patrickno', 0.98, 0.98);
	
end
local eventFuncs = {
	['Eduardo Jumpscare'] = function(value1, value2)
		runTimer('jumpscareLength', value1, 1);
		setProperty('dad.skipDance', true);
	end,['Change Character'] = function(value1, value2)
		triggerEvent('change icon', 'P2', 'edd');
		addLuaSprite('jon');
		addLuaSprite('mark');
		setObjectOrder('jon', getObjectOrder('housesandfloor'));
		setObjectOrder('mark', getObjectOrder('housesandfloor'));
		setObjectOrder('dadGroup', getObjectOrder('jon'));
		neighBores = true;
		setCharacterX('dad', eduX);
		setCharacterY('dad', eduY);
	end,['Set Cam Zoom'] = function(value1, value2)
		if value1 ~= '0.7' then
			characterPlayAnim('dad', 'well', true);
			if value1 == '0.8' then
				triggerEvent('Alt Idle Animation', 'dad', '-nothing');
			end
		else
			triggerEvent('Alt Idle Animation', 'dad', '');
		end
	end,['Set Property'] = function(value1, value2)
		if value1 == 'dad.alpha' then -- this is where we handle some shit
			removeLuaSprite('jon');
			removeLuaSprite('mark');
			addLuaSprite('patrickno');
			objectPlayAnimation('patrickno', 'sickspongebobreference', false);
		end
	end,
}
function onBeatHit()
	if curBeat % 2 == 0 then
		if neighBores == true then
			objectPlayAnimation('jon', 'jonBop', true);
			objectPlayAnimation('mark', 'markBop', true);
		end
	end
end
function onEvent(name,value1,value2)
	eventFuncs[name](value1, value2);
end