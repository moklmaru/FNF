function onSongStart() 
	if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Song Name' then
		if string.lower(songName) == 'challengedd fucked' then
			setProperty('timeTxt.text', 'End Mix');
		elseif string.lower(songName) == 'challengedd' then
			setProperty('timeTxt.text', 'Neighbores Mix');
		end
	end
end