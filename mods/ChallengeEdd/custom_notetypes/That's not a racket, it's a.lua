function onCreate()
	--precacheImage('notes/rocket');
	precacheImage('notes/i-hope-you-explode');
	precacheImage('notes/rocket');
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == "That's not a racket, it's a" then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/rocket'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '500'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'multSpeed', 1.5);
			setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
			if downscroll then
				setPropertyFromGroup('unspawnNotes', i, 'flipY', true);
				setPropertyFromGroup('unspawnNotes', i, 'offset.y', getPropertyFromGroup('unspawnNotes', i, 'height')-30);
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote) -- explosion
	if noteType == "That's not a racket, it's a" then
		makeLuaSprite('explosion'..noteData, 'notes/i-hope-you-explode', getPropertyFromGroup('notes', id, 'x'), getPropertyFromGroup('notes', id, 'y'));
		loadFrames('explosion'..noteData, 'notes/i-hope-you-explode', 'sparrow');
		updateHitbox('explosion'..noteData);
		setProperty('explosion'..noteData..'.offset.x', math.floor(getProperty('explosion'..noteData..'.width')/3.3));
		if downscroll then
			setProperty('explosion'..noteData..'.offset.y', math.floor(getProperty('explosion'..noteData..'.height')/3.3));
		else
			setProperty('explosion'..noteData..'.offset.y', math.floor(getProperty('explosion'..noteData..'.height')/3.3));
		end
		addAnimationByPrefix('explosion'..noteData, 'boom', 'Explosion', 24, false);
		setObjectOrder('explosion'..noteData, getObjectOrder('note'));
		setObjectCamera('explosion'..noteData, 'hud');
		addLuaSprite('explosion'..noteData, true);
		objectPlayAnimation('explosion'..noteData, 'explode', true);
	end
end
function onUpdate(elapsed)
	for i = 0, 3 do
		if getProperty('explosion'..i..'.animation.curAnim.finished') == true then
			removeLuaSprite('explosion'..i, false);
		end
	end
end