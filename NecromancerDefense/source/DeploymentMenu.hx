package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

class DeploymentMenu extends FlxGroup
{
	var _zombieButton : FlxButton;
	var _skeletonButton : FlxButton;
	var _panel : FlxSprite;
	var mpText : FlxText;

	var _pauseButton : FlxButton;
	var _pauseMenu : PauseMenu;
	var _startRoundButton : FlxButton;

	public function new():Void
	{
		super();
        initDeployMenu();

		_pauseMenu = new PauseMenu();
		add(_pauseMenu);
	}

	function initDeployMenu(): Void
	{
		initPanel();
		initMPText();
		initZombieButton();
		initSkeletonButton();
		initPauseButton();
		initStartButton();
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
		if(FlxG.timeScale == 0)
			return;
        FlxG.switchState(new SimulationState());
	}

	function selectZombie():Void
	{
		if(FlxG.timeScale == 0)
			return;
		// place a zombie
	}

	function selectSkeleton():Void
	{
		if(FlxG.timeScale == 0)
			return;
        // place a skeleton
	}

	function pause():Void
	{
		if(FlxG.timeScale == 0)
			return;
			
		_pauseMenu.show(FlxG.timeScale);
        FlxG.timeScale = 0;
	}

}
