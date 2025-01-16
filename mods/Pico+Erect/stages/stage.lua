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
zoom1=false
zoom2=false
function onEvent(eventName, v1)
  if eventName == 'Screen Shake' then
    if v1 == '1' then
zoom1=true
zoom2=false
    elseif v1 == '2' then
      zoom1=false
      zoom2=true
    elseif v1 == '3' then
      zoom1=false
      zoom2=false
    end
  elseif eventName == 'Set GF Speed' then
    if v1 == 'g' then
      if songName ~= 'DadBattle Erect' then
      triggerEvent('Camera Follow Pos', '650', '430')
      else
        triggerEvent('Camera Follow Pos', '650', '480')
      end
    elseif v1 == 'b' then
      triggerEvent('Camera Follow Pos', '', '')
    elseif v1 == 'dad' then
      triggerEvent('Camera Follow Pos', '630', '480')
    elseif v1 == 'bf' then
      triggerEvent('Camera Follow Pos', '750', '480')
    end
  end
end
function onCreate()
	makeLuaSprite('stageback', 'stage/stageback', -600, -300)
	setScrollFactor('stageback', 0.9, 0.9)
	
	makeLuaSprite('stagefront', 'stage/stagefront', -650, 600)
	setScrollFactor('stagefront', 0.9, 0.9)
	scaleObject('stagefront', 1.1, 1.1)
	
		makeLuaSprite('stagelight_left', 'stage/stage_light', -125, -100)
		setScrollFactor('stagelight_left', 0.9, 0.9)
		scaleObject('stagelight_left', 1.1, 1.1)
	
		makeLuaSprite('stagelight_right', 'stage/stage_light', 1225, -100)
		setScrollFactor('stagelight_right', 0.9, 0.9)
		scaleObject('stagelight_right', 1.1, 1.1)
		setProperty('stagelight_right.flipX', true) 

		makeLuaSprite('stagecurtains', 'stage/stagecurtains', -500, -300)
		setScrollFactor('stagecurtains', 1.3, 1.3)
		scaleObject('stagecurtains', 0.9, 0.9)

	addLuaSprite('stageback', false)
	addLuaSprite('stagefront', false)
	addLuaSprite('stagelight_left', false)
	addLuaSprite('stagelight_right', false)
	addLuaSprite('stagecurtains', false)
	
end