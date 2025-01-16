xd=400
yd=100
skibidi=0.0001
local memuerotio = false
function onCreate()
	n = 0.95
	o=false
	setProperty('camZooming', true)
	sexo = tostring(math.random(0, 5))

end
function onTimerCompleted(ta)
	
	if ta == 'kxd' then
        setProperty('NeneKnifeToss.alpha',0)
    end
	if ta == 'ded' then
 
		makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1130,200-30);
		addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true);
		addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
		scaleObject('dead', 1,1)
		setObjectOrder('dead',999)
		addLuaSprite('dead', false);
	end
	if ta == 'loop' then
		playAnim('Pico_Death', 'loop',true)
	end
end
function onGameOverStart()
   setProperty('boyfriend.x',780)
    setProperty('boyfriend.y',144)
    makeAnimatedLuaSprite('NeneKnifeToss', 'characters/NeneKnifeToss',getProperty('boyfriend.x')-400,getProperty('boyfriend.y')-200);
	addAnimationByPrefix('NeneKnifeToss', 'a', 'knife toss', 24, false)
	scaleObject('NeneKnifeToss', 1,1)
    setObjectOrder('NeneKnifeToss',998)
	addLuaSprite('NeneKnifeToss', false);
	        --
			setProperty('camHUD.alpha',0)
			makeAnimatedLuaSprite('Pico_Death', 'characters/Pico_Death',700,150);
			addAnimationByIndices('Pico_Death', 'start', 'Pico Death Stab', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50', 24, false);
			addAnimationByIndices('Pico_Death', 'loop', 'Pico Death Stab', '50,51,52,53,54,55,56,57,58,59,60,61,62,63,64', 24, true);
			scaleObject('Pico_Death', 1,1)
		
			addLuaSprite('Pico_Death', false);
			runTimer('loop',2.08)
			playAnim('Pico_Death', 'start',true)
			--
runTimer('ded',1.4)
runTimer('kxd',0.75)
end
function onGameOverConfirm(retry)
    makeAnimatedLuaSprite('dead', 'characters/Pico_Death_Retry', 1170,200-30);
	addAnimationByPrefix('dead', 'a', 'Retry Text Confirm', 24, false)
	addAnimationByPrefix('dead', 'a2', 'Retry Text Loop', 24, true);
	scaleObject('dead', 1,1)
    cancelTimer('ded')
    setObjectOrder('dead',999)
	addLuaSprite('dead', false);
playAnim('dead','a',true)
setProperty('dead.x',900)
setProperty('dead.y',-50)
end
function onUpdate()
	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'pico-dead2')
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pico')
	setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pico');
	setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pico');
    local health = getProperty('health')
    if getProperty('gf.animation.curAnim.finished') and getProperty('gf.animation.curAnim.name') == 'knifeRaise' and memuerotio then
        triggerEvent('Play Animation', 'knife', 'gf')
    end

    if health < 0.5 and not memuerotio then
        memuerotio = true
        triggerEvent('Play Animation', 'knifeRaise', 'gf')
    elseif health >= 0.5 and memuerotio then
        memuerotio = false
        triggerEvent('Play Animation', 'knifelower', 'gf')
    end

	setProperty('gf.x',34+400)
	setProperty('boyfriend.y',430)
	setProperty('boyfriend.x',950)
	setProperty('gf.y',-8+100)
end