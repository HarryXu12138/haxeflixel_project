package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flash.system.System;

class PauseMenu extends FlxTypedGroup<FlxSprite>
{
	var _resumeButton : FlxButton;
	var _returnToMain : FlxButton;
	var _quitButton : FlxButton;

	var _panel : FlxSprite;
	var _blackFilter : FlxSprite;

	var _savedTime : Float;

	public function new():Void
	{
		super();
        initPauseMenu();
	}

	function initPauseMenu(): Void
	{
		
		initBlackFilter();
		initPanel();
		initResumeButton();
		initReturnToMainButton();
		initQuitButton();
		hide();
	}

	public function hide(): Void
	{
		_blackFilter.kill();
		_panel.kill();
        _resumeButton.kill();
        _returnToMain.kill();
        _quitButton.kill();
	}

    public function show(currentTime:Float): Void
	{
		_blackFilter.revive();
		_panel.revive();
        _resumeButton.revive();
        _returnToMain.revive();
        _quitButton.revive();

		_savedTime = currentTime;
	}
	
	function initResumeButton():Void
	{
		_resumeButton = new FlxButton(0, 0, "Resume", resume);
		//_resumeButton.loadGraphic("assets/images/custom.png");

		_resumeButton.scale.set(3.5,4.5);
		_resumeButton.updateHitbox();
		
		_resumeButton.label.fieldWidth = _resumeButton.width;
        _resumeButton.label.alignment = "center";

		_resumeButton.label.size = 28;
		_resumeButton.label.offset.y -= 20;

		_resumeButton.x = FlxG.width * 0.41;
		_resumeButton.y = FlxG.height * 0.3;

		add(_resumeButton);
	}

	function initReturnToMainButton():Void
	{
		_returnToMain = new FlxButton(0, 0, "Main Menu", returnToMain);
		//_returnToMain.loadGraphic("assets/images/custom.png");

		_returnToMain.scale.set(3.5,4.5);
		_returnToMain.updateHitbox();
		
		_returnToMain.label.fieldWidth = _returnToMain.width;
        _returnToMain.label.alignment = "center";

		_returnToMain.label.size = 28;
		_returnToMain.label.offset.y -= 20;

		_returnToMain.x = FlxG.width * 0.41;
		_returnToMain.y = FlxG.height * 0.45;

		add(_returnToMain);
	}

	function initQuitButton():Void
	{
		_quitButton = new FlxButton(0, 0, "Quit", quit);
		//_quitButton.loadGraphic("assets/images/custom.png");

		_quitButton.scale.set(3.5,4.5);
		_quitButton.updateHitbox();
		
		_quitButton.label.fieldWidth = _quitButton.width;
        _quitButton.label.alignment = "center";

		_quitButton.label.size = 28;
		_quitButton.label.offset.y -= 20;

		_quitButton.x = FlxG.width * 0.41;
		_quitButton.y = FlxG.height * 0.6;

		add(_quitButton);
	}

	function initPanel():Void
	{
		_panel = new FlxSprite();
		_panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_panel);		

		FlxSpriteUtil.drawRoundRect(_panel, FlxG.width * 0.37, FlxG.height * 0.2, FlxG.width * 0.3, FlxG.height * 0.6, 10, 10, FlxColor.fromRGB(61, 57, 66, 256));
	}

	function initBlackFilter():Void
	{
		_blackFilter = new FlxSprite();
		_blackFilter.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_blackFilter);		

		FlxSpriteUtil.drawRoundRect(_blackFilter, 0, 0, FlxG.width, FlxG.height, 10, 10, FlxColor.fromRGB(24, 26, 30, 200));
	}

	function resume():Void
	{
		hide();
		FlxG.timeScale = _savedTime;
	}

	function returnToMain():Void
	{
		FlxG.timeScale = 1;
		FlxG.switchState(new MainMenu());
	}

	function quit():Void
	{
		System.exit(0);
	}
}
