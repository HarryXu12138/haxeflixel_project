package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;

/**
	This class draws our main menu.
**/
class MainMenu extends FlxState
{
    var _startButton:FlxButton;
	var _background:FlxSprite;

	override public function create():Void
	{

		super.create();
		FlxG.sound.playMusic(AssetPaths.HF_Menu__ogg);
		initBackground();
		initStartButton();
		
	}

	function initStartButton():Void{
		_startButton = new FlxButton(0, 0, "Start", clickPlay);
		
		_startButton.scale.set(3,3);
		_startButton.updateHitbox();

		_startButton.label.fieldWidth = _startButton.width;
        _startButton.label.alignment = "center";

		_startButton.label.size = 20;
		_startButton.label.offset.y -= 10;

		_startButton.x = FlxG.width/2 - _startButton.width/2;
		_startButton.y = FlxG.height * 0.8;

		add(_startButton);
	}

	function initBackground(){
		var background = new FlxSprite(0,0);
		background.loadGraphic("assets/images/NecroDef.png");
		add(background);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	// Load level 1
    function clickPlay():Void
	{
		FlxG.switchState(new DeploymentState(LevelFactory.generateLevel1()));
	}
}