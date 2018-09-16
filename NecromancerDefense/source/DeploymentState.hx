package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;

class Deployment extends FlxState
{
	var _zombieButton : FlxButton;
	var _skeletonButton : FlxButton;
	var _startButton : FlxButton;
	var panel : FlxSprite;

	var mpText : FlxText;

	override public function create():Void
	{
		super.create();
		initCharSelectionMenu();
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function initCharSelectionMenu(): Void
	{
		initPanel();
		initMPText();
		initZombieButton();
		initSkeletonButton();
		initStartButton();
	}


	function initPanel():Void
	{
		panel = new FlxSprite();
		panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(panel);

		FlxSpriteUtil.drawRoundRect(panel, FlxG.width * 0.025, FlxG.height * 0.1, FlxG.width * 0.17, FlxG.height * 0.85, 10, 10, FlxColor.fromRGB(56, 52, 50, 200));
	}

	function initMPText():Void
	{
		mpText = new FlxText(FlxG.width * 0.05, FlxG.height * 0.2, 155); // x, y, width
		mpText.setFormat(20, FlxColor.WHITE, CENTER); 
		mpText.text = "MP: 10/10";
		add(mpText);
	}
	
	function initZombieButton():Void
	{
		_zombieButton = new FlxButton(0, 0, "Zombie", selectZombie);
		//_zombieButton.loadGraphic("assets/images/custom.png");

		_zombieButton.scale.set(2,6);
		_zombieButton.updateHitbox();
		
		_zombieButton.label.fieldWidth = _zombieButton.width;
        _zombieButton.label.alignment = "center";

		_zombieButton.label.size = 20;
		_zombieButton.label.offset.y -= 40;

		_zombieButton.x = FlxG.width * 0.05;
		_zombieButton.y = FlxG.height * 0.3;

		add(_zombieButton);
	}

	function initSkeletonButton():Void
	{
		_skeletonButton = new FlxButton(0, 0, "Skeleton", selectSkeleton);
		//_skeletonButton.loadGraphic("assets/images/custom.png");

		_skeletonButton.scale.set(2,6);
		_skeletonButton.updateHitbox();
		
		_skeletonButton.label.fieldWidth = _skeletonButton.width;
        _skeletonButton.label.alignment = "center";

		_skeletonButton.label.size = 20;
		_skeletonButton.label.offset.y -= 40;

		_skeletonButton.x = FlxG.width * 0.05;
		_skeletonButton.y = FlxG.height * 0.5;

		add(_skeletonButton);
	}

	function initStartButton():Void
	{
		_startButton = new FlxButton(0, 0, "Start Round", startRound);
		//_startButton.loadGraphic("assets/images/custom.png");

		_startButton.scale.set(2.25,3);
		_startButton.updateHitbox();
		
		_startButton.label.fieldWidth = _startButton.width;
        _startButton.label.alignment = "center";

		_startButton.label.size = 15;
		_startButton.label.offset.y -= 18;

		_startButton.x = FlxG.width * 0.83;
		_startButton.y = FlxG.height * 0.87;

		add(_startButton);
	}


	function selectZombie():Void
	{
		// TODO
	}

	function selectSkeleton():Void
	{
		// TODO
	}

	function startRound():Void
	{
		// Hide graphics
	}

}
