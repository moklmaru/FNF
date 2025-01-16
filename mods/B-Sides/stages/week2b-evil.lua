function onCreate()

	makeLuaSprite('d', 'dark', 0, 0)
	scaleObject('d', 4, 4)
	setLuaSpriteScrollFactor('d', 1, 1)
	addLuaSprite('d', true)

	makeLuaSprite('bge', 'stages/week2b/bg-evil', 0, 0)
	scaleObject('bge', 2, 2)
	setLuaSpriteScrollFactor('bge', 1, 1)
	addLuaSprite('bge', false)

	makeAnimatedLuaSprite('cabinetse', 'stages/week2b/cabinets-evil', 600, 865)
	scaleObject('cabinetse', 1, 1)
	setLuaSpriteScrollFactor('cabinetse', 1, 1)
	addAnimationByPrefix('cabinetse', 'bop', 'cabinets', 24, true)
	addLuaSprite('cabinetse', false)

	makeLuaSprite('vigen', 'stages/week2b/vignette', 0, 0)
	scaleObject('vigen', 3.2, 3.2)
	setLuaSpriteScrollFactor('vigen', 1, 1)
	setObjectCamera('vigen', 'other')
	setObjectOrder('vigen', 69)
	setProperty('vigen.alpha', 0)
	addLuaSprite('vigen', true)

--regular--
	makeLuaSprite('bg', 'stages/week2b/bg', 0, 0)
	scaleObject('bg', 2, 2)
	setLuaSpriteScrollFactor('bge', 1, 1)
	addLuaSprite('bg', false)

	makeAnimatedLuaSprite('cabinets', 'stages/week2b/cabinets', 470, 770)
	scaleObject('cabinets', 1, 1)
	setLuaSpriteScrollFactor('cabinets', 1, 1)
	addAnimationByPrefix('cabinets', 'bop', 'cabinets', 24, true)
	addLuaSprite('cabinets', false)
--other--
	makeLuaSprite('bl', '', 0, 0)
	makeGraphic('bl', 1280, 720, '000000')
	scaleObject('bl', 1, 1)
	setLuaSpriteScrollFactor('bl', 1, 1)
	setObjectCamera('bl', 'other')
	setProperty('bl.alpha', 0)
	addLuaSprite('bl', false)
end

function onStepHit()
	if curStep == 248 then
		setProperty('bl.alpha', 1)
	elseif curStep == 252 then
		setProperty('bg.alpha', 0)
		setProperty('plar1.alpha', 0)
		setProperty('plar2.alpha', 0)
		setProperty('cabinets.alpha', 0)
		setProperty('vigen.alpha', 0.7)
		setCharacterX('boyfriend', 1535)
		setCharacterY('boyfriend', 870)
		setProperty('gf.alpha', 0)
		setCharacterX('dad', 730)
		setCharacterY('dad', 490)
		setObjectOrder('dadGroup', 69)
	elseif curStep == 256 then
		setProperty('bl.alpha', 0)
	elseif curStep == 1408 then
		cameraFlash('other', '9E0D27', 1, false)
		setProperty('health', 0.001)
	elseif curStep == 1536 then
		setProperty('bl.alpha', 1)
	end
end