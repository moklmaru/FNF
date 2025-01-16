--[[local animFuncs = {
	['laugh'] = function(value2)
		addLuaSprite('tordLaugh');
		setProperty('tordMain.visible', false);
		playObjectAnimation('tordLaugh', 'laugh', value2);
	end, ['pissed'] = function(value2)
		
	end
}
local eventFuncs = {
	['Tordbot Animations'] = function(value1, value2)
		if value2 == 'true' then
			value2 = true;
		else
		 value2 = false;
		end
		animFuncs[value1](value2);
	end
}

function onEvent(name, value1, value2)
	eventFuncs[name](value1, value2);
end
]]