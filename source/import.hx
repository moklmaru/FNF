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

import core.FunkinState;
import core.FunkinSubState;
import core.WeekData;
import core.Alphabet;
import core.Conductor;
import core.Language;
import core.util.Paths;
import core.util.CoolUtil;
import core.controls.Controls;

import menu.options.ClientPrefs;
import menu.main.MainMenuState;
import menu.story.StoryMenuState;
import menu.freeplay.FreeplayState;
import menu.transition.LoadingState;
import menu.transition.TransitionSubState;
import menu.common.*;

import gameplay.PlayState;
import gameplay.Song;
import gameplay.Character;
import gameplay.Difficulty;
import gameplay.GameOverSubstate;
import gameplay.stages.StageData;
import gameplay.stages.BaseStage;
import gameplay.stages.BGSprite;
import gameplay.notes.*;
import gameplay.notes.Note.EventNote;

import modding.Mods;
import modding.editors.objects.*; //Psych-UI

#if flxanimate
import flxanimate.*;
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

// Haxe
import haxe.Json;
import haxe.io.Path;

// Flixel
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.FlxCamera;
import flixel.sound.FlxSound;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.util.FlxTimer;
import flixel.util.FlxSave;
import flixel.util.FlxStringUtil;
import flixel.util.FlxSort;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;

// OpenFL
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;

using StringTools;
#end
