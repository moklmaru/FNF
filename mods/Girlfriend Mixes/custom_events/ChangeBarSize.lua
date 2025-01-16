function onCreate()
    makeLuaSprite('TopBar', nil, 0, -350)
	makeGraphic('TopBar', 1280, 350, '000000')
	setObjectCamera('TopBar', 'camHUD')
	addLuaSprite('TopBar', true)

    makeLuaSprite('BottomBar', nil, 0, 720)
	makeGraphic('BottomBar', 1280, 350, '000000')
	setObjectCamera('BottomBar', 'camHUD')
	addLuaSprite('BottomBar', true)

    TopY = getProperty('TopBar.y')
	BotY = getProperty('BottomBar.y')
    runHaxeCode([[
        FlxG.cameras.remove(game.camOther,false);
        FlxG.cameras.remove(game.camHUD,false);
        var camBAR = new FlxCamera();
        camBAR.bgColor = 0x00;
        setVar('camBAR',camBAR);
        game.getLuaObject('TopBar').camera = camBAR;
        game.getLuaObject('BottomBar').camera = camBAR;
        FlxG.cameras.add(camBAR,false);
        FlxG.cameras.add(game.camHUD,false);
        FlxG.cameras.add(game.camOther,false);
    ]])
end
function onEvent(n,v1,v2)
    if n == 'ChangeBarSize' then
        doTweenY('TopBar', 'TopBar', TopY + v2 * 2, v1, 'quintOut')
		doTweenY('BottomBar', 'BottomBar', BotY - v2 * 2, v1, 'quintOut')
    end
end
