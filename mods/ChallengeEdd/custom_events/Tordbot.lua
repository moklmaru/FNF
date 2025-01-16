local tordFinalYPos = -740;
local camZoomTeehee = 1.5;
local timeToZoom = 0.3;
local changeScaleBy = 1.5;
local beatFunny = false
local shakeMul = 0;
local explodeOffset = 490;
local riptord = false;

local youShouldExplodeNow = false;
function onCreate()
	addCharacterToList('tord', 'dad');
	precacheImage('tordbot');
	precacheImage('CockPitUpClose');
	makeAnimatedLuaSprite('tordBot', 'tordbot', 220, -100);
	addAnimationByPrefix('tordBot', 'idle', 'TordBotIdle', 24, true);
	addAnimationByIndices('tordBot', 'explode', 'TordBotBlowingUp', '0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16', 18);
	scaleObject('tordBot', 1.5, 1.5);
	
	precacheImage('TordBG');
	makeLuaSprite('tordBG', 'TordBG', 90, -890);
	scaleObject('tordBG', 0.5, 0.5)
	
	makeLuaSprite('tordScreen', 'CockPitUpClose', 145, -1025);
	scaleObject('tordScreen',  0.465, 0.465);
	setProperty('tordScreen.offset.x', (getProperty('tordScreen.width')-140)/2);
	setProperty('tordScreen.offset.y', (getProperty('tordScreen.height')-78)/2);
	
	addLuaScript('custom_events/Cam Speed');
	addLuaScript('custom_events/change icon');
	addLuaScript('characters/tordBot');
	addLuaScript('custom_events/zCameraFix');
end
local function shieldZoom(direction, zoomTime)
	if direction == 'in' then
		addLuaSprite('tordScreen', true)
		doTweenX('screenSizeX-In', 'tordScreen.scale', getProperty('tordScreen.scale.x')+changeScaleBy, zoomTime, 'quadOut');
		doTweenY('screenSizeY-In', 'tordScreen.scale', getProperty('tordScreen.scale.y')+changeScaleBy, zoomTime, 'quadOut');
		doTweenAlpha('screenAlpha-In', 'tordScreen', 0, zoomTime*2, 'quadOut');
	elseif direction == 'out' then
		local moveBy = 70;
	
		addLuaSprite('tordScreen', true)
		doTweenX('screenSizeX-Out', 'tordScreen.scale', getProperty('tordScreen.scale.x')-changeScaleBy, zoomTime, 'quadIn');
		doTweenY('screenSizeY-Out', 'tordScreen.scale', getProperty('tordScreen.scale.y')-changeScaleBy, zoomTime, 'quadIn');
		doTweenAlpha('screenAlpha-Out', 'tordScreen', 1, zoomTime, 'quadIn');
		
		doTweenY('tordSpriteMove', 'tordExtras', getProperty('tordExtras.y')+moveBy, zoomTime, 'quadIn');-- change tordMain to tordExtras later
		doTweenY('tordBGMove', 'tordBG', getProperty('tordBG.y')+moveBy, zoomTime, 'quadIn');
		doTweenY('tordScreenMove', 'tordScreen', getProperty('tordScreen.y')+moveBy+50, zoomTime, 'quadIn');
	end
end
function onTweenCompleted(tag)
	if string.find(tag, 'camZoomTord') then
		if not string.find(tag, '-out') then -- zooming into the bot
			shieldZoom('in', 0.5);
			triggerEvent('change icon', 'P2', 'tord');
			triggerEvent('Change Character', 'dad', 'tord'); -- weird trick so it also changes the healthbar color
			setProperty('defaultCamZoom', camZoomTeehee);
			addLuaSprite('tordBG');
			addLuaSprite('tordMain');
			for i, bgelement in pairs({'skybox', 'clouds', 'paralax2', 'housesandfloor', 'fences', 'car', 'tordBot'}) do -- removes BG elements so we don't need to render them during this time
				removeLuaSprite(bgelement, false);
			end
			for i, chara in pairs({'dad', 'gf'}) do -- just makes these guys invisible we don't need em rn
				setProperty(chara..'.visible', false);
			end
		else -- zooming out of the bot
			setProperty('defaultCamZoom', 0.7);
		end
	elseif string.find(tag, 'screenAlpha') then
		if string.find(tag, 'Out') then
			removeLuaSprite('tordScreen', true);
			removeLuaSprite('tordExtras', true);
			removeLuaSprite('tordBG', true);
			for i, bgelement in pairs({'skybox', 'clouds', 'paralax2', 'tordBot', 'housesandfloor', 'fences', 'car'}) do -- adds back the BG elements now that we're out of tordbot
				if bgelement == 'car' then
					addLuaSprite(bgelement, true);
				else
					addLuaSprite(bgelement);
				end
			end
			setProperty('gf.visible', true);
			setProperty('tordBot.offset.x', 250); --old number is 590
			setProperty('tordBot.offset.y', 100);
			objectPlayAnimation('tordBot', 'explode', false);
		else
			removeLuaSprite('tordScreen', false);
		end
	end
end
local tordBotFuncs = { --value 1 is NEVER used, it's the event name. value 2 is the actual shit
	['rise'] = function(value1, value2)
		triggerEvent('Cam Speed', tostring(getProperty('tordBot.x') + getProperty('tordBot.width')/2.25)..', '..tostring(tordFinalYPos+330), value2..', quadInOut'); -- old math to get cam to center on tordbot sprite is getProperty('tordBot.width')/2 + getProperty('tordBot.x') - 50
		addLuaSprite('tordBot');
		setObjectOrder('tordBot', getObjectOrder('paralax2')+1);
		objectPlayAnimation('tordBot', 'idle', false);
		doTweenY('botRise', 'tordBot', tordFinalYPos, tonumber(value2), 'linear');
	end, ['explode'] = function(value1, value2)
		shieldZoom('out', timeToZoom/2);
		doTweenZoom('camZoomTord-out', 'camGame', 0.7, timeToZoom/1, 'quadInOut');
		triggerEvent('Cam Speed', getProperty('camFollowPos.x')..', '..tostring(tonumber(getProperty('camFollowPos.y'))+180), tostring(timeToZoom/1)..', quadInOut');
		riptord = true;
	end, ['zoom'] = function(value1, value2)
		doTweenZoom('camZoomTord', 'camGame', camZoomTeehee, timeToZoom, 'linear');
		triggerEvent('Cam Speed', getProperty('camFollowPos.x')..', '..tostring(tonumber(getProperty('camFollowPos.y'))-180), tostring(timeToZoom)..', linear');
	end, ['beats'] = function(value1, value2)
		if value2 ~= '0' then 
			beatFunny = true;
		else 
			beatFunny = false;
		end
	end
}
local eventFuncs = {
	['Tordbot'] = function(value1, value2)
		tordBotFuncs[value1](value1, value2);
	end, ['Tord in the BG'] = function(value1, value2)
		if value1 == 'explode' then
			youShouldExplodeNow = true
			shakeMul = 2;
			--triggerEvent('Screen Shake', '1, 0.012', 'camGame');
		end
	end
}
function onUpdate(elapsed)
	if getProperty('tordBot.animation.curAnim.name') == 'explode' then
        if getProperty('tordBot.animation.curAnim.finished') == true then
            removeLuaSprite('tordBot', true);
        elseif getProperty('tordBot.animation.curAnim.curFrame') > 9 then
            riptord = false
            setProperty('tordBot.x',220)
        end
    end
    if riptord then
        setProperty('tordBot.x',220+math.random(-10,10))
    end
	if youShouldExplodeNow == true then -- took this from the tordbot character lua and snapped it here, online seems to have a fade out
		setProperty('camGame.x',math.random(-6,6)*shakeMul);
		setProperty('camGame.y',math.random(-6,6)*shakeMul);
		if shakeMul > 0 then 
			shakeMul = shakeMul - 0.02
		else
			shakeMul = 0
			youShouldExplodeNow = false;
		end
	end
end
function onEvent(name, value1, value2)
	eventFuncs[name](value1, value2);
end
function onBeatHit()
	if beatFunny == true and curBeat % 2 == 0 then --zcamerafix :steamhappy:
		setProperty('camGame.zoom',1.515);
		setProperty('camHUD.zoom',1.03)
		doTweenZoom('camGame',1.5,1,'quadOut');
		doTweenZoom('camHUD',1.5,1,'quadOut');
	end
end