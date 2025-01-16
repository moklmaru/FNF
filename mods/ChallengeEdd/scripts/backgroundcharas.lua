local canSnap = false;
local canBop = false;
local mustHit = false; -- thank you twinsomnia for teaching me this weird trick
local hasTurned = false; -- for when tom finishes turning around
local snapType = 'Snap'; --'PISSED' for the pissed variant
local tomLookAt = 'BF';
local tomTimerNum = 0.3; -- cause idk what to set it as atm
local moveMattByThis = 67 -- amount of pixels to move him by for the Jumpscare
local movedMatt = false; -- for when matt has been Moved!
local talkingTom = false; --ben?
local tordExploded = false;
local bfOffsets = {
	['groundShaking'] = {x = 0, y = 0},
	['turnTord'] = {x = -8, y = 14}
}

function onCreate()
	--if not lowQuality then
	precacheImage('dooropen');
	makeAnimatedLuaSprite('door', 'dooropen', 565, 360);
	scaleObject('door', 1.35, 1.35);
	addAnimationByIndices('door', 'open', 'DoorOpening', '10000, 10001, 10002, 10003, 10004, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10004, 10003, 10002, 10001, 10000', 24);
	
	precacheImage('characters/matt');
	makeAnimatedLuaSprite('matt', 'characters/matt', 565, 227);
	scaleObject('matt', 1.51, 1.51);
	addAnimationByPrefix('matt', 'mattWalk', 'MattWalking', 24, true);
	addAnimationByPrefix('matt', 'mattSnap', 'MattSnappingFinger', 24, false);
	addAnimationByPrefix('matt', 'mattPISSED', 'MattPISSED', 24, false);
	addAnimationByPrefix('matt', 'mattJumpscare', 'MattReactionHim', 24, false);

	if difficulty == 0 then
		precacheImage('characters/tom');
		makeAnimatedLuaSprite('tom', 'characters/tom', 615, 220);
		scaleObject('tom', 1.57, 1.57);
		addAnimationByPrefix('tom', 'tomWalk', 'TomWalkingBy', 24, true);
		addAnimationByIndices('tom', 'tomBF', 'TomLooking', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13', 24);
		addAnimationByIndices('tom', 'tomTransBF', 'TomLooking', '19, 18, 17, 16, 15, 14', 24); --oh my god is tom undertale TRANS!?!? /j
		addAnimationByIndices('tom', 'tomTransOP', 'TomLooking', '14, 15, 16, 17, 18, 19', 24);
		addAnimationByPrefix('tom', 'tomTrans', 'TomTransition', 24, false);
		addAnimationByIndices('tom', 'tomOP', 'TomLooking', '20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30', 24);
		addAnimationByPrefix('tom', 'tomJumpscare', 'TomReaction', 24, false);
	else
		precacheImage('characters/tom-fucked');
		makeAnimatedLuaSprite('tom', 'characters/tom-fucked', 1050, 265);
		scaleObject('tom', 1.65, 1.65);
		addAnimationByPrefix('tom', 'tooLate', 'Tom Running In', 24, false);
		addAnimationByIndices('tom', 'tomHarpoonIdle', 'TomHarpoonLine', '0, 1, 2, 3', 24);
		addAnimationByIndices('tom', 'tomHarpoonTurn', 'TomHarpoonLine', '4, 5, 6, 7, 8, 9, 10', 24);
		addAnimationByIndices('tom', 'tomHarpoonTalk', 'TomHarpoonLine', '11, 12, 13, 14, 15, 16', 48);
		addAnimationByIndices('tom', 'tomHarpoonTalk-final', 'TomHarpoonLine', '11, 12, 13, 14, 15, 16, 17', 24);
		addAnimationByIndices('tom', 'tomHarpoonTalk-ended', 'TomHarpoonLine', '18, 19, 20, 21', 24);
		
		addAnimationByPrefix('matt', 'mattSurprise', 'MattReactionTord', 24, false);
		addAnimationByIndices('matt', 'mattAfterIdle', 'MattHarpoonBit', '0, 1, 2, 3, 4, 5, 6, 7', 24);
		addAnimationByIndices('matt', 'mattRelief', 'MattHarpoonBit', '8, 9, 10, 11, 12, 13', 24);
		addAnimationByIndices('matt', 'mattRelief-idle', 'MattHarpoonBit', '14, 15, 16, 17', 24);
		
		makeAnimatedLuaSprite('bfCutscene', 'characters/bf-groundscene', 0, 0);
		addAnimationByPrefix('bfCutscene', 'groundShaking', 'BF Ground Shaking', 24, false);
		addAnimationByPrefix('bfCutscene', 'turnTord', 'BF Look At Tord', 24, false);
		addAnimationByPrefix('bfCutscene', 'lookUp', 'BF LookUp', 24, false);
		setProperty('bfCutscene.offset.x', bfOffsets.groundShaking.x);
		setProperty('bfCutscene.offset.y', bfOffsets.groundShaking.y);
		
		makeAnimatedLuaSprite('eddCutscene', 'characters/relaxedd', 0, 0);
		--addAnimationByPrefix('eddCutscene', 'lookTom', 'EddLookingUp', 24, false);
		addAnimationByIndices('eddCutscene', 'lookRobot', 'EddLookingUp', '0, 1, 2, 3', 24);
		addAnimationByIndices('eddCutscene', 'turnTom', 'EddLookingUp', '6, 7, 8, 9', 24);
		addAnimationByIndices('eddCutscene', 'lookTom', 'EddLookingUp', '10, 11, 12', 24);
	end
end

function whoIsTomLookingAt()
	if mustHitSection == false then -- if the cam ain't lookin at us, tom ain't lookin -_- he does not see
		tomLookAt = 'OP';
	else
		tomLookAt = 'BF';
	end
end

local timerFuncs = {
	['tomHasTransed'] = function(tag, loops, loopsleft)
		hasTurned = true;
		objectPlayAnimation('tom', 'tom'..tomLookAt, true); -- plays animation immediately after turning
	end,['tomHasArrived'] = function(tag, loops, loopsleft)
		canBop = true;
		hasTurned = true;
		objectPlayAnimation('tom', 'tomBF', true);
	end,['jumpscareLength'] = function(tag, loops, loopsleft)
		canSnap = true;
		canBop = true;
		snapType = 'PISSED';
	end, ['tomIsTooLate'] = function(tag, loops, loopsleft)
		addLuaSprite('tom', true);
		objectPlayAnimation('tom', 'tooLate', false);
	end, ['shutUp-Smosh'] = function(tag, loops, loopsLeft)
		talkingTom = false;
		objectPlayAnimation('tom', 'tomHarpoonTalk-final', false);
	end, ['lookTime'] = function(tag, loops, loopsLeft)
		triggerEvent('Play Animation', 'turnTord', 'edd');
		setProperty('bfCutscene.offset.x', bfOffsets.turnTord.x);
		setProperty('bfCutscene.offset.y', bfOffsets.turnTord.y);
		objectPlayAnimation('bfCutscene', 'turnTord', false);
	end
}

function onTimerCompleted(tag, loops, loopsLeft)
	timerFuncs[tag](loops, loopsLeft);
end

function transGener()
	local whoAreYouLookingAtRightNow = tomLookAt;
	hasTurned = false;
	whoIsTomLookingAt();
	if whoAreYouLookingAtRightNow ~= tomLookAt then -- are we about to look in the same direction? if not do this
		objectPlayAnimation('tom', 'tomTrans'..tomLookAt, false); -- holey shit guys he transed his gener...
		runTimer('tomHasTransed', tomTimerNum, 1);
	else -- otherwise just pretend we did turn around
		hasTurned = true;
	end
end

function onTweenCompleted(tag)
	if tag == 'mattGoOverHereX' then -- when matt finishes leaving the house
		setProperty('matt.x', getProperty('matt.x')-90);
		updateHitbox('matt');
		canSnap = true;
		objectPlayAnimation('matt', 'mattSnap', true);
	elseif tag == 'tomGoOverHereX' then --ditto but tom
		setProperty('tom.offset.x', -20);
		objectPlayAnimation('tom', 'tomTrans', false);
		runTimer('tomHasArrived', 0.35, 1);
	end
end

function onBeatHit() 
	if curBeat % 2 == 0 then
		if canSnap == true then -- matt's animations
			objectPlayAnimation('matt', 'matt'..snapType, true);
		end
		if canBop == true then -- tom's animations
			if hasTurned == true then --if he turned around, play his bop anim
				objectPlayAnimation('tom', 'tom'..tomLookAt, true);
			end
		end
		if movedMatt == false and snapType == 'PISSED' then
			movedMatt = true;
			setProperty('matt.offset.x', -40);
		end
	end
	if canBop == true then -- makes tom turn on time
		if not mustHit == mustHitSection then -- upon changing to a section where you play or not
			transGener();
		end
	end
	mustHit = mustHitSection;
end
function onUpdatePost(elapsed)
	if difficulty ~= 0 and tordExploded == true then
		if getProperty('tom.animation.curAnim.finished') == true then -- TOM ANIMATIONS
			if talkingTom == false then
				if getProperty('tom.animation.curAnim.name') == 'tomHarpoonIdle'then
					objectPlayAnimation('tom', 'tomHarpoonIdle', false);
				elseif getProperty('tom.animation.curAnim.name') == 'tomHarpoonTalk-ended' or getProperty('tom.animation.curAnim.name') == 'tomHarpoonTalk-final' then
					objectPlayAnimation('tom', 'tomHarpoonTalk-ended', false);
				end
			else
				if getProperty('tom.animation.curAnim.name') == 'tomHarpoonTurn' or getProperty('tom.animation.curAnim.name') == 'tomHarpoonTalk' then
					objectPlayAnimation('tom', 'tomHarpoonTalk', false);
				end
			end
		end
		if getProperty('matt.animation.curAnim.finished') == true then -- MATT ANIMATIONS
			if getProperty('matt.animation.curAnim.name') == 'mattAfterIdle' then
				objectPlayAnimation('matt', 'mattAfterIdle', false);
			elseif string.find(getProperty('matt.animation.curAnim.name'), 'mattRelief') then
				objectPlayAnimation('matt', 'mattRelief-idle', false);
			end
		end
		if getProperty('eddCutscene.animation.curAnim.finished') == true then --EDD ANIMATIONS
			--if talkingTom == false then
				if getProperty('eddCutscene.animation.curAnim.name') == 'lookRobot' then
					objectPlayAnimation('eddCutscene', 'lookRobot', false);
				elseif getProperty('eddCutscene.animation.curAnim.name') == 'lookTom' or getProperty('eddCutscene.animation.curAnim.name') == 'turnTom' then
					objectPlayAnimation('eddCutscene', 'lookTom', false);
				end
			--end
		end
	end
end
local tordbotFuncs = {
	['rise'] = function(value2)
		canSnap = false;
		objectPlayAnimation('matt', 'mattSurprise', false);
		setProperty('matt.offset.x', -moveMattByThis-40);
		runTimer('tomIsTooLate', 0.6);
		--edd and bf Reacting
		triggerEvent('Play Animation', 'groundShaking', 'edd');
		triggerEvent('Alt Idle Animation', 'dad', '-none'); --makes it so edd doesn't change back to his idle animation
		setProperty('boyfriend.visible', false);
		setProperty('bfCutscene.x', getProperty('boyfriend.x'));
		setProperty('bfCutscene.y', getProperty('boyfriend.y'));
		addLuaSprite('bfCutscene', true);
		objectPlayAnimation('bfCutscene', 'groundShaking', false);
		runTimer('lookTime', 1.5);
	end, ['beats'] = function(value2)
		if value2 ~= '0' then
			removeLuaSprite('matt', false);
			removeLuaSprite('tom', false);
			removeLuaSprite('bfCutscene', false);
		end
	end, ['finalCutscene-tom'] = function(value2)
		talkingTom = true;
		objectPlayAnimation('tom', 'tomHarpoonTurn', false);
		objectPlayAnimation('eddCutscene', 'turnTom', false);
		runTimer('shutUp-Smosh', 1.5, 1);
	end, ['finalCutscene-matt'] = function(value2)
		objectPlayAnimation('matt', 'mattRelief', false);
	end
}

local eventFuncs = {
	['Eduardo Jumpscare'] = function(value1, value2)
		canSnap = false;
		canBop = false;
		objectPlayAnimation('matt', 'mattJumpscare', false);
		setProperty('matt.offset.x', -moveMattByThis-40);
		objectPlayAnimation('tom', 'tomJumpscare', false);
	end,['Tordbot'] = function(value1, value2)
		tordbotFuncs[value1](value2)
	end, ['Tord in the BG'] = function(value1, value2)
		if value1 == 'explode' then
			tordExploded = true;
			addLuaSprite('matt');
			setProperty('matt.x', getProperty('matt.x')-10);
			setProperty('matt.y', getProperty('matt.y')+15);
			addLuaSprite('bfCutscene', true);
			setObjectOrder('bfCutscene', getObjectOrder('car')-2);
			setProperty('bfCutscene.x', getProperty('bfCutscene.x')+70);
			setProperty('bfCutscene.y', getProperty('bfCutscene.y')+10);
			addLuaSprite('tom', true);
			setObjectOrder('tom', getObjectOrder('car')-1);
			scaleObject('tom', 1.05, 1.05);
			setProperty('tom.x', 560);
			setProperty('tom.y', 380);
			addLuaSprite('eddCutscene', true);
			setObjectOrder('eddCutscene', getObjectOrder('bfCutscene'));
			setProperty('eddCutscene.x', defaultOpponentX+65);
			setProperty('eddCutscene.y', defaultOpponentY+85);
			objectPlayAnimation('bfCutscene', 'lookUp', false);
			objectPlayAnimation('eddCutscene', 'lookRobot', false);
			objectPlayAnimation('matt', 'mattAfterIdle', false);
			objectPlayAnimation('tom', 'tomHarpoonIdle', false);
		end
	end
}

function onEvent(name,value1,value2)
	eventFuncs[name](value1, value2);
end