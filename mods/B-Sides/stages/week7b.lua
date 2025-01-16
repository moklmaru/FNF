function onCreatePost()	
	makeLuaSprite('tankSky', 'stages/week7b/sky', -675, -125);
	addLuaSprite('tankSky', false);

	makeLuaSprite('BGtint', 'stages/week7b/BGtint', 0, 350);
	scaleObject('BGtint', 1.5, 1.5);
	addLuaSprite('BGtint', false);
	setScrollFactor('BGtint', 1.05, 1);

	makeAnimatedLuaSprite('barPeople', 'stages/week7b/barPeople', 60, 415);
	scaleObject('barPeople', 0.7, 0.7);
	addLuaSprite('barPeople', false);
	setScrollFactor('barPeople', 1.05, 1);
	addAnimationByPrefix('barPeople', 'idle', 'mfs', 24, true);


	makeLuaSprite('bar', 'stages/week7b/bar', -100, 240);
	scaleObject('bar', 0.7, 0.7);
	setScrollFactor('bar', 1.05, 1);
	addLuaSprite('bar', false);

	makeLuaSprite('tankWalk', 'stages/week7b/sidewalk', -520, 625);
	addLuaSprite('tankWalk', false);


	makeLuaSprite('tankGround', 'stages/week7b/ground', -600, 700);
	scaleObject('tankGround', 1, 1);
	addLuaSprite('tankGround', false);

	makeAnimatedLuaSprite('bikeGuyLeft', 'stages/week7b/bikeGuyLeft', -600, 400);
	scaleObject('bikeGuyLeft', 1, 1);
	addLuaSprite('bikeGuyLeft', false);
	addAnimationByPrefix('bikeGuyLeft', 'idle', 'bikecolor instance', 24, false);
	addOffset('bikeGuyLeft', 'idle', 0, 0)

	makeAnimatedLuaSprite('bikeGuyRight', 'stages/week7b/bikeGuyRight', 1200, 400);
	scaleObject('bikeGuyRight', 1, 1);
	addLuaSprite('bikeGuyRight', false);
	addAnimationByPrefix('bikeGuyRight', 'idle', 'bikecolor2 instance', 24, false);
	addOffset('bikeGuyRight', 'idle', 0, 0)

	makeAnimatedLuaSprite('fgGuys', 'stages/week7b/fgGuys', -600, 950);
	scaleObject('fgGuys', 1.2, 1.2);
	addLuaSprite('fgGuys', true);
	addAnimationByPrefix('fgGuys', 'idle', 'buddiesGroup', 24, false);
	addOffset('fgGuys', 'idle', -200, 0)
	setScrollFactor('fgGuys', 1.5, 1.5);
end

function onBeatHit()
	playAnim('fgGuys', 'idle', true)
	playAnim('bikeGuyRight', 'idle', true)
	playAnim('bikeGuyLeft', 'idle', true)
end