--[[function onEvent(name,value1,value2)
    if name == "Cam Speed" then
		setProperty('cameraSpeed', tonumber(value1))
    end
end]]
local pos = {[1] = '0', [2] = '0'}
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
function onEvent(name, value1, value2)-- value 1 is X, Y; value 2 is how long it takes and the tween
	if name == "Cam Speed" then
		pos = string.split(value1, ','); --X, Y
		tweenInfo = string.split(value2, ','); --length of tween, tween type
		doTweenX('camMoveX', 'camGame.scroll', tonumber(pos[1] - (screenWidth / 2)), tonumber(tweenInfo[1])/2.25, 'linear');
		doTweenY('camMoveY', 'camGame.scroll', tonumber(pos[2] - (screenHeight / 2)), tonumber(tweenInfo[1]), tweenInfo[2]); --quadInOut
		triggerEvent('Camera Follow Pos', pos[1], pos[2]); -- just so the cam doesn't try to fix its X pos
	end
end