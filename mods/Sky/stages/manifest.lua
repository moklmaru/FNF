function onCreate()
	makeAnimatedLuaSprite('bg', 'bg/bg_manifest', -320, -100)
	scaleObject('bg', 1.1, 1)
	addAnimationByPrefix('bg', 'glitch', 'bg_manifest', 24, false)

	makeAnimatedLuaSprite('floor', 'bg/floorManifest', -320, -100)
	scaleObject('floor', 1.1, 1)
	addAnimationByPrefix('floor', 'idk', 'floorManifest', 24, false)

	addLuaSprite('bg', false)
	addLuaSprite('floor', false)
end

function onBeatHit()
	if curBeat % 2 == 1 then
		objectPlayAnimation('bg', 'glitch', true)
		objectPlayAnimation('floor', 'idk', true)
	end
end