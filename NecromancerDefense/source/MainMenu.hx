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
		//_startButton.loadGraphic("assets/images/custom.png");

		_startButton.scale.set(3,3);
		_startButton.updateHitbox();
		
		_startButton.label.fieldWidth = _startButton.width;
        _startButton.label.alignment = "center";

		_startButton.label.size = 20;
		_startButton.label.offset.y -= 10;

		_startButton.x = FlxG.width/2 - _startButton.width/2;
		_startButton.y = FlxG.height * 0.8;

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