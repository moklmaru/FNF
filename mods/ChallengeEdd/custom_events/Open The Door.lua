local walkTimes = {
	matt = 2,
	tom = 3
}
local yValues = {
	matt = 5,
	tom = 13
}
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

function table.find(table,v)
    for i,v2 in next,table do
        if v2 == v then
            return i
        end
    end
end
function onEvent(name,value1,value2)
--value1 = character, value2 = x, y position
	if name == 'Open The Door' then
		local pos = string.split(value2, ',')
		--setProperty('gf.visible', false);
		addLuaSprite('door');
		objectPlayAnimation('door', 'open', false);
		runTimer(value1..'DoorExistance', 0.85, 1);
		addLuaSprite(value1);
		objectPlayAnimation(value1, value1..'Walk', false);
		doTweenY(value1..'GoOverHereY', value1, tonumber(pos[2]), walkTimes[value1], 'linear');
		doTweenX(value1..'GoOverHereX', value1, tonumber(pos[1]), walkTimes[value1], 'linear');
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'mattDoorExistance' then
		if difficulty == 0 then
			removeLuaSprite('door', false);
		else
			removeLuaSprite('door', true);
		end
	elseif tag == 'tomDoorExistance' then -- assuming it's tom, we won't need this anymore
		removeLuaSprite('door', true);
	end
end