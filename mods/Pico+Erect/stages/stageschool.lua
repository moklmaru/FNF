local daPixelZoom = 6
local isPissed = false
function onCreate()
	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-pixel-dead')
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pixel')
	
	makeLuaSprite('bgSky', 'weeb/weebSky', 0, -20)
	setScrollFactor('bgSky', 0.1, 0.1)
	setProperty('bgSky.antialiasing', false)
	
	repositionShit = -200
	
	makeLuaSprite('bgSchool', 'weeb/weebSchool', repositionShit, 0)
	setScrollFactor('bgSchool', 0.6, 0.90)
	setProperty('bgSchool.antialiasing', false)
	
	makeLuaSprite('bgStreet', 'weeb/weebStreet', repositionShit, 0)
	setScrollFactor('bgStreet', 0.95, 0.95)
	setProperty('bgStreet.antialiasing', false)
	
	widShit = getProperty('bgSky.width') * 6
	if not lowQuality then -- sprites that only load if lowQuality's off
		makeLuaSprite('fgTrees', 'weeb/weebTreesBack', repositionShit + 170, 130)
		setScrollFactor('fgTrees', 0.9, 0.9)
		setGraphicSize('fgTrees', widShit * 0.8)
		setProperty('fgTrees.antialiasing', false)
		
		makeAnimatedLuaSprite('treeLeaves', 'weeb/petals', repositionShit, -40)
		setScrollFactor('treeLeaves', 0.85, 0.85)
		addAnimationByPrefix('treeLeaves', 'P', 'PETALS ALL', true)
		setGraphicSize('treeLeaves', widShit)
		updateHitbox('treeLeaves')
		setProperty('treeLeaves.antialiasing', false)
		
		makeAnimatedLuaSprite('bgGirls', 'weeb/bgFreaks', -100, 190)
		setScrollFactor('bgGirls', 0.9, 0.9)
		setGraphicSize('bgGirls', getProperty('bgGirls.width') * daPixelZoom)
		addAnimationByIndices('bgGirls', 'danceLeft', 'BG girls group', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14', 24)
		addAnimationByIndices('bgGirls', 'danceRight', 'BG girls group', '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30', 24)
		objectPlayAnimation('bgGirls', 'danceLeft', true)
		setProperty('bgGirls.antialiasing', false)
	end
	
	makeAnimatedLuaSprite('weebTrees2', 'weeb/weebTrees2',-190, -20);
    setLuaSpriteScrollFactor('weebTrees2', 0.85, 0.85);		
	scaleObject('weebTrees2',6, 7)
	setProperty('weebTrees2.antialiasing', false)

	setGraphicSize('bgSky', widShit)
	setGraphicSize('bgSchool', widShit)
	setGraphicSize('bgStreet', widShit)
	
	updateHitbox('bgSky')
	updateHitbox('bgSchool')
	updateHitbox('bgStreet')
	
	
	addLuaSprite('bgSky', false)
	addLuaSprite('bgSchool', false)
	addLuaSprite('bgStreet', false)
	addLuaSprite('fgTrees', false)
	addLuaSprite('weebTrees2', false);
	addAnimationByPrefix('weebTrees2','idle', 'weebTrees2 idle',12,true);
	addLuaSprite('treeLeaves', false)
	addLuaSprite('bgGirls', false)
end

function onEvent(n)
	if n == 'BG Freaks Expression' then
		isPissed = true
		addAnimationByIndices('bgGirls', 'danceLeft', 'BG fangirls dissuaded', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14', 24)
		addAnimationByIndices('bgGirls', 'danceRight', 'BG fangirls dissuaded', '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30', 24)
		objectPlayAnimation('bgGirls', 'danceLeft')
	end
end

local danceDir = true
function onBeatHit()
	if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 4 == 0 and curStep >=1 then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	if not lowQuality then
		if danceDir then
			danceDir = false
			objectPlayAnimation('bgGirls', 'danceRight', true)
		else
			danceDir = true
			objectPlayAnimation('bgGirls', 'danceLeft', true)
		end
	end
end
zoom1=false
zoom2=false
function onEvent(eventName, v1)
	if eventName == 'Screen Shake' then
	  handleScreenShake(v1)
	elseif eventName == 'Set GF Speed' then
	  handleSetGFSpeed(v1)
	end
  end
  
  function handleScreenShake(value)
	if value == '1' then
	  zoom1 = true
	  zoom2 = false
	elseif value == '2' then
	  zoom1 = false
	  zoom2 = true
	elseif value == '3' then
	  zoom1 = false
	  zoom2 = false
	end
  end
  
  function handleSetGFSpeed(value)
	if value == 'g' then
	  triggerEvent('Camera Follow Pos', '620', '560')
	  setProperty("defaultCamZoom",0.925)
	elseif value == 'b' then
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
	  triggerEvent('Camera Follow Pos', '630', '480')
	elseif value == 'bf' then
		triggerEvent('Camera Follow Pos', '859', '600')
	end
  end
