package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

class DeploymentState extends FlxState
{

	var _deployMenu : DeploymentMenu;
	var _startRoundButton : FlxButton;

	override public function create():Void
	{
		_deployMenu = new DeploymentMenu();
		add(_deployMenu);
		initStartButton();
		super.create();		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function initStartButton():Void
	{
		_startRoundButton = new FlxButton(0, 0, "Start Round", startRound);
		//_startRoundButton.loadGraphic("assets/images/custom.png");

		_startRoundButton.scale.set(2.25,3);
		_startRoundButton.updateHitbox();
		
		_startRoundButton.label.fieldWidth = _startRoundButton.width;
        _startRoundButton.label.alignment = "center";

		_startRoundButton.label.size = 15;
		_startRoundButton.label.offset.y -= 18;

		_startRoundButton.x = FlxG.width * 0.83;
		_startRoundButton.y = FlxG.height * 0.87;

		add(_startRoundButton);
	}

	function startRound():Void
	{
        FlxG.switchState(new SimulationState());
	}
}
