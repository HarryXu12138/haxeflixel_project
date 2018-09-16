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
	var _returnToMain : FlxButton;
	var mpText : FlxText;

	var _pauseMenu : SimulationPauseMenu;

	public function new():Void
	{
		super();
        initSimHUD();

		
		_pauseMenu = new SimulationPauseMenu();
		add(_pauseMenu);
	}

	function initSimHUD(): Void
	{
		initMPText();
		initPauseButton();
		initFastForwardButton();
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

	function pause():Void
	{
        FlxG.timeScale = 0;
		_pauseMenu.show();
	}

	function fastForward():Void
	{
		FlxG.timeScale = 2;
	}

}
