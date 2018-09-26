package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

/**
	This class draws our HUD during a simulation state.
**/
class SimulationHUD extends FlxGroup
{
	var _pauseButton : FlxButton;
	var _fastForwardButton : FlxButton;
	var _slowDownButton : FlxButton;
	var _returnToMain : FlxButton;
	var mpText : FlxText;

	var _pauseMenu : PauseMenu;
	var _endLevelMenu : EndLevel;

	var _fastestSpeed : Float = 3.0;
	var _slowestSpeed : Float = 1.0;

	public function new():Void
	{
		super();
        initSimHUD();

		_pauseMenu = new PauseMenu();
		add(_pauseMenu);

		_endLevelMenu = new EndLevel();
		add(_endLevelMenu);
	}

	function initSimHUD(): Void
	{
		initPauseButton();
		initFastForwardButton();
		initSlowDownButton();
	}

	function initPauseButton():Void
	{
		_pauseButton = new FlxButton(0, 0, "||", pause);

		_pauseButton.scale.set(0.6,2);
		_pauseButton.updateHitbox();

		_pauseButton.label.fieldWidth = _pauseButton.width;
        _pauseButton.label.alignment = "center";

		_pauseButton.label.size = 18;

		_pauseButton.x = FlxG.width * 0.95;
		_pauseButton.y = FlxG.height * 0.05;

		add(_pauseButton);
	}

	function initFastForwardButton():Void
	{
		_fastForwardButton = new FlxButton(0, 0, ">>", fastForward);

		_fastForwardButton.scale.set(0.6,2);
		_fastForwardButton.updateHitbox();

		_fastForwardButton.label.fieldWidth = _fastForwardButton.width;
        _fastForwardButton.label.alignment = "center";

		_fastForwardButton.label.size = 18;

		_fastForwardButton.x = FlxG.width * 0.9;
		_fastForwardButton.y = FlxG.height * 0.05;

		add(_fastForwardButton);
	}

	function initSlowDownButton():Void
	{
		_slowDownButton = new FlxButton(0, 0, "<<", slowDown);

		_slowDownButton.scale.set(0.6,2);
		_slowDownButton.updateHitbox();

		_slowDownButton.label.fieldWidth = _slowDownButton.width;
        _slowDownButton.label.alignment = "center";

		_slowDownButton.label.size = 18;

		_slowDownButton.x = FlxG.width * 0.85;
		_slowDownButton.y = FlxG.height * 0.05;

		add(_slowDownButton);
	}

	function pause():Void
	{
		if(FlxG.timeScale == 0)
			return;

		_pauseMenu.show(FlxG.timeScale);
	}

	function fastForward():Void
	{
		if(FlxG.timeScale == 0)
			return;

		FlxG.timeScale *= 2;
		if(FlxG.timeScale >= _fastestSpeed)
			FlxG.timeScale = _fastestSpeed;
	}

	function slowDown():Void
	{
		if(FlxG.timeScale == 0)
			return;

		FlxG.timeScale /= 2;
		if(FlxG.timeScale <= _slowestSpeed)
			FlxG.timeScale = _slowestSpeed;
	}

	// Open our pop-up window (game over, game won, etc.)
	public function showEndLevelScreen(levelData:LevelData, mode:Int):Void
	{
		_endLevelMenu.show(levelData, mode, 1);
	}

}
