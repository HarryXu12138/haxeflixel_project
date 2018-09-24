package;

import flixel.FlxState;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import GlobalValues;

// Tooltip buttons
import flixel.addons.ui.Anchor;
import flixel.addons.ui.BorderDef;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.FontDef;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIState;
import openfl.text.TextFormat;
import flixel.text.FlxText.FlxTextBorderStyle;
import openfl.text.TextFormatAlign;
import flixel.addons.ui.FlxUITooltipManager;

import flixel.system.FlxAssets;

class DeploymentState extends FlxUIState
{
    /*
    Deployed Board will be an array of integers.
    0 -- nothing
    1 -- zombie
    */

    private var _deployMenu : DeploymentMenu;
    private var showEnemyButton:FlxButton;

    private var deploymentSpriteGroups:Array<FlxTypedGroup<FlxSprite>>;
    private var deploymentSprites:Array<Array<FlxSprite>>;

    private var boardSprite:Array<Array<Tile>>;
    private var deploymentBoardUpperLeftX:Float = FlxG.width * 0.3;
    private var deploymentBoardUpperLeftY:Float = FlxG.height * 0.2;

    private var manaFlashTimer:Int;
    private var manaTextStatus:Bool;


	private var levelData:LevelData;
    // End variables

	public function new(newLevelData:LevelData)
	{
		levelData = newLevelData;
		super();
	}


    override public function create():Void
    {
        super.create();
        initBackground();
        initDeploymentArea();
        initShowEnemyButton();
        _deployMenu = new DeploymentMenu(levelData);
        add(_deployMenu);
        initToolTips();
    }

    function initToolTips():Void
	{
        var largerFont = makeFontDef("nokia", 12, TextFormatAlign.LEFT);

        _deployMenu.zombieButton = addToolTip("Zombie", _deployMenu.zombieButton, "Cost: 1 MP", "Moves slower, but has more HP.",
        {
            titleWidth: 120,
            bodyWidth: 120,
            titleFormat:largerFont,
            bodyFormat:largerFont,
            leftPadding:5,
            rightPadding:5,
            topPadding:5,
            bottomPadding:5,
        });
        _deployMenu.skeletonButton = addToolTip("Skeleton", _deployMenu.skeletonButton, "Cost: 1 MP", "Moves faster, but has less HP.",
        {
            titleWidth: 120,
            bodyWidth: 120,
            titleFormat:largerFont,
            bodyFormat:largerFont,
            leftPadding:5,
            rightPadding:5,
            topPadding:5,
            bottomPadding:5,
        });
	}

    // Taken from Haxeflixel Tooltips demo code
    function makeFontDef(name:String, size:Int, alignment = null, isBold:Bool = true, color:FlxColor = FlxColor.BLACK, extension:String = ".ttf"):FontDef
	{
		var suffix:String = isBold ? "b" : "";
		return new FontDef(name, extension, "assets/fonts/" + name + suffix + extension, new TextFormat(null, size, color, isBold, null, null, null, null, alignment));
	}

	// Modified from Haxeflixel Tooltips demo code
	function addToolTip(name:String="", b:FlxUIButton, title:String = "", body:String = "", anchor:Anchor = null, style:FlxUITooltipStyle = null):FlxUIButton
	{
		tooltips.add(b, { title:title, body:body, anchor:anchor, style:style } );
		return b;
	}
    
    function initBackground():Void{
        var background = new FlxSprite(0,20);
        background.alpha = 0.7;
		background.loadGraphic("assets/images/NECROBG.png");
		add(background);
    }

    private function initShowEnemyButton():Void {
        showEnemyButton = new FlxButton(0, 0, "Show Enemy", showEnemy);
        //showEnemyButton.loadGraphic("assets/images/custom.png");

        showEnemyButton.scale.set(1.5,2);
        showEnemyButton.updateHitbox();

        showEnemyButton.label.fieldWidth = showEnemyButton.width;
        showEnemyButton.label.alignment = "center";

        showEnemyButton.label.size = 10;
        showEnemyButton.label.offset.y -= 7;

        showEnemyButton.x = FlxG.width * 0.85;
        showEnemyButton.y = FlxG.height * 0.6;

        add(showEnemyButton);
    }

	private function showEnemy():Void {
        if(FlxG.timeScale == 0)
            return;

        // We can only call openSubState inside a state class
        var subState:ShowEnemySubState = new ShowEnemySubState(0xff000000);
        subState.updateLevelData(levelData);
        openSubState(subState);
	}

    // Initialize the board sprite array
    // Initialize the array that record the deployment result
    private function initDeploymentArea():Void {
        manaFlashTimer = 0;
        manaTextStatus = true;
        deploymentSpriteGroups = new Array<FlxTypedGroup<FlxSprite>>();
        deploymentSprites = new Array<Array<FlxSprite>>();
        boardSprite = new Array<Array<Tile>>();
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            deploymentSpriteGroups.push(new FlxTypedGroup<FlxSprite>());
            boardSprite.push(new Array<Tile>());
            deploymentSprites.push(new Array<FlxSprite>());
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                boardSprite[j].push(new Tile());
                boardSprite[j][i].setPosition(deploymentBoardUpperLeftX + i * boardSprite[j][i].width, deploymentBoardUpperLeftY + j * boardSprite[j][i].height);
                add(boardSprite[j][i]);
                deploymentSprites[j].push(new FlxSprite());
            }
            add(deploymentSpriteGroups[j]);
        }
    }

    // After mouse released in (X, Y), this function will be call
    // Record the deplyment to the array
    private function deploy(x:Float, y:Float) {
        if (_deployMenu._manaCurrent == 0) {
            manaFlashTimer = 120;
            return;
        }
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                var minX = deploymentBoardUpperLeftX + i * boardSprite[j][i].width;
                var minY = deploymentBoardUpperLeftY + j * boardSprite[j][i].height;
                var maxX = minX + boardSprite[j][i].width;
                var maxY = minY + boardSprite[j][i].height;
                if (x >= minX && x < maxX && y >= minY && y < maxY) {
                    if(levelData.getUndeadUnitAtPosition(i, j) == _deployMenu.mouseSelectedTarget) return;
                    if(levelData.getUndeadUnitAtPosition(i, j) != 0 && levelData.getUndeadUnitAtPosition(i, j) != _deployMenu.mouseSelectedTarget) deploymentSpriteGroups[j].remove(deploymentSprites[j][i]);
                    var sprite = new FlxSprite();
                    if (_deployMenu.mouseSelectedTarget == 1) sprite.loadGraphic("assets/images/Zombie.png");
                    else if (_deployMenu.mouseSelectedTarget == 2) sprite.loadGraphic("assets/images/Skeleton.png");

                    sprite.setPosition(minX + sprite.width * 0.15, minY - sprite.height * 0.6);
                    deploymentSpriteGroups[j].add(sprite);
                    deploymentSprites[j][i] = sprite;
                    levelData.setUndeadUnitAtPosition(i, j, _deployMenu.mouseSelectedTarget);
                    break;
                }
            }
        }
        calculateManaCost();
        FlxG.mouse.unload();
        _deployMenu.mouseSelectedTarget = 0;
    }

    private function cancelDeploy(x:Float, y:Float) {
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                var minX = deploymentBoardUpperLeftX + i * boardSprite[j][i].width;
                var minY = deploymentBoardUpperLeftY + j * boardSprite[j][i].height;
                var maxX = minX + boardSprite[j][i].width;
                var maxY = minY + boardSprite[j][i].height;
                if (x >= minX && x < maxX && y >= minY && y < maxY) {
                    if (levelData.getUndeadUnitAtPosition(i, j) == 0) return;
					levelData.setUndeadUnitAtPosition(i, j, 0);
                    deploymentSpriteGroups[j].remove(deploymentSprites[j][i]);
                    deploymentSprites[j][i] = new FlxSprite();
                }
            }
        }
        calculateManaCost();
    }

    private function calculateManaCost() {
        var cost:Int = 0;
        for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
            for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
                if (levelData.getUndeadUnitAtPosition(i, j) == 1) cost += 1;
                else if (levelData.getUndeadUnitAtPosition(i, j) == 2) cost += 1;
            }
        }
        _deployMenu._manaCurrent = _deployMenu._manaMax - cost;
        _deployMenu.updateMPText();
    }

    // When update frames, check the mouse status and call deploy if necessary
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if(FlxG.timeScale == 0)
            return;

        // Update the mana bar flash status
        if (manaFlashTimer > 0) {
            manaFlashTimer -= 1;
            if (manaFlashTimer % 12 == 0) {
                if (manaTextStatus) _deployMenu.MPTextRed();
                else _deployMenu.MPTextWhite();
                manaTextStatus = !manaTextStatus;
            }
        } else if (!manaTextStatus) {
            _deployMenu.MPTextWhite();
            manaTextStatus = true;
        }
        if (_deployMenu.mouseSelectedTarget != 0) {
            // Right click to cancel
            if (FlxG.mouse.pressedRight) {
                FlxG.mouse.unload();
                _deployMenu.mouseSelectedTarget = 0;
            // Left click to deploy
            } else if (FlxG.mouse.justPressed) {
                deploy(FlxG.mouse.x, FlxG.mouse.y);
            }
        } else {
            if (FlxG.mouse.pressedRight) cancelDeploy(FlxG.mouse.x, FlxG.mouse.y);
        }
    }
}