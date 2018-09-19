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

	override public function create():Void
	{
		_deployMenu = new DeploymentMenu();
		add(_deployMenu);
		super.create();		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
