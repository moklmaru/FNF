function onCreate()
	-- background shit
	makeLuaSprite('skybox', 'Skybox', -1110, -785);
	setScrollFactor('skybox', 0.42, 0.25);
	scaleObject('skybox', 1.05, 1.05);
	makeLuaSprite('clouds', 'Clouds', -1485, -267);
	scaleObject('clouds', 0.8, 0.8);
	setScrollFactor('clouds', 0.4, 0.25);
	makeLuaSprite('plane', 'plane', -1936, 185);
	scaleObject('plane', 0.9, 0.9);
	setScrollFactor('plane', 0.5, 0.8);
	makeLuaSprite('paralax2', 'SecondParalax', -1385, 170);
	scaleObject('paralax2', 0.86, 0.86);
	setScrollFactor('paralax2', 0.8, 0.75);
	makeLuaSprite('housesandfloor', 'HousesAndFloor', -1580, -178);
	scaleObject('housesandfloor', 0.9, 0.9);
	makeLuaSprite('fences', 'Fences', -972, 428);
	scaleObject('fences', 0.9, 0.9);
	makeLuaSprite('car', 'Car', -1796, 762);
	scaleObject('car', 0.9, 0.9);
	setScrollFactor('car', 1.2, 1.1);
	
	makeLuaSprite('darken', '', -300, -180);
	makeGraphic('darken', 2000, 1100, '000000');
	setScrollFactor('darken', 0, 0);
	setProperty('darken.alpha', 0);
	
	addLuaSprite('skybox', false);
	addLuaSprite('clouds', false);
	addLuaSprite('plane', false);
	addLuaSprite('paralax2', false);
	addLuaSprite('housesandfloor', false);
	
	addLuaSprite('fences', false);
	addLuaSprite('car', true);
	doTweenX('planeVroom', 'plane', 2064, 43.5, 'linear');
end

function onTweenCompleted(tag)
	if tag == 'planeVroom' then
		removeLuaSprite('plane', true);
	elseif tag == 'lightenScreen' then
		removeLuaSprite('darken', true);
	end
end

function onEvent(name,value1,value2)
	if name == 'Set Cam Zoom' then
		if value1 ~= '0.7' then
			if value1 == '0.8' then
				addLuaSprite('darken');
				setObjectOrder('darken', getObjectOrder('paralax2'));
			end
			doTweenAlpha('darkenScreen', 'darken', getProperty('darken.alpha')+0.1, 0.2, 'linear');
		else
			doTweenAlpha('lightenScreen', 'darken', 0, 0.2, 'linear');
			--close(true);
		end
	end
end