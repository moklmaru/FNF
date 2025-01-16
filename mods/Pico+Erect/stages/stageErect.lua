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
function onUpdate()
	setSpriteShader('dad', 'adjustColor')
	setShaderFloat('dad', 'hue', -30)
	setShaderFloat('dad', 'saturation', -20)
	setShaderFloat('dad', 'contrast', 0)
	setShaderFloat('dad', 'brightness', -30)

	setSpriteShader('gf', 'adjustColor')
	setShaderFloat('gf', 'hue', -9)
	setShaderFloat('gf', 'saturation', 0)
	setShaderFloat('gf', 'contrast', -4)
	setShaderFloat('gf', 'brightness', -30)

	setSpriteShader('boyfriend', 'adjustColor')
	setShaderFloat('boyfriend', 'hue', 12)
	setShaderFloat('boyfriend', 'saturation', 0)
	setShaderFloat('boyfriend', 'contrast', 7)
	setShaderFloat('boyfriend', 'brightness', -23)

end
--
function onBeatHit()
	  if songName ~= 'DadBattle Erect' then
		if curBeat % 2 == 0 and curBeat % 4 ~= 0 then
		  triggerEvent('Add Camera Zoom', '', '0.025')
		end
	  else
		if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		  triggerEvent('Add Camera Zoom', '', '0.035')
		end
		if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		  triggerEvent('Add Camera Zoom', '', '0.035')
		end
		if curBeat % 4 == 0 then
		  triggerEvent('Add Camera Zoom', '', '0.01')
		end
	  end
	end

  
  zoom1 = false
  zoom2 = false
  
  function onEvent(eventName, v1)

	  if eventName == 'Screen Shake' then
		if v1 == '1' then
		  zoom1 = true
		  zoom2 = false
		elseif v1 == '2' then
		  zoom1 = false
		  zoom2 = true
		elseif v1 == '3' then
		  zoom1 = false
		  zoom2 = false
		end
	  elseif eventName == 'Set GF Speed' then
		if v1 == 'g' then
		  if songName ~= 'DadBattle Erect' then
			triggerEvent('Camera Follow Pos', '650', '320')
		  else
			triggerEvent('Camera Follow Pos', '650', '350')
		  end
		elseif v1 == 'b' then
		  triggerEvent('Camera Follow Pos', '', '')
		elseif v1 == 'dad' then
		  triggerEvent('Camera Follow Pos', '630', '350')
		elseif v1 == 'bf' then
		  triggerEvent('Camera Follow Pos', '750', '350')
		end
	  end
	end
  