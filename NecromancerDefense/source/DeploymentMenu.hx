package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

class DeploymentMenu extends FlxTypedGroup<FlxSprite>
 
{
	var _zombieButton : FlxButton;
	var _skeletonButton : FlxButton;
	var _panel : FlxSprite;
	var mpText : FlxText;

	public function new():Void
	{
		super();
        initDeployMenu();
	}

	function initDeployMenu(): Void
	{
		initPanel();
		initMPText();
		initZombieButton();
		initSkeletonButton();
	}

	public function hide(): Void
	{
        _zombieButton.kill();
        _skeletonButton.kill();
        _panel.kill();
        mpText.kill();
	}

    public function show(): Void
	{
        _zombieButton.revive();
        _skeletonButton.revive();
        _panel.revive();
        mpText.revive();
	}


	function initPanel():Void
	{
		_panel = new FlxSprite();
		_panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_panel);		

		FlxSpriteUtil.drawRoundRect(_panel, FlxG.width * 0.025, FlxG.height * 0.1, FlxG.width * 0.17, FlxG.height * 0.85, 10, 10, FlxColor.fromRGB(56, 52, 50, 200));
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

	function selectZombie():Void
	{
		// place a zombie
	}

	function selectSkeleton():Void
	{
        // place a skeleton
	}


}
