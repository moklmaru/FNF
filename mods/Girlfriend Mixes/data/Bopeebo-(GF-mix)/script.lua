function onStartCountdown()
    setCharacterX('boyfriend', 700)
    setCharacterY('boyfriend', 150)

    setCharacterY('dad', 150)
end

function onGameOverStart()
    setPropertyFromClass('flixel.FlxG', 'camera.x', 300)
    setPropertyFromClass('flixel.FlxG', 'camera.y', 50)
end