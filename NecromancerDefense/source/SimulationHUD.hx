package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

class SimulationHUD extends FlxGroup
{
	var _pauseButton : FlxButton;
	var _fastForwardButton : FlxButton;
	var _slowDownButton : FlxButton;
	var _returnToMain : FlxButton;
	var mpText : FlxText;

	var _pauseMenu : PauseMenu;

	var _fastestSpeed : Float = 3.0;
	var _slowestSpeed : Float = 1.0;

	public function new():Void
	{
		super();
        initSimHUD();
		
		_pauseMenu = new PauseMenu();
		add(_pauseMenu);
	}

	function initSimHUD(): Void
	{
		initMPText();
		initPauseButton();
		initFastForwardButton();
		initSlowDownButton();
	}

	function initMPText():Void
	{
		mpText = new FlxText(FlxG.width * 0.01, FlxG.height * 0.05, 155); // x, y, width
		mpText.setFormat(20, FlxColor.PINK, CENTER); 
		mpText.text = "MP: 10/10";
		add(mpText);
	}
	
	function initPauseButton():Void
	{
		_pauseButton = new FlxButton(0, 0, "||", pause);
		//_zombieButton.loadGraphic("assets/images/custom.png");

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
		//_fastForwardButton.loadGraphic("assets/images/custom.png");

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
		//_slowDownButton.loadGraphic("assets/images/custom.png");

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
		FlxG.timeScale = 0;
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

}