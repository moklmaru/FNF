function onCreate()
	precacheImage('notes/targetwarn');
end
local blinkTime = 0.4;
local function blinketh(warnNum)
	setProperty('targetWarnMain'..warnNum..'.color', getColorFromHex('FF0000'));
	doTweenColor('targetWarnMain'..warnNum..'colorFade', 'targetWarnMain'..warnNum, 'FFFFFF', blinkTime, 'linear');
end
function onTimerCompleted(tag, loops, loopsLeft)
	if string.find(tag, 'targetBeep') then
		local targNum = string.sub(tag, string.len('targetBeep')+1, string.len(tag)-string.len('-XXXX')) -- gets the note it appears on
		blinketh(targNum);
		if string.find(tag, '-slow') and loopsLeft == 0 then
			runTimer(string.gsub(tag, '-slow', '-fast'), blinkTime/2, 3);
		end
		if string.find(tag, '-fast') and loopsLeft == 1 then
			triggerEvent('Tordbot Animations', 'buttonPress', 'false');
		end
	end
end
function onTweenCompleted(tag)
	if string.find(tag, 'targetFade') and string.find(tag, 'AlphaFade') then
		local targName = string.sub(tag, 1, string.len(tag)-string.len('AlphaFade'))
		removeLuaSprite(targName, false);
	end
end
local fadeTime = 0.2;
function onEvent(name, value1, value2) -- note number, note name
	if name == 'Target Warn' then
		if tonumber(value1) then
			local arrowValues = {
				[1] = {x = defaultPlayerStrumX0, y = defaultPlayerStrumY0},
				[2] = {x = defaultPlayerStrumX1, y = defaultPlayerStrumY1},
				[3] = {x = defaultPlayerStrumX2, y = defaultPlayerStrumY2},
				[4] = {x = defaultPlayerStrumX3, y = defaultPlayerStrumY3}
			}
			value1 = tonumber(value1)
			local defaultX = arrowValues[value1+1].x;
			local defaultY = arrowValues[value1+1].y;
			makeLuaSprite('targetWarnMain'..tostring(value1), 'notes/targetwarn', defaultX, defaultY);
			makeLuaSprite('targetFade'..tostring(value1), 'notes/targetwarn', getProperty('targetWarnMain'..tostring(value1)..'.x'), getProperty('targetWarnMain'..tostring(value1)..'.y'));
			for i, targs in pairs({'targetWarnMain'..tostring(value1), 'targetFade'..tostring(value1)}) do
				setObjectCamera(targs, 'camHud');
				setObjectOrder(targs, 25);
				addLuaSprite(targs);
			end
			--setProperty('targetFade'..tostring(value1)..'.alpha', 1);
			scaleObject('targetWarnMain'..tostring(value1), 0.6, 0.6);
			setProperty('targetWarnMain'..tostring(value1)..'.offset.x', math.ceil(getProperty('targetWarnMain'..tostring(value1)..'.width')/3.2));
			setProperty('targetWarnMain'..tostring(value1)..'.offset.y', math.ceil(getProperty('targetWarnMain'..tostring(value1)..'.height')/3.2));
			--scaleObject('targetFade'..tostring(value1), 1.5, 1.5);
			setProperty('targetFade'..tostring(value1)..'.offset.x', math.ceil(getProperty('targetFade'..tostring(value1)..'.width')/5.5));
			setProperty('targetFade'..tostring(value1)..'.offset.y', math.ceil(getProperty('targetFade'..tostring(value1)..'.height')/5.5));
			
			doTweenX('targetFade'..tostring(value1)..'ScaleX', 'targetFade'..tostring(value1)..'.scale', getProperty('targetWarnMain'..tostring(value1)..'.scale.x'), fadeTime, 'linear');
			doTweenY('targetFade'..tostring(value1)..'ScaleY', 'targetFade'..tostring(value1)..'.scale', getProperty('targetWarnMain'..tostring(value1)..'.scale.y'), fadeTime, 'linear');
			doTweenAlpha('targetFade'..tostring(value1)..'AlphaFade', 'targetFade'..tostring(value1), 0, fadeTime, 'linear');
			--blink(tostring(value1));
			blinketh(tostring(value1));
			runTimer('targetBeep'..tostring(value1)..'-slow', blinkTime, 2);
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "That's not a racket, it's a" then
		removeLuaSprite('targetWarnMain'..tostring(noteData), false);
	end
end