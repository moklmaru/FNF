function onEvent(n, v1, v2)
	if n == 'change icon' then
		runHaxeCode([[
			game.icon]] .. string.upper(v1) .. [[.changeIcon(']] .. v2 .. [[')
		]]);
	end
end
