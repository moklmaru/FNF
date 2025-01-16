local timing = 0.4;
local moveX = 90;
local moveY = 25;
local swapped = false;
local canMove = false;
local easeType = 'quartOut';

local eventFuncs = {
	['change icon'] = function(value1, value2)
		if value1:lower() == 'p2' and (value2:lower() == 'eduardo' or value2:lower() == 'tord') and not hideHud then
			print("wow")
			makeLuaSprite('fakeicon', 'icons/edd', getProperty('iconP2.x'), getProperty('iconP2.y'));
			setObjectCamera('fakeicon', 'hud');
			setObjectOrder('fakeicon', getObjectOrder('healthBar')+1);
			--setObjectOrder('iconP1', getObjectOrder('iconP1') + 1);
			updateHitbox("fakeicon")
			loadGraphic('fakeicon', 'icons/edd', getProperty("fakeicon.width") / 2, getProperty("fakeicon.height"));
			addAnimation("fakeicon", "icon", { 0, 1 }, 0, false)
			playAnim("fakeicon", "icon", true)
			addLuaSprite('fakeicon', true);
			setProperty('fakeicon.scale.x', getProperty('iconP1.scale.x'));
			setProperty('fakeicon.scale.y', getProperty('iconP1.scale.y'));
			if not downscroll then
				moveY = -38
			end
			setProperty("fakeicon.x", getProperty('iconP2.x'))
			setProperty("fakeicon.y", getProperty('iconP2.y'))
			doTweenX('fakeMoveX1', 'fakeicon', getProperty('iconP1.x') + moveX, timing, easeType);
			doTweenY('fakeMoveY1', 'fakeicon', getProperty('healthBar.y') - (getProperty("fakeicon.height") / 2) + moveY, timing, easeType);
			runTimer('iconSwap', timing/3, 1);
		end
	end
}

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'iconSwap' then
		setProperty('fakeicon.flipX', true);
		swapped = true;
	end
end

function onTweenCompleted(tag)
	if tag == 'fakeMoveX1' then -- only doing one tween here
		canMove = true;
	end
end

function onEvent(name, value1, value2)
	eventFuncs[name](value1, value2);
end

function onUpdate(elapsed)
	if swapped == true then
		setProperty("fakeicon.animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame"))
	end
end

function onUpdatePost(elapsed)
	setProperty('fakeicon.angle', getProperty('iconP1.angle'));
	setProperty('fakeicon.scale.x', getProperty('iconP1.scale.x'));
	setProperty('fakeicon.scale.y', getProperty('iconP1.scale.y'));
	updateHitbox("fakeicon")
	if canMove == true then
		setProperty('fakeicon.x', getProperty('iconP1.x') + moveX);
		setProperty('fakeicon.y', getProperty('healthBar.y') - (getProperty("fakeicon.height") / 2) + moveY);
	end
	
end