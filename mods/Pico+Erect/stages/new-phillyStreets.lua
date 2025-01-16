omg=false
function onCreate()
    makeLuaSprite('skybox', 'phillyStreets/phillySkybox', -700, -200)
    addLuaSprite('skybox', false)
    setScrollFactor('skybox', 0.3, 0.3)
    scaleObject('skybox', 2, 2)

    makeLuaSprite('skyline', 'phillyStreets/phillySkyline', -700, -300)
    addLuaSprite('skyline', false)
    setScrollFactor('skyline', 0.3, 0.3)
    scaleObject('skyline', 2, 2)

    makeLuaSprite('foregroundCity', 'phillyStreets/phillyForegroundCity', 350, -20)
    addLuaSprite('foregroundCity', false)
    setScrollFactor('foregroundCity', 0.4, 0.4)
    scaleObject('foregroundCity', 2, 2)

    makeLuaSprite('construction', 'phillyStreets/phillyConstruction', 1000, -150)
    addLuaSprite('construction', false)
    setScrollFactor('construction', 0.6, 0.6)
    scaleObject('construction', 2, 2)

    makeLuaSprite('smog', 'phillyStreets/phillySmog', -1000, -200)
    addLuaSprite('smog', false)
    setScrollFactor('smog', 0.8, 0.8)
    scaleObject('smog', 2, 2)

    makeLuaSprite('highway', 'phillyStreets/phillyHighway', -1050, -250)
    addLuaSprite('highway', false)
    setScrollFactor('highway', 1.0, 1.0)
    scaleObject('highway', 2, 2)

    makeAnimatedLuaSprite('phillyCars1', 'phillyStreets/phillyCars', 620,40);
	addAnimationByPrefix('phillyCars1', 'car1', 'car1', 24, false);
	addAnimationByPrefix('phillyCars1', 'car2', 'car2', 24, false);
	addAnimationByPrefix('phillyCars1', 'car3', 'car3', 24, false);
	addAnimationByPrefix('phillyCars1', 'car4', 'car4', 24, false);
	setProperty('phillyCars1.flipX', false);
	scaleObject('phillyCars1', 1, 1);
	setScrollFactor('phillyCars1', 1, 1);
	setProperty('phillyCars1.alpha', 1);

	makeAnimatedLuaSprite('phillyCars2', 'phillyStreets/phillyCars', 620,40);
	addAnimationByPrefix('phillyCars2', 'car1', 'car1', 24, false);
	addAnimationByPrefix('phillyCars2', 'car2', 'car2', 24, false);
	addAnimationByPrefix('phillyCars2', 'car3', 'car3', 24, false);
	addAnimationByPrefix('phillyCars2', 'car4', 'car4', 24, false);
	setProperty('phillyCars2.flipX', true);
	scaleObject('phillyCars2', 1, 1);
	setScrollFactor('phillyCars2', 1, 1);
	setProperty('phillyCars2.alpha', 1);
    addLuaSprite('phillyCars1', false);
    addLuaSprite('phillyCars2', false);

    makeLuaSprite('foreground', 'phillyStreets/phillyForeground', -1100, -100)
    addLuaSprite('foreground', false)
    setScrollFactor('foreground', 1.0, 1.0)
    scaleObject('foreground', 1, 1)

    makeLuaSprite('spraycanPile', 'phillyStreets/SpraycanPile', -270, 630)
    addLuaSprite('spraycanPile', true)
    setScrollFactor('spraycanPile', 1.0, 1.0)
    scaleObject('spraycanPile', 1, 1)


    makeAnimatedLuaSprite('trafficLight', 'phillyStreets/phillyTraffic', 840, 148)
    addAnimationByPrefix('trafficLight', 'tored', 'greentored', 24, false)
    addAnimationByPrefix('trafficLight', 'togreen', 'redtogreen', 24, false)
    setProperty('trafficLight.flipX', false)
    scaleObject('trafficLight', 1, 1)
    setScrollFactor('trafficLight', 0.9, 1)
    addLuaSprite('trafficLight', false)
	playAnim('trafficLight', 'togreen', false);
	runTimer('greentoredTimer', 11);

	makeLuaSprite('phillyTraffic_lightmap', 'phillyStreets/erect/phillyTraffic_lightmap',812,144)
    addLuaSprite('phillyTraffic_lightmap',false)
    setScrollFactor('phillyTraffic_lightmap', 0.9, 1.0)
    scaleObject('phillyTraffic_lightmap', 1, 1)
    setBlendMode('phillyTraffic_lightmap','add')
    setProperty('phillyTraffic_lightmap.alpha',0.8)
	
