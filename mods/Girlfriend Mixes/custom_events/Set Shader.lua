local num = 1

function onEvent(name, value1, value2)
	if name == 'Set Shader' then
	 initLuaShader(value1)

	if value2 == 'game' or value2 == 'Game' or value2 == 'GAME' then

	 makeLuaSprite("shaderImagesGame")
    makeGraphic("shaderImagesGame", screenWidth, screenHeight)

    setObjectCamera("shaderImagesGame", other)

    setSpriteShader("shaderImagesGame", value1)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImagesGame").shader)]);
    ]]) 
	elseif value2 == 'hud' or value2 == 'Hud' or value2 == 'HUD' or value2 == 'camhud' or value2 == 'Camhud' or value2 == 'CamHud' or value2 == 'camHUD' or value2 == 'CAMhud' or value2 == 'CAMHUD' then
makeLuaSprite("shaderImagesHUD")
    makeGraphic("shaderImagesHUD", screenWidth, screenHeight)

    setObjectCamera("shaderImagesHUD", other)

    setSpriteShader("shaderImagesHUD", value1)
	runHaxeCode([[
        trace(ShaderFilter);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImagesHUD").shader)]);
    ]])
	elseif value2 == 'other' or value2 == 'Other' or value2 == 'OTHER' then
makeLuaSprite("shaderImagesOTHER")
    makeGraphic("shaderImagesOTHER", screenWidth, screenHeight)

    setObjectCamera("shaderImagesOTHER", other)

    setSpriteShader("shaderImagesOTHER", value1)
	runHaxeCode([[
        trace(ShaderFilter);
        game.camOther.setFilters([new ShaderFilter(game.getLuaObject("shaderImagesOTHER").shader)]);
    ]])
	else
		setSpriteShader(value2, value1)
		if num == 1 then
		this = value2
		elseif num == 2 then
		this2 = value2
		elseif num == 3 then
		this3 = value2
		elseif num == 4 then
		this4 = value2
		elseif num == 5 then
		this5 = value2
		end
		num = num + 1
	end
	end
end

function onUpdate()
    setShaderFloat("shaderImagesGame", "iTime", os.clock())
    setShaderFloat("shaderImagesHUD", "iTime", os.clock())
    setShaderFloat("shaderImagesOTHER", "iTime", os.clock())
	setShaderFloat(this, "iTime", os.clock())
	setShaderFloat(this2, "iTime", os.clock())
	setShaderFloat(this3, "iTime", os.clock())
	setShaderFloat(this4, "iTime", os.clock())
	setShaderFloat(this5, "iTime", os.clock())
end