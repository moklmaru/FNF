local tordStep = 0
local tordX = 0

function onCreate()
	precacheImage('characters/higuys-tord');
	makeAnimatedLuaSprite('higuys','characters/higuys-tord', 0, 0);
	--addAnimationByPrefix('higuys','huh','TordHelicopter',0,false)
	addAnimationByPrefix('higuys', 'parachute', 'TordHelicopter', 24, false);
	addAnimationByPrefix('higuys', 'idle', 'TordIdle', 24, true);
	addAnimationByPrefix('higuys', 'die', 'TordFlailing', 24, true);
	setProperty('higuys.y', getProperty('plane.y'));
	setScrollFactor('higuys', 0.5, 0.8);
	scaleObject('higuys', 1.5, 1.5);
end

function onEvent(name,value1,value2)
	if name == 'Tord in the BG' then
		if value1 == 'drop' then
			--hi guys
			addLuaSprite('higuys', false)
			objectPlayAnimation('higuys', 'idle', false)
			setObjectOrder('higuys', getObjectOrder('plane'))
			setProperty('higuys.x', getProperty('plane.x')+60)
			doTweenY('tordfall', 'higuys', getProperty('higuys.y')+170, 1, 'quadIn')
		elseif value1 == 'explode' then
			addLuaSprite('higuys', false)
			scaleObject('higuys', 1, 1);
			setScrollFactor('higuys', 1, 1);
			setProperty('higuys.x', getProperty('tordBot.x')+(getProperty('tordBot.width')/4.5)-(getProperty('higuys.width')*3));
			setProperty('higuys.y', getProperty('tordBot.y')+(getProperty('tordBot.height')/6)-(getProperty('higuys.height')*2));
			setObjectOrder('higuys', getObjectOrder('tordBot')-1);
			objectPlayAnimation('higuys', 'die', false);
			doTweenY('tordrise', 'higuys', getProperty('higuys.y')-700, 0.8, 'quadOut');
		end
	end
end
local tweenFuncs = {
	['tordfall'] = function()
		objectPlayAnimation('higuys', 'parachute', false)
		doTweenY('torddeploy', 'higuys', getProperty('higuys.y')-50, 0.4, 'quadOut')
		tordX = getProperty('higuys.x')
		tordStep = curDecStep/8
	end, ['torddeploy'] = function()
		doTweenY('tordglide', 'higuys', getProperty('higuys.y')+320, 11, 'quadIn')
	end, ['tordglide'] = function()
		removeLuaSprite('higuys', false);
		tordStep = 0;
	end, ['tordrise'] = function()
		doTweenY('tordexplodefall', 'higuys', 100, 2, 'quadIn');
	end, ['tordexplodefall'] = function()
		removeLuaSprite('higuys', true);
	end
}
function onTweenCompleted(tag)
	tweenFuncs[tag]();
end
	
function onUpdate()
	if tordStep ~= 0 then
		--debugPrint(getProperty('higuys.x'))
		setProperty('higuys.x',tordX+(60*math.sin(curDecStep/8-tordStep)))
	end
end