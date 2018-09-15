package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;

class MainMenu extends FlxState
{
    var _startButton:FlxButton;
	override public function create():Void
	{
		_startButton = new FlxButton(0, 0, "Start", clickPlay);
		_startButton.x = FlxG.width/2 - _startButton.width/2;
		_startButton.y = FlxG.height * 0.8;
		
		// Custom graphics
		//_startButton.loadGraphic("assets/custom.png");

		add(_startButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

    function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
}