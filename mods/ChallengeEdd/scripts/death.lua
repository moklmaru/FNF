function onCreate()
	precacheImage('characters/dedd');
end
function string.split(self, sep)
    if sep == "" then return {str:match((str:gsub(".", "(.)")))} end
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(self, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
local eventFuncs = {
	['Camera Follow Pos'] = function(value1, value2)
		if difficulty ~= 1 then
			if value1 == '' then -- when the camera position is set to normal
				setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-dead');
			else -- when the camera changes to edd (eduardo's camera is cause he changes into the 'dad' sprite)
				setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'dedd');
			end
		end
	end, ['Corner Anims'] = function(value1, value2)
		local splits = string.split(value1, ',');
		if string.find(string.lower(splits[2]), 'edd') then
			setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'dedd');
		else
			setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-dead');
		end
	end
}
function onEvent(name, value1, value2)
	eventFuncs[name](value1, value2);
end
function onGameOver()
	setProperty('camGame.zoom', 0.7);
	if getPropertyFromClass('substates.GameOverSubstate', 'characterName') == 'dedd' then
		setCharacterX('boyfriend', defaultOpponentX);
		setCharacterY('boyfriend', defaultOpponentY);
	end
	return function_continue;
end