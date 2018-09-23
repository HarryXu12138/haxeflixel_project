package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import GlobalValues;


class DeploymentState extends FlxState
{
    /*
    Deployed Board will be an array of integers.
    0 -- nothing
    1 -- zombie
    */

	var _deployMenu : DeploymentMenu;
	private var showEnemyButton:FlxButton;	

    // Deployment area variables
    private var boardSprite:Array<Array<Tile>>;
    private var deploymentBoardUpperLeftX:Float = FlxG.width * 0.3;
    private var deploymentBoardUpperLeftY:Float = FlxG.height * 0.2;
	
	
	private var levelData:LevelData;
    // End variables
	
	public function new(newLevelData:LevelData)
	{
		
		levelData = newLevelData;
		super();
	}
	

	override public function create():Void
	{
		
        initDeploymentArea();
		_deployMenu = new DeploymentMenu(levelData);
		add(_deployMenu);
		initShowEnemyButton();
		
		super.create();		
	}

	
	private function initShowEnemyButton():Void {
        showEnemyButton = new FlxButton(FlxG.width * 0.9, FlxG.height * 0.9, "Show Enemy", showEnemy);
        showEnemyButton.updateHitbox();
        showEnemyButton.label.alignment = "center";
    }

	private function showEnemy():Void {
        openSubState(new ShowEnemySubState());
    }

    // Initialize the board sprite array
    // Initialize the array that record the deployment result
    private function initDeploymentArea():Void {
        boardSprite = new Array<Array<Tile>>();
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            boardSprite[j] = new Array<Tile>();
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                boardSprite[j].push(new Tile());
                boardSprite[j][i].setPosition(deploymentBoardUpperLeftX + i * boardSprite[j][i].width, deploymentBoardUpperLeftY + j * boardSprite[j][i].height);
                add(boardSprite[j][i]);
            }
        }
    }

    // After mouse released in (X, Y), this function will be call
    // Record the deplyment to the array
    private function deploy(x:Float, y:Float) {
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                var minX = deploymentBoardUpperLeftX + i * boardSprite[j][i].width;
                var minY = deploymentBoardUpperLeftY + j * boardSprite[j][i].height;
                var maxX = minX + boardSprite[j][i].width;
                var maxY = minY + boardSprite[j][i].height;
                if (x >= minX && x < maxX && y >= minY && y < maxY) {
					levelData.setUndeadUnitAtPosition(i, j, _deployMenu.mouseSelectedTarget);
                    var sprite = new FlxSprite();
                    sprite.setPosition(minX, minY);
                    add(sprite);
                    break;
                }
            }
        }
    }

    // When update frames, check the mouse status and call deploy if necessary
	override public function update(elapsed:Float):Void
	{
        if (_deployMenu.mouseSelectedTarget != 0) {
            // Right click to cancel
            if (FlxG.mouse.pressedRight) {
                FlxG.mouse.unload();
                _deployMenu.mouseSelectedTarget = 0;
            // Left click to deploy
            } else if (FlxG.mouse.justPressed) {
                deploy(FlxG.mouse.x, FlxG.mouse.y);
                FlxG.mouse.unload();
                _deployMenu.mouseSelectedTarget = 0;
            }
        }
		super.update(elapsed);
	}
}
