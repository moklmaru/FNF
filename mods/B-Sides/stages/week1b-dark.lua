function onCreate()
	if not lowQuality then
		makeLuaSprite('lights', 'stages/week1b/lights', -250, -150);
		makeLuaSprite('lightBeams', 'stages/week1b/lightBeams', -50, -25);
		makeLuaSprite('curtains-dark', 'stages/week1b/curtains-dark', -400, -400);

		makeLuaSprite('curtains', 'stages/week1b/curtains', -400, -400);
		makeLuaSprite('lights-dark', 'stages/week1b/lights-dark', -250, -150);
	end

	makeLuaSprite('wall', 'stages/week1b/wall', -600, -300);
	makeLuaSprite('floor', 'stages/week1b/floor', -650, 600);

	addLuaSprite('wall', false);
	addLuaSprite('floor', false);
	addLuaSprite('curtains', true);
	addLuaSprite('lights', true);

	setScrollFactor('wall', 1, 1);
	setScrollFactor('floor', 1, 1);
	setScrollFactor('curtains', 1.3, 1.3);
	setScrollFactor('lights', 1.1, 1.1);

	scaleObject('curtains', 0.9, 0.9);
	scaleObject('floor', 1.1, 1.1);

	makeLuaSprite('wall-dark', 'stages/week1b/wall-dark', -600, -300);

	makeAnimatedLuaSprite('floor-dark', 'stages/week1b/floor-dark', -650, 600);
	luaSpriteAddAnimationByPrefix('floor-dark', 'idle', 'floor', 10, true);


	setScrollFactor('wall-dark', 1, 1);
	setScrollFactor('floor-dark', 1, 1);
	setScrollFactor('lights-dark', 1.1, 1.1);
	setScrollFactor('curtains-dark', 1.3, 1.3);
	setScrollFactor('lightBeams', 1.1, 1.1);

	scaleObject('curtains-dark', 0.9, 0.9);
	scaleObject('floor-dark', 1.1, 1.1);

	addLuaSprite('wall-dark', false);
	addLuaSprite('floor-dark', false);
	addLuaSprite('curtains-dark', true);
	addLuaSprite('lights-dark', true);
	addLuaSprite('lightBeams', true);

 	setProperty('lights-dark.alpha', 0);
 	setProperty('wall-dark.alpha', 0);
 	setProperty('floor-dark.alpha', 0);
 	setProperty('lightBeams.alpha', 0);
 	setProperty('curtains-dark.alpha', 0);

end

function onBeatHit()
	luaSpritePlayAnimation('floor', 'idle', true);
end

function onStepHit()
	if curStep == 256 then
		playSound('bigLightHit', 100)

 		setProperty('wall.alpha', 0)
		setProperty('floor.alpha', 0)
		setProperty('curtains.alpha', 0)
		setProperty('lights.alpha', 0)

 		setProperty('lights-dark.alpha', 1)
 		setProperty('wall-dark.alpha', 1)
 		setProperty('floor-dark.alpha', 1)
 		setProperty('lightBeams.alpha', 1)
 		setProperty('curtains-dark.alpha', 1)
	end
end