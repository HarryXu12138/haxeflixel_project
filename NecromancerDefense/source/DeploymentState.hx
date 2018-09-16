package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import SimulationState;

class DeploymentState extends FlxState
{
    /*
    Deployed Board will be an array of integers.
    0 -- nothing
    1 -- zombie
    2 -- skeleton
    */
	var _zombieButton : FlxButton;
	var _skeletonButton : FlxButton;
	var _startButton : FlxButton;
	var panel : FlxSprite;

	var mpText : FlxText;

    // Deployment area variables
    var boardSprite:Array<Array<Tile>>;
    var boardDeployment:Array<Array<Int>>;
    var deploymentBoardUpperLeftX:Float = FlxG.width * 0.3;
    var deploymentBoardUpperLeftY:Float = FlxG.height * 0.2;

    var mouseSelectedTarget = 0;
    // End variables

	override public function create():Void
	{
		super.create();
        initDeploymentArea();
		initCharSelectionMenu();
	}

    private function initDeploymentArea():Void {
        boardSprite = new Array<Array<Tile>>();
        boardDeployment = new Array<Array<Int>>();
        for (j in 0...SimulationState.BOARD_HEIGHT) {
            boardSprite[j] = new Array<Tile>();
            boardDeployment[j] = new Array<Int>();
            for (i in 0...SimulationState.BOARD_WIDTH) {
                boardSprite[j].push(new Tile());
                boardDeployment[j].push(0);
                boardSprite[j][i].setPosition(deploymentBoardUpperLeftX + i * boardSprite[j][i].width, deploymentBoardUpperLeftY + j * boardSprite[j][i].height);
                add(boardSprite[j][i]);
            }
        }
    }

    private function deploy(X:Float, Y:Float) {
    }

	override public function update(elapsed:Float):Void
	{
        if (mouseSelectedTarget != 0) {
            if (FlxG.mouse.pressedRight) {
                FlxG.mouse.unload();
                mouseSelectedTarget = 0;
            } else if (FlxG.mouse.justPressed) {
                deploy(FlxG.mouse.x, FlxG.mouse.y);
                FlxG.mouse.unload();
                mouseSelectedTarget = 0;
            }
        }
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
        mouseSelectedTarget = 1;
        var sprite = new FlxSprite();
        sprite.loadGraphic("assets/images/zombie.jpg");

        FlxG.mouse.load(sprite.pixels);
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