setProperty('phillyCars1.x', 620);
setProperty('phillyCars1.y', 60);
setProperty('phillyCars1.angle', -20);
setProperty('phillyCars2.x', 620);
setProperty('phillyCars2.y', 60);
setProperty('phillyCars2.angle', 30);

runTimer('leftCarTween1', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
runTimer('rightCarTween', getRandomInt(25,55) *0.1, getRandomInt(1, 2));
end
local Light = 0
local carWaiting = 0
local Car1variant = 0
local Car1speed = 1.3
local Car2variant = 0
local Car2speed = 1.3
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'redtogreenTimer' then
		Light = 0
		playAnim('trafficLight', 'togreen', false);
		runTimer('greentoredTimer', 9);  
		runTimer('leftCarTween1', getRandomInt(25, 45) * 0.1, getRandomInt(1, 2)); 
		runTimer('rightCarTween', getRandomInt(25, 45) * 0.1, getRandomInt(1, 2)); 
		if carWaiting == 1 then
			carWaiting = 0
			runTimer('leftCarTween11', 0.5);
		end
	end
	if tag == 'leftCarTween11' then
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', 30, 1.7, 'sineIn');
	end
	if tag == 'greentoredTimer' then
		Light = 1
		playAnim('trafficLight', 'tored', false);
		runTimer('redtogreenTimer', 7);  
		runTimer('leftCarTween2', getRandomInt(25, 45) * 0.1); 
	end
	if tag == 'leftCarTween1' then
		Car1variant = getRandomInt(1, 4)
		if Car1variant == 1 then
			Car1speed = getRandomInt(10, 17) * 0.1
		elseif Car1variant == 2 then
			Car1speed = getRandomInt(9, 15) * 0.1
		elseif Car1variant == 3 then
			Car1speed = getRandomInt(15, 25) * 0.1
		elseif Car1variant == 4 then
			Car1speed = getRandomInt(15, 25) * 0.1
		end
		playAnim('phillyCars1', 'car' .. Car1variant, false);
		setProperty('phillyCars1.angle', -20);
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', 30, 1.7, 'linear');
	end
	if tag == 'leftCarTween2' then
		carWaiting = 1
		Car1variant = getRandomInt(1, 4)
		playAnim('phillyCars1', 'car' .. Car1variant, false);
		setProperty('phillyCars1.angle', -20);
		doTweenAngle('phillyCars1TweenAngle', 'phillyCars1', -5, 1.7, 'sineOut');
	end
	if tag == 'rightCarTween' then
		Car2variant = getRandomInt(1, 4)
		if Car2variant == 1 then
			Car2speed = getRandomInt(10, 17) * 0.1
		elseif Car2variant == 2 then
			Car2speed = getRandomInt(9, 15) * 0.1
		elseif Car2variant == 3 then
			Car2speed = getRandomInt(15, 25) * 0.1
		elseif Car2variant == 4 then
			Car2speed = getRandomInt(15, 25) * 0.1
		end
		playAnim('phillyCars2', 'car' .. Car2variant, false);
		setProperty('phillyCars2.angle', 30);
		doTweenAngle('phillyCars2TweenAngle', 'phillyCars2', -20, Car2speed, 'linear');
	end
end
