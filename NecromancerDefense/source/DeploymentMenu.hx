package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

// Tooltips
import flixel.addons.ui.FlxUIButton;

/*
	This class draws our deployment menu UI elements
*/
class DeploymentMenu extends FlxGroup
{
    private var _confirmationWindow : ConfirmationWindow;

	public var zombieButton : FlxUIButton;
	public var skeletonButton : FlxUIButton;

	var _panel : FlxSprite;
	var mpText : FlxText;
	var _manaIcon : FlxSprite;

	var _pauseButton : FlxButton;
	var _pauseMenu : PauseMenu;

	var _helpButton : FlxButton;
	var _tutorialWindow : TutorialWindow;

	var _startRoundButton : FlxButton;
    public var _manaMax:Int = 10;
    public var _manaCurrent:Int = 10;
	var _levelData:LevelData;
    public var mouseSelectedTarget = 0;

	public function new(newLevelData:LevelData):Void
	{
		super();
        initDeployMenu();
		_levelData = newLevelData;

		_tutorialWindow = new TutorialWindow();
		add(_tutorialWindow);

		_confirmationWindow = new ConfirmationWindow();
		add(_confirmationWindow);

		_pauseMenu = new PauseMenu();
		add(_pauseMenu);
	}

	function initDeployMenu(): Void
	{
		initPanel();
		initMPText();
		initZombieButton();
		initSkeletonButton();
		initHelpButton();
		initPauseButton();
		initStartButton();
	}

	function initHelpButton():Void
	{
		_helpButton = new FlxButton(0, 0, "?", help);

		_helpButton.scale.set(0.6,2);
		_helpButton.updateHitbox();

		_helpButton.label.fieldWidth = _helpButton.width;
        _helpButton.label.alignment = "center";

		_helpButton.label.size = 18;

		_helpButton.x = FlxG.width * 0.9;
		_helpButton.y = FlxG.height * 0.05;

		add(_helpButton);
	}

	function initPauseButton():Void
	{
		_pauseButton = new FlxButton(0, 0, "||", pause);

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
		mpText = new FlxText(FlxG.width * 0.06, FlxG.height * 0.23, 155); // x, y, width
		mpText.setFormat(20, FlxColor.WHITE, CENTER);
		mpText.text = _manaCurrent + "/" + _manaMax;
		add(mpText);

		_manaIcon = new FlxSprite(FlxG.width * 0.05, FlxG.height * 0.19);
		_manaIcon.loadGraphic("assets/images/Mana.png");
        _manaIcon.scale.set(0.47,0.47);
		add(_manaIcon);
	}

    public function MPTextRed():Void {
        mpText.setFormat(20, FlxColor.RED, CENTER);
    }

    public function MPTextWhite():Void {
        mpText.setFormat(20, FlxColor.WHITE, CENTER);
    }

    public function updateMPText():Void {
        mpText.text = _manaCurrent + "/" + _manaMax;
    }

	function initZombieButton():Void
	{
		zombieButton = new FlxUIButton(0, 0, "Zombie", selectZombie);

		zombieButton.scale.set(2,6);
		zombieButton.updateHitbox();

		zombieButton.label.fieldWidth = zombieButton.width;
        zombieButton.label.alignment = "center";

		zombieButton.label.size = 20;
		zombieButton.label.offset.y -= 40;

		zombieButton.x = FlxG.width * 0.05;
		zombieButton.y = FlxG.height * 0.3;

		add(zombieButton);
	}

	function initSkeletonButton():Void
	{
		skeletonButton = new FlxUIButton(0, 0, "Skeleton", selectSkeleton);

		skeletonButton.scale.set(2,6);
		skeletonButton.updateHitbox();

		skeletonButton.label.fieldWidth = skeletonButton.width;
        skeletonButton.label.alignment = "center";

		skeletonButton.label.size = 20;
		skeletonButton.label.offset.y -= 40;

		skeletonButton.x = FlxG.width * 0.05;
		skeletonButton.y = FlxG.height * 0.5;

		add(skeletonButton);
	}

	function initStartButton():Void
	{
		_startRoundButton = new FlxButton(0, 0, "Start Round", startRound);

		_startRoundButton.scale.set(2.5,3.5);
		_startRoundButton.updateHitbox();

		_startRoundButton.label.fieldWidth = _startRoundButton.width;
        _startRoundButton.label.alignment = "center";

		_startRoundButton.label.size = 17;
		_startRoundButton.label.offset.y -= 18;

		_startRoundButton.x = FlxG.width * 0.79;
		_startRoundButton.y = FlxG.height * 0.87;

		add(_startRoundButton);
	}

	function startRound():Void
	{
		if(FlxG.timeScale == 0)
			return;

        _confirmationWindow.show(FlxG.timeScale, _manaCurrent, _levelData);
	}

	private function selectZombie():Void
	{
		if(FlxG.timeScale == 0)
			return;

		if(_manaCurrent == 0) {
            mouseSelectedTarget = -1;
			return;
        }

        mouseSelectedTarget = 1;

        // Change the cursor to the zombie's image
        var sprite = new FlxSprite();
        sprite.loadGraphic("assets/images/Zombie.png");
        var xOffset:Int = -Std.int(sprite.width * 0.4);
        var yOffset:Int = -Std.int(sprite.height * 0.9);

        FlxG.mouse.load(sprite.pixels, 1, xOffset, yOffset);
	}

	private function selectSkeleton():Void
	{
		if(FlxG.timeScale == 0)
			return;

		if(_manaCurrent == 0) {
            mouseSelectedTarget = -1;
			return;
        }

        mouseSelectedTarget = 2;

        // Change the cursor to the zombie's image
        var sprite = new FlxSprite();
        sprite.loadGraphic("assets/images/Skeleton.png");
        var xOffset:Int = -Std.int(sprite.width * 0.4);
        var yOffset:Int = -Std.int(sprite.height * 0.9);

        FlxG.mouse.load(sprite.pixels, 1, xOffset, yOffset);
	}

	function help():Void
	{
		if(FlxG.timeScale == 0)
			return;

		_tutorialWindow.show(FlxG.timeScale);
		FlxG.timeScale = 0;
	}

	function pause():Void
	{
		if(FlxG.timeScale == 0)
			return;

		_pauseMenu.show(FlxG.timeScale);
        FlxG.timeScale = 0;
	}

}
