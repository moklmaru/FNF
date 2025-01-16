function onCreate()

	makeAnimatedLuaSprite('audience_front', 'backgrounds/BackStage/crowd', 700, 200);
	luaSpriteAddAnimationByPrefix('audience_front', 'audience_front', 'frontbop', '20')
	setLuaSpriteScrollFactor('audience_front', 0.9, 0.9);
	scaleObject('audience_front', 1, 1);
	
	makeLuaSprite('stageback', 'backgrounds/BackStage/back', 700, -200);
	scaleObject('stageback', 1.5, 1.5);

	makeLuaSprite('stagefront', 'backgrounds/BackStage/bg', -650, -475);
	scaleObject('stagefront', 1.2, 1.2);

	makeLuaSprite('stageserver', 'backgrounds/BackStage/server', -125, 150);
	scaleObject('stageserver', 1, 1);

	makeLuaSprite('stagelight', 'backgrounds/BackStage/lights', -650, -300);
	setLuaSpriteScrollFactor('stagelight', 1.2, 1.1);
	scaleObject('stagelight', 1.1, 1);
	
	addLuaSprite('stageback', false);
	addLuaSprite('audience_front', false);
	--
	makeLuaSprite('brightLightSmall', 'backgrounds/BackStage/brightLightSmall', 1100, -175);
	scaleObject('brightLightSmall', 1, 1);
	addLuaSprite('brightLightSmall', false);
	setBlendMode('brightLightSmall','add')
	setLuaSpriteScrollFactor('brightLightSmall', 1.2, 1.1);
	--
	addLuaSprite('stagefront', false);
	addLuaSprite('stageserver', false);
	addLuaSprite('stagelight', false);

	makeLuaSprite('orangeLight', 'backgrounds/BackStage/orangeLight', -125, -150);
	scaleObject('orangeLight', 2, 2);
	addLuaSprite('orangeLight', true);
	setObjectOrder('brightLightSmall',getObjectOrder('orangeLight')+1)
	setObjectOrder('stagelight',getObjectOrder('orangeLight')+2)
setBlendMode('orangeLight','add')
	
end