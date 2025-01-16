function onCreate()
makeLuaSprite('WBG', nil, -4500, -3200)
makeGraphic('WBG',5000,5000,'ffffff')
addLuaSprite('WBG', false)
scaleObject('WBG', 5, 5);
setScrollFactor('WBG', 0, 0)
setProperty('WBG.visible', false)

initLuaShader("INV")
setSpriteShader("dad", "INV")
setSpriteShader("gf", "INV")
setSpriteShader("boyfriend", "INV")
setSpriteShader("WBG", "INV")

setShaderInt("dad", "invert", 0)
setShaderInt("gf", "invert", 0)
setShaderInt("boyfriend", "invert", 0)
setShaderInt("WBG", "invert", 0)
end

function onEvent(name,value1,value2)
if name == 'Change Character' then
initLuaShader("INV")
if value1 == 'dad' then
setSpriteShader("dad", "INV")
setShaderInt("dad", "invert", 0)
elseif value1 == 'bf' then
setSpriteShader("boyfriend", "INV")
setShaderInt("boyfriend", "invert", 0)
elseif value1 == 'gf' then
setSpriteShader("gf", "INV")
setShaderInt("gf", "invert", 0)
end
end 

if name == 'WBG' then

if value1 == 'Won' then
setProperty('boyfriend.color', getColorFromHex('000000'))
setProperty('dad.color', getColorFromHex('000000'))
setProperty('gf.color', getColorFromHex('000000'))
setProperty('WBG.visible', true)
setProperty('healthBar.visible', false)
setProperty('healthBarBG.visible', false)
setProperty('timeTxt.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeBarBG.visible', false)
setProperty('scoreTxt.visible', false)
setShaderInt("dad", "invert", 0)
setShaderInt("gf", "invert", 0)
setShaderInt("boyfriend", "invert", 0)
setShaderInt("WBG", "invert", 0)
end

if value1 == 'INV' then
setProperty('WBG.visible', true)
setProperty('healthBar.visible', false)
setProperty('healthBarBG.visible', false)
setProperty('timeTxt.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeBarBG.visible', false)
setProperty('scoreTxt.visible', false)
setShaderInt("dad", "invert", 1)
setShaderInt("gf", "invert", 1)
setShaderInt("boyfriend", "invert", 1)
setShaderInt("WBG", "invert", 1)
end

if value1 == 'Bon' then

setProperty('boyfriend.color', getColorFromHex('000000'))
setProperty('dad.color', getColorFromHex('000000'))
setProperty('gf.color', getColorFromHex('000000'))
setProperty('WBG.visible', true)
setProperty('healthBar.visible', true)
setProperty('healthBarBG.visible', true)
setProperty('timeTxt.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeBarBG.visible', false)
setProperty('scoreTxt.visible', false)
setShaderInt("dad", "invert", 1)
setShaderInt("gf", "invert", 1)
setShaderInt("boyfriend", "invert", 1)
setShaderInt("WBG", "invert", 1)
end

if value1 == 'off' then
setProperty('boyfriend.color', getColorFromHex('ffffff'))
setProperty('dad.color', getColorFromHex('ffffff'))
setProperty('gf.color', getColorFromHex('ffffff'))
setProperty('WBG.visible', false)
setProperty('healthBar.visible', true)
setProperty('healthBarBG.visible', true)
setProperty('timeTxt.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeBarBG.visible', false)
setProperty('scoreTxt.visible', true)
setShaderInt("dad", "invert", 0)
setShaderInt("gf", "invert", 0)
setShaderInt("boyfriend", "invert", 0)
setShaderInt("WBG", "invert", 0)
end
end
end