package;

import flixel.addons.display.FlxBackdrop;
import shipStateFolder.ShipMenuState;
import stageEditorFolder.StageMenuState;
import flixel.util.FlxColor;
import playStateFolder.PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import openfl.system.System;

class MenuState extends FlxState
{
	private var backdrop:FlxBackdrop;
	private var logo:FlxSprite;
	private var txtTitle:FlxText;
	private var btnPlay:FlxButton;
	private var btnStageEditor:FlxButton;
	private var btnShipEditor:FlxButton;
	private var btnOptions:FlxButton;
	#if desktop
	private var btnExit:FlxButton;
	#end
	
	override public function create():Void
	{	
		add(backdrop = new FlxBackdrop(AssetPaths.BgMenu__jpg));
		//backdrop.velocity.set(0, 200);
		
		logo = new FlxSprite();
		
		logo.loadGraphic(AssetPaths.logo__png);
		logo.x = (FlxG.width / 2) - (logo.width / 2);
		logo.y = 120;
		logo.antialiasing = true;
		add(logo);
		
		/*
		txtTitle = new FlxText(0, 0, 0, "SHMUP EDITOR", 90);
		txtTitle.alignment = CENTER;
		txtTitle.screenCenter(X);
		txtTitle.y = 150;
		add(txtTitle);
		*/
		
		#if desktop
		btnExit = new FlxButton(0, 0, null, clickExit);
		btnExit.loadGraphic(AssetPaths.Exit__png);
		btnExit.x = (FlxG.width / 2) - (btnExit.width / 2);
		btnExit.y = FlxG.height - btnExit.height - 50;
		//btnExit.loadGraphic(AssetPaths.button__png, true, 20, 20);
		add(btnExit);
		#end

		btnOptions = new FlxButton(0, 0, null, clickOptions);
		btnOptions.loadGraphic(AssetPaths.Options__png);
		btnOptions.x = (FlxG.width / 2) - (btnOptions.width / 2);
		btnOptions.y = FlxG.height - btnOptions.height - 40;
		#if desktop
		btnOptions.y = btnExit.y - btnOptions.height - 5;
		#end
		//btnOptions.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(btnOptions);
		
		btnShipEditor = new FlxButton(0, 0, null, clickShipEditor);
		btnShipEditor.loadGraphic(AssetPaths.Ship_Editor__png);
		btnShipEditor.x = (FlxG.width / 2) - (btnShipEditor.width / 2);
		btnShipEditor.y = btnOptions.y - btnShipEditor.height - 5;
		//btnEditor.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(btnShipEditor);
		
		btnStageEditor = new FlxButton(0, 0, null, clickStageEditor);
		btnStageEditor.loadGraphic(AssetPaths.Stage_Editor__png);
		btnStageEditor.x = (FlxG.width / 2) - (btnStageEditor.width / 2);
		btnStageEditor.y = btnShipEditor.y - btnStageEditor.height - 5;
		//btnEditor.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(btnStageEditor);

		btnPlay = new FlxButton(0, 0, null, clickPlay);
		btnPlay.loadGraphic(AssetPaths.btnPlay__png);
		btnPlay.x = (FlxG.width / 2) - (btnPlay.width / 2);
		btnPlay.y = btnStageEditor.y - btnPlay.height - 5;	
		//btnPlay.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(btnPlay);
		
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}
	
	private function clickStageEditor():Void {
		FlxG.switchState(new StageMenuState());
	}
	
	private function clickShipEditor():Void {
		FlxG.switchState(new ShipMenuState());
	}
	 
	private function clickOptions():Void {
		FlxG.switchState(new OptionsState());
	}
	
	#if desktop
	private function clickExit():Void {
		System.exit(0);
	}
	#end
}
