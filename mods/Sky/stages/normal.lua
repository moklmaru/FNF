function onCreate()
	makeAnimatedLuaSprite('bg', 'bg/bg_normal', -320, -100)
	scaleObject('bg', 1.1, 1)
	addAnimationByPrefix('bg', 'anim', 'bg', 24, false)

	addLuaSprite('bg', false)
end

function onBeatHit()
	if curBeat % 4 == 2 then
		objectPlayAnimation('anim', true)
	end
end