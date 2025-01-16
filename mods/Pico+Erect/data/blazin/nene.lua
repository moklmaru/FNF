function onCreate()
	addLuaScript('data/blazin/real/s')
	addLuaScript('data/blazin/real/s2')
	n = 0.95
	o=false
	xd=18
eaa=954
e2=1164

	makeLuaSprite('abot', 'abot/nene', 998, 1164)
	addLuaSprite('abot', false);
	scaleObject('abot',0.55,0.55)
	setProperty('spritemap2.alpha',0)

	makeAnimatedLuaSprite('sss4', 'abot/aBotViz', 1148,1518);
	addAnimationByIndices('sss4', 'god', 'viz1', '0,1,2,3,4,5', 24, false)
	addAnimationByPrefix('sss4', 'idle', 'viz1', xd,  o);
	scaleObject('sss4', n,n)
	scaleObject('sss4',0.55,0.55)
	addLuaSprite('sss4', false);

	makeAnimatedLuaSprite('sss42', 'abot/aBotViz', 1182,1516);
	addAnimationByIndices('sss42', 'god', 'viz2', '1,2,3,4,5', 24, false)
	addAnimationByPrefix('sss42', 'idle', 'viz2', xd,  o);
	scaleObject('sss42',  n,n)
	scaleObject('sss42',0.55,0.55)
	addLuaSprite('sss42', false);

	makeAnimatedLuaSprite('sss43', 'abot/aBotViz',1212,1510);
	addAnimationByIndices('sss43', 'god', 'viz3', '2,3,4,5', 24, false)

	addAnimationByPrefix('sss43', 'idle', 'viz3', xd, o);
	scaleObject('sss43',  n,n)
	scaleObject('sss43',0.55,0.55)
	addLuaSprite('sss43', false);

	makeAnimatedLuaSprite('sss44', 'abot/aBotViz', 1288,1510);
	addAnimationByIndices('sss44', 'god', 'viz4', '3,4,5', 24, false)

	addAnimationByPrefix('sss44', 'idle', 'viz4', xd,  o);
	scaleObject('sss44',  n,n)
	scaleObject('sss44',0.55,0.55)
	addLuaSprite('sss44', false);

	makeAnimatedLuaSprite('sss45', 'abot/aBotViz', 1318,1510);
	addAnimationByIndices('sss45', 'god', 'viz5', '4,5', 24, false)
	scaleObject('sss45',0.55,0.55)
	addAnimationByPrefix('sss45', 'idle', 'viz5', xd,  o);
	addLuaSprite('sss45', false);

	makeAnimatedLuaSprite('sss6', 'abot/aBotViz', 1344,1514);
	addAnimationByIndices('sss6', 'god', 'viz1', '5', 24, false)
	addAnimationByPrefix('sss6', 'idle', 'viz1', xd, o);
	scaleObject('sss6', n, n)
	scaleObject('sss6',0.55,0.55)
	setProperty('sss6.flipX',true)
	addLuaSprite('sss6', false);

	makeLuaSprite('INTRO2', '', 90, 645)
luaSpriteMakeGraphic('INTRO2', 3000, 2001, '000000')
addLuaSprite('INTRO2', false)
setObjectOrder('INTRO2',getObjectOrder('gfGroup'))
setProperty('INTRO2.alpha',0.2)
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'beat' then
		playAnim('sss4', 'god',false)
		playAnim('sss42','god',false)
		playAnim('sss43','god',false)
		playAnim('sss44','god',false)
		playAnim('sss45','god',false)
		playAnim('sss6', 'god',false)
	end
	if noteType == 'beat2' then
		playAnim('sss4', 'god2',false)
		playAnim('sss42','god2',false)
		playAnim('sss43','god2',false)
		playAnim('sss44','god2',false)
		playAnim('sss45','god2',false)
		playAnim('sss6', 'god2',false)
	end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'beat' then
		playAnim('sss4', 'god',false)
		playAnim('sss42','god',false)
		playAnim('sss43','god',false)
		playAnim('sss44','god',false)
		playAnim('sss45','god',false)
		playAnim('sss6', 'god',false)
	end
	if noteType == 'beat2' then
		playAnim('sss4', 'god2',false)
		playAnim('sss42','god2',false)
		playAnim('sss43','god2',false)
		playAnim('sss44','god2',false)
		playAnim('sss45','god2',false)
		playAnim('sss6', 'god2',false)
	end
end

function onEvent(n)
	if n == 'bit3' then
		runTimer('xd', 0.75)
		runTimer('xd2',0.65)
		runTimer('xd3',0.55)
		runTimer('xd4',0.45)
		runTimer('xd5',0.35)
		runTimer('xd6',0.25)
	end
	if n == 'bit4' then
		runTimer('xd', 0.65)
		runTimer('xd2',0.45)
		runTimer('xd3',0.25)
		runTimer('xd4',0.35)
		runTimer('xd5',0.55)
		runTimer('xd6',0.75)
	end
	if n == 'bit2' then
		runTimer('xd', 0.25)
		runTimer('xd2',0.35)
		runTimer('xd3',0.45)
		runTimer('xd4',0.55)
		runTimer('xd5',0.65)
		runTimer('xd6',0.75)
	end
	if n == 'bit' then
		playAnim('sss4','idle',true)
		playAnim('sss42','idle',true)
		playAnim('sss43','idle',true)
		playAnim('sss44','idle',true)
		playAnim('sss45','idle',true)
		playAnim('sss6','idle',true)
	end
end
function onBeatHit()
	if curStep <1408 then
	if curBeat % 2 == 0 then
		triggerEvent('bit2')
	end
	if curBeat % 4 == 0 then
		triggerEvent('bit')

	end
	if curBeat % 6 == 0 then
		triggerEvent('bit3')

	end
	if curBeat % 8 == 0 then
		triggerEvent('bit4')
	end
	end
end
function onMoveCamera(focus)
    if focus == 'boyfriend' then
		runTimer('2x',0.5)
    elseif focus == 'gf' then
		runTimer('1x',0.5)
    end
end
function onTimerCompleted(ta)
	if ta== 'xd' then
		playAnim('sss4','idle',true)
	end
	if ta == 'xd2' then
		playAnim('sss42','idle',true)
	
	end
	if ta == 'xd3' then
		playAnim('sss43','idle',true)
		
	end
	if ta == 'xd4' then
		playAnim('sss44','idle',true)
		
	end
	if ta == 'xd5' then
		playAnim('sss45','idle',true)
		
	end
	if ta== 'xd6' then
		playAnim('sss6','idle',true)
	end
	if ta == '1x' then
		setProperty('spritemap1.alpha',1)
		setProperty('spritemap2.alpha',0)

	end
	if ta == '2x' then
		setProperty('spritemap1.alpha',0)
		setProperty('spritemap2.alpha',1)
	end
end
function onUpdate()

	setProperty('gf.x',988)
	setProperty('gf.y',1180)
	setProperty('gf.scale.x',0.55)
	setProperty('gf.scale.y',0.55)
	if getProperty('health')>0.01 then
		setProperty('cameraSpeed',999)
			end
end