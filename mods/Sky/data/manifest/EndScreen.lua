local cool = false
function onUpdate()
    if cool then
        if keyJustPressed('accept') then
            endSong()
        end
    end
end


function onEndSong()
    peanut = getRandomInt(1, 100);
    if isStoryMode then
	if peanut == 69 or (ratingName == '?' and botPlay == true) and not cool then
            playMusic('peanut', 1)
            makeLuaSprite('end', 'endings/peanut', 0, 0);
            setObjectCamera('end', 'camOther');
            addLuaSprite('end', true);
            cool = true
            return Function_Stop;
        elseif not cool and getProperty('ratingPercent') >= 0.9 then
            playSound('goodEnding', 1)
            makeLuaSprite('end', 'endings/good', 0, 0);
            setObjectCamera('end', 'camOther');
            addLuaSprite('end', true);
            cool = true
            return Function_Stop;
        
        elseif not cool and getProperty('ratingPercent') < 0.9 then
            playSound('badEnding', 1)
            makeLuaSprite('end', 'endings/bad', 0, 0);
            setObjectCamera('end', 'camOther');
            addLuaSprite('end', true);
            cool = true
            return Function_Stop;

        end
        return Function_Continue;
    end
end