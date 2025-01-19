package gameplay.stages.stage;

import core.graphics.shaders.AdjustColorShader;

// this is still entirely TO-DO, translating out of lua in the future
// have to reconsider stage implementation as a whole

class Backstage extends BaseStage
{
	var dadbattleBlack:BGSprite;
	var dadbattleLight:BGSprite;
	var dadbattleFog:DadBattleFog;

	var colorShaderBf:AdjustColorShader;
	var colorShaderDad:AdjustColorShader;
	var colorShaderGf:AdjustColorShader;

	override function create()
	{

		colorShaderBf = new AdjustColorShader();
		colorShaderDad = new AdjustColorShader();
		colorShaderGf = new AdjustColorShader();

		colorShaderBf.brightness = -23;
		colorShaderBf.hue = 12;
		colorShaderBf.contrast = 7;
			colorShaderBf.saturation = 0;

		colorShaderGf.brightness = -30;
		colorShaderGf.hue = -9;
		colorShaderGf.contrast = -4;
			colorShaderGf.saturation = 0;

		colorShaderDad.brightness = -33;
		colorShaderDad.hue = -32;
		colorShaderDad.contrast = -23;
			colorShaderDad.saturation = 0;


			// from v slice
		// getNamedProp('brightLightSmall').blend = 0;
		// getNamedProp('orangeLight').blend = 0;
		// getNamedProp('lightgreen').blend = 0;
		// getNamedProp('lightred').blend = 0;
		// getNamedProp('lightAbove').blend = 0;


		// 	makeAnimatedLuaSprite('audience_front', 'backstage/crowd', 700, 200);
		// 	luaSpriteAddAnimationByPrefix('audience_front', 'audience_front', 'frontbop', '20')
		// 	setLuaSpriteScrollFactor('audience_front', 0.9, 0.9);
		// 	scaleObject('audience_front', 1, 1);
			
		// 	makeLuaSprite('stageback', 'backstage/back', 700, -200);
		// 	scaleObject('stageback', 1.5, 1.5);

		// 	makeLuaSprite('stagefront', 'backstage/bg', -650, -475);
		// 	scaleObject('stagefront', 1.2, 1.2);

		// 	makeLuaSprite('stageserver', 'backstage/server', -125, 150);
		// 	scaleObject('stageserver', 1, 1);

		// 	makeLuaSprite('stagelight', 'backstage/lights', -650, -300);
		// 	setLuaSpriteScrollFactor('stagelight', 1.2, 1.1);
		// 	scaleObject('stagelight', 1.1, 1);
			
		// 	addLuaSprite('stageback', false);
		// 	addLuaSprite('audience_front', false);
		// 	--
		// 	makeLuaSprite('brightLightSmall', 'backstage/brightLightSmall', 1100, -175);
		// 	scaleObject('brightLightSmall', 1, 1);
		// 	addLuaSprite('brightLightSmall', false);
		// 	setBlendMode('brightLightSmall','add')
		// 	setLuaSpriteScrollFactor('brightLightSmall', 1.2, 1.1);
		// 	--
		// 	addLuaSprite('stagefront', false);
		// 	addLuaSprite('stageserver', false);
		// 	addLuaSprite('stagelight', false);

		// 	makeLuaSprite('orangeLight', 'backstage/orangeLight', -125, -150);
		// 	scaleObject('orangeLight', 2, 2);
		// 	addLuaSprite('orangeLight', true);
		// 	setObjectOrder('brightLightSmall',getObjectOrder('orangeLight')+1)
		// 	setObjectOrder('stagelight',getObjectOrder('orangeLight')+2)
		// setBlendMode('orangeLight','add')


		// regular stage create code for reference
		var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
		add(bg);

		var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		add(stageFront);
		if(!ClientPrefs.data.lowQuality) {
			var stageLight:BGSprite = new BGSprite('stage_light', -125, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			add(stageLight);
			var stageLight:BGSprite = new BGSprite('stage_light', 1225, -100, 0.9, 0.9);
			stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
			stageLight.updateHitbox();
			stageLight.flipX = true;
			add(stageLight);

			var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			add(stageCurtains);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// need to translate this, vslice shader stuff
		// if(PlayState.instance.currentStage.getBoyfriend() != null && PlayState.instance.currentStage.getBoyfriend().shader == null){
		// 	PlayState.instance.currentStage.getBoyfriend().shader = colorShaderBf;
		// 	PlayState.instance.currentStage.getGirlfriend().shader = colorShaderGf;
		// 	PlayState.instance.currentStage.getDad().shader = colorShaderDad;
		// }
	}
}