local scaleMultiplier = 0.45;

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
local cornerPos = {
	['Edd'] = {x = 150, y = 373}, -- non-zoom is -430, 375
	['BF'] = {x = 790, y = 330} -- non-zoom is 960, 270
}
local spriteSizes = {
	['Edd'] = {x = 1.55, y = 1.55};
	['BF'] = {x = 1.4, y = 1.4}
}
local cornerTimers = {
	['Edd'] = 0,
	['BF'] = 0
}
local tweenTimes = {
	['Edd'] = 0,
	['BF'] = 0
}
function onCreate()
	precacheImage('characters/edd-corner');
	precacheImage('characters/bf-corner');
	
	for i, spriteName in pairs({'Edd', 'BF'}) do
		local fullSpriteName = string.lower(spriteName)..'Corner';
		local fps = 12;
		makeAnimatedLuaSprite(fullSpriteName, 'characters/'..string.lower(spriteName)..'-corner', 0, 0);
		scaleObject(fullSpriteName, spriteSizes[spriteName].x*scaleMultiplier, spriteSizes[spriteName].y*scaleMultiplier);
		updateHitbox(fullSpriteName);
		setProperty(fullSpriteName..'.y', cornerPos[spriteName].y+(getProperty(fullSpriteName..'.height')*scaleMultiplier));
		if spriteName == 'Edd' then
			fps = 24;
			setProperty(fullSpriteName..'.x', cornerPos[spriteName].x-(getProperty(fullSpriteName..'.width')*scaleMultiplier));
		else
			setProperty(fullSpriteName..'.x', cornerPos[spriteName].x+(getProperty(fullSpriteName..'.width')*scaleMultiplier));
		end
		setScrollFactor(fullSpriteName, 0, 0);
		for j, direction in pairs({'Left', 'Up', 'Down', 'Right'}) do
			addAnimationByPrefix(fullSpriteName, 'sing'..string.upper(direction), spriteName..'Enter'..direction, fps, false);
		end
	end
end
local function exitTween(chara, tweenTime)
	if chara == 'Edd' then
		doTweenX(chara..'ExitTweenX-Corner', string.lower(chara)..'Corner', getProperty(string.lower(chara)..'Corner.x')-(getProperty(string.lower(chara)..'Corner.width')*scaleMultiplier), tonumber(tweenTime), 'quadIn');
	else
		doTweenX(chara..'ExitTweenX-Corner', string.lower(chara)..'Corner', getProperty(string.lower(chara)..'Corner.x')+(getProperty(string.lower(chara)..'Corner.width')*scaleMultiplier), tonumber(tweenTime), 'quadIn');
	end
	doTweenY(chara..'ExitTweenY-Corner', string.lower(chara)..'Corner', getProperty(string.lower(chara)..'Corner.y')+(getProperty(string.lower(chara)..'Corner.height')*scaleMultiplier), tonumber(tweenTime), 'quadIn');
end
function onTimerCompleted(tag)
	if string.find(tag, 'X-Corner') then -- so we only do this once per corner character
		local chara = 'BF';
		if string.find(tag, 'Edd') then
			chara = 'Edd';
		end
		exitTween(chara, tweenTimes[chara]);
	end
end
function onTweenCompleted(tag, loops, loopsLeft)
	if string.find(tag, 'X-Corner') then -- only doing this function once
		local chara = 'BF';
		if string.find(tag, 'Edd') then
			chara = 'Edd';
		end
		if string.find(tag, 'Enter') and cornerTimers[chara] > 0 then -- is it a tween that had the chara slided into? does it have a timer?
			runTimer(tag..'-Timer', cornerTimers[chara])
		elseif string.find(tag, 'Exit') then -- if not, get rid of the sprite, we do not need it
			removeLuaSprite(string.lower(chara)..'Corner', false);
		end
	end
end
local eventFuncs = {
	['Corner Anims'] = function(value1, value2)
		local cornerInfo = string.split(value1, ','); --[1] = visible bool string, [2] = who shows
		local timingInfo = string.split(value2, ','); --[1] = tweening time, [2] = how long they stay on screen
		cornerInfo[2] = string.lower(string.gsub(cornerInfo[2], '%s+', ''));
		if not tonumber(timingInfo[1]) then
			timingInfo[1] = '0';
		end
		if not tonumber(timingInfo[2]) then
			timingInfo[2] = '0';
		end
		local h = string.gsub(string.lower(cornerInfo[2]), "^%l", string.upper);
		if string.lower(cornerInfo[2]) == 'bf' then
			h = 'BF';
		end
		if cornerInfo[1] == 'true' then
			addLuaSprite(cornerInfo[2]..'Corner', true);
			setObjectOrder(cornerInfo[2]..'Corner', getObjectOrder('tordBG')+5); -- set to boyfriendGroup if you need to
			cornerTimers[h] = tonumber(timingInfo[2]); -- so the tween finished function can pull the tween time info
			tweenTimes[h] = tonumber(timingInfo[1])*2; -- same w/ above
			doTweenX(h..'EnterTweenX-Corner', cornerInfo[2]..'Corner', cornerPos[h].x, tonumber(timingInfo[1]), 'quadOut');
			doTweenY(h..'EnterTweenY-Corner', cornerInfo[2]..'Corner', cornerPos[h].y, tonumber(timingInfo[1]), 'quadOut');
		else
			exitTween(h, timingInfo[1]);
		end
	end, ['Tordbot'] = function(value1, value2)
		if value1 == 'rise' then
		end
	end
}
function onEvent(tag, value1, value2) --I HATE IF STATEMENTS!!! I HATE IF STATEMENTS!!! (THE FBI IS BUSTING DOWN MY DOOR)
	eventFuncs[tag](value1, value2);
end
local singDirections = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType ~= "That's not a racket, it's a" then -- so animations don't play when you press a rocket note
		for i, guy in pairs({'BF', 'Edd'}) do -- if someone needs to for a cover, you can replace this with checking the note ID instead
			objectPlayAnimation(string.lower(guy)..'Corner', singDirections[noteData+1], true);
		end
	end
end