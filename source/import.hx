#if !macro
//Discord API
#if DISCORD_ALLOWED
import core.api.Discord;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if ACHIEVEMENTS_ALLOWED
import core.achievements.Achievements;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import core.util.Paths;
import core.controls.Controls;
import core.util.CoolUtil;
import core.MusicBeatState;
import core.MusicBeatSubstate;
import menu.options.ClientPrefs;
import core.Conductor;
import gameplay.stages.BaseStage;
import gameplay.Difficulty;
import modding.Mods;
import core.Language;

import modding.editors.objects.*; //Psych-UI

import core.Alphabet;
import gameplay.stages.BGSprite;

import gameplay.PlayState;
import menu.transition.LoadingState;
import menu.transition.TransitionSubstate;

#if flxanimate
import flxanimate.*;
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

//Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;
#end
