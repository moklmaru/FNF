function onCreate()
	makeLuaSprite('ulin', 'christmas/erect/bgWalls', -1000, -500)
	setScrollFactor('ulin', 0.2, 0.2)
	setGraphicSize('ulin', getProperty('ulin.width') * 0.8)
	updateHitbox('ulin')

		makeAnimatedLuaSprite('upperBoppers', 'christmas/erect/upperBop', -240, -90)
		addAnimationByPrefix('upperBoppers', 'bop', 'upperBop', 24, false)
		setScrollFactor('upperBoppers', 0.33, 0.23)
		setGraphicSize('upperBoppers', getProperty('upperBoppers.width') * 0.82)
		updateHitbox('upperBoppers')
		
		makeLuaSprite('bgEscalator', 'christmas/erect/bgEscalator', -1100, -600)
		setScrollFactor('bgEscalator', 0.3, 0.3)
		setGraphicSize('bgEscalator', getProperty('bgEscalator.width') * 0.9)
		updateHitbox('bgEscalator')

		makeLuaSprite('tree', 'christmas/erect/christmasTree', 370, -250);
		setScrollFactor('tree', 0.40, 0.40);
	
	makeAnimatedLuaSprite('bottomBoppers', 'christmas/erect/bottomBop', -300, 140)
	addAnimationByPrefix('bottomBoppers', 'bop', 'bottomBop', 24, false)
	addAnimationByPrefix('bottomBoppers', 'hey', 'bottomBop', 24, false)
	setScrollFactor('bottomBoppers', 0.9, 0.9)
	setGraphicSize('bottomBoppers', getProperty('bottomBoppers.width') * 1)
	updateHitbox('bottomBoppers')
	
	makeLuaSprite('fgSnow', 'christmas/fgSnow', -600, 700)
	makeLuaSprite('fgSnow2', 'christmas/fgSnow', -3000, 650)
	scaleObject('fgSnow2',1.25,1.25)
	makeAnimatedLuaSprite('santa', 'christmas/santa', -840, 150)
	addAnimationByPrefix('santa', 'bop', 'santa idle in fear', 24, false)
	
	precacheSound('Lights_Shut_off')

	addLuaSprite('ulin', false)
	addLuaSprite('stagefront', false)
	addLuaSprite('upperBoppers', false)
	addLuaSprite('bgEscalator', false)
	addLuaSprite('tree', false)
	addLuaSprite('bottomBoppers', false)
	addLuaSprite('fgSnow', false)
	addLuaSprite('santa', true)
end

zoom1=false
zoom2=false

  function handleScreenShake(value)
	if value == '1' then
	  zoom1 = true
	  zoom2 = false
	elseif value == '2' then
	  zoom1 = false
	  zoom2 = true
	elseif value == '3' then
	  zoom1 = false
	  zoom2 = false
	end
  end
  
  function handleSetGFSpeed(value)
	if value == 'g' then
	  triggerEvent('Camera Follow Pos', '500', '410')
	elseif value == 'b' then
	  triggerEvent('Camera Follow Pos', '', '')
	elseif value == 'dad' then
	  triggerEvent('Camera Follow Pos', '192', '391')
	elseif value == 'bf' then
		triggerEvent('Camera Follow Pos', '927', '460')
	elseif value == 'XD' then
		triggerEvent('Camera Follow Pos', '192', '391')
	elseif value == 'bye' then
		setProperty('cameraSpeed',0.2)
		triggerEvent('Camera Follow Pos', '470', '410')
	end
  end
local heyTimer = 0
function onBeatHit()
	if curBeat % 1 == 0 and curBeat % 4 ~= 0 and zoom1 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 2 == 0 and curBeat % 4 ~= 0 and zoom2 then
		triggerEvent('Add Camera Zoom', '', '0.035')
	  end
	  if curBeat % 4 == 0 and curStep >=1 and curStep <1215 then
		triggerEvent('Add Camera Zoom', '', '0.01')
	  end
	if not lowQuality then playAnim('upperBoppers', 'bop', true) end		
		if heyTimer <= 0 then 
			playAnim('bottomBoppers', 'bop', true)
			setProperty('bottomBoppers.offset.x', 0)
			setProperty('bottomBoppers.offset.y', 0)
		end
		playAnim('santa', 'bop', true)
end

function onCountdownTick(c)
	onBeatHit()
end

function onEvent(n, v1, v2)
	if n == 'Screen Shake' then
		handleScreenShake(v1)
	  elseif n == 'Set GF Speed' then
		handleSetGFSpeed(v1)
	  end
	if n == 'Hey!' then
		time = tonumber(v2);
		if time == nil or time < 0 then time = 0.6 end
		heyTimer = time
		playAnim('bottomBoppers', 'hey', true)
		setProperty('bottomBoppers.offset.x', -15)
		setProperty('bottomBoppers.offset.y', 30)
	end
end

function onUpdate(elapsed)
	if heyTimer > 0 then heyTimer = heyTimer - elapsed end
	if heyTimer <= 0 then
		heyTimer = 0
	end
end
santaC=true
function onTimerCompleted(ulisegas)
if ulisegas == 'dieee' then
	runTimer('sh',2)
playSound('santa_shot_n_falls')
end
if ulisegas == 'chao:)' then
	santaC=false
	endSong()
end
if ulisegas == 'sh' then
	runTimer('chao:)',1)
	triggerEvent('Screen Shake','0.15, 0.02','')
	setProperty('camFollow.y', getProperty('camFollow.y')+40) 
end
end
yayamijoya=false
	function onEndSong()
		if songName ~= "Eggnog (Pico Mix)" then
			if songName ~= "Cocoa Erect" then
		if not yayamijoya then
			yayamijoya =true
	function onBeatHit()end
	local targetZoom = 0.8
local lerpSpeed = 0.01

function onUpdatePost()
    local currentZoom = getProperty("camGame.zoom")
    local newZoom = lerp(currentZoom, targetZoom, lerpSpeed)

    setProperty("camGame.zoom", newZoom)
end

function lerp(a, b, t)
    return a + (b - a) * t
end
addLuaSprite('fgSnow2', false)
	playSound('santa_emotion')
	setProperty('dad.alpha',0)
	setProperty('santa.alpha',0)
    setProperty('camFollow.x', -300) 
	setProperty('camFollow.y', getProperty('camFollow.y')+110) 
	runTimer('dieee',11)
	makeFlxAnimateSprite("mySprite2",  -518,501, "christmas/parents_shoot_assets")
	loadAnimateAtlas("mySprite2", "christmas/parents_shoot_assets")
	addAnimationBySymbolIndices("mySprite2","idle", "parents whole scene", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360}, 24, false)
	addLuaSprite("mySprite2", true)
	playAnim('mySprite2','idle',true)
	makeFlxAnimateSprite("Xd",  -450,515, "christmas/santa_speaks_assets")
	loadAnimateAtlas("Xd", "christmas/santa_speaks_assets")
	addAnimationBySymbolIndices("Xd","idle", "santa whole scene", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360}, 24, false)
	addLuaSprite("Xd", true)
	playAnim('Xd','idle',true)
	if not santaC then
	    return Function_Continue
    else
        return Function_Stop
    end
end
end
end
end