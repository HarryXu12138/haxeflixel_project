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

/**
	Draws our pop-up window (game over, game won, etc.)
**/
class EndLevel extends FlxTypedGroup<FlxSprite>
{
    var _levelData : LevelData;

    var _displayText : FlxText;

	var _mainMenuButton : FlxButton;
	var _okButton : FlxButton;
	var _quitButton : FlxButton;

	var _panel : FlxSprite;
	var _blackFilter : FlxSprite;

	var _savedTime : Float;

	public function new():Void
	{
		super();
        initWindow();
	}

	function initWindow(): Void
	{
		initBlackFilter();
		initPanel();
        initDisplayText();
		initMainMenuButton();
		initOKButton();
		initQuitButton();
		hide();
	}

	// Hide the window
	public function hide():Void
	{
		_blackFilter.kill();
		_panel.kill();
        _displayText.kill();
        _mainMenuButton.kill();
        _quitButton.kill();
		_okButton.kill();
	}

	// Show the window and determine what context to show in our menu
    public function show(levelData:LevelData, mode:Int, currentTime:Float):Void
	{
		if(mode == 0)
			_displayText.text = "- Game Over - \n\nYou failed to capture most of the lanes...";
		else if(mode == 1)
			_displayText.text = "- You Won -\n\nLaunching our next attack at the castle!";
		else if (mode == 2)
			_displayText.text = "- You Won -\n\nThe castle is yours now!";

        _levelData = levelData;

		_blackFilter.revive();
		_panel.revive();
        _displayText.revive();

		if(mode == 0 || mode == 2){
			_okButton.kill();
			_mainMenuButton.revive();
			_quitButton.revive();
		}
		else{
			_okButton.revive();
			_mainMenuButton.kill();
			_quitButton.kill();
		}

        _savedTime = currentTime;
        FlxG.timeScale = 0;
	}
	
    function initDisplayText():Void
	{
		_displayText = new FlxText(FlxG.width * 0.35, FlxG.height * 0.36, 400); // x, y, width
		_displayText.setFormat(23, FlxColor.WHITE, CENTER);
		_displayText.text = "";
		add(_displayText);
	}

	function initOKButton():Void
	{
		_okButton = new FlxButton(0, 0, "OK", okAction);

		_okButton.scale.set(1.3,3);
		_okButton.updateHitbox();
		
		_okButton.label.fieldWidth = _okButton.width;
        _okButton.label.alignment = "center";

		_okButton.label.size = 20;
		_okButton.label.offset.y -= 12;

		_okButton.x = FlxG.width * 0.465;
		_okButton.y = FlxG.height * 0.6;

		add(_okButton);
	}

	function initMainMenuButton():Void
	{
		_mainMenuButton = new FlxButton(0, 0, "Main Menu", mainMenu);

		_mainMenuButton.scale.set(1.8,3);
		_mainMenuButton.updateHitbox();
		
		_mainMenuButton.label.fieldWidth = _mainMenuButton.width;
        _mainMenuButton.label.alignment = "center";

		_mainMenuButton.label.size = 18;
		_mainMenuButton.label.offset.y -= 12;

		_mainMenuButton.x = FlxG.width * 0.54;
		_mainMenuButton.y = FlxG.height * 0.6;

		add(_mainMenuButton);
	}

	function initQuitButton():Void
	{
		_quitButton = new FlxButton(0, 0, "Quit", quitAction);

		_quitButton.scale.set(1.8,3);
		_quitButton.updateHitbox();
		
		_quitButton.label.fieldWidth = _quitButton.width;
        _quitButton.label.alignment = "center";

		_quitButton.label.size = 20;
		_quitButton.label.offset.y -= 12;

		_quitButton.x = FlxG.width * 0.36;
		_quitButton.y = FlxG.height * 0.6;

		add(_quitButton);
	}

	function initPanel():Void
	{
		_panel = new FlxSprite();
		_panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_panel);		

		FlxSpriteUtil.drawRoundRect(_panel, FlxG.width * 0.32, FlxG.height * 0.3, FlxG.width * 0.37, FlxG.height * 0.45, 10, 10, FlxColor.fromRGB(61, 57, 66, 256));
	}

	// Giant overlay that darkens the rest of the scene
	function initBlackFilter():Void
	{
		_blackFilter = new FlxSprite();
		_blackFilter.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_blackFilter);		

		FlxSpriteUtil.drawRoundRect(_blackFilter, 0, 0, FlxG.width, FlxG.height, 10, 10, FlxColor.fromRGB(24, 26, 30, 130));
	}

	function mainMenu():Void
	{
        FlxG.timeScale = 1;
		FlxG.switchState(new MainMenu());
	}

	function okAction():Void
	{
		FlxG.timeScale = 1;
		FlxG.switchState(new DeploymentState(LevelFactory.generateLevel2()));
	}

	function quitAction():Void
	{
		System.exit(0);
	}
}
