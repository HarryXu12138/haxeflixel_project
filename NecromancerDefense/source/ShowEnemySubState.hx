package;

import flixel.FlxState;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import GlobalValues;

class ShowEnemySubState extends FlxSubState {
    /*
    0 -- nothing
    1 -- human type 1
    2 -- human type 2
    */

    // Buttons variables
    private var returnToDeploymentButton:FlxButton;
    // End variables

    // Board variables
    private var boardSprite:Array<Array<Tile>>;
    private var entitySprite:Array<Array<FlxSprite>>;
    private var boardUpperLeftX:Float = FlxG.width * 0;
    private var boardUpperLeftY:Float = FlxG.height * 0.3;
    // End variables

    private var levelData:LevelData;

    override public function create():Void {
        super.create();
        initBackground();
        initBoardArea();
        initButtons();
    }

    public function updateLevelData(newLevelData:LevelData) {
        levelData = newLevelData;
    }

    function initBackground():Void{
        var background = new FlxSprite(0,20);
        background.alpha = 0.7;
		background.loadGraphic("assets/images/NECROBG.png");
		add(background);
    }

    private function initBoardArea():Void {
        boardSprite = new Array<Array<Tile>>();
        var group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
        add(group);
        for (j in 0...GlobalValues.BOARD_HEIGHT) {
            boardSprite[j] = new Array<Tile>();
            for (i in 0...GlobalValues.BOARD_WIDTH) {
                boardSprite[j].push(new Tile(levelData.getTilePath()));
                boardSprite[j][i].setPosition(boardUpperLeftX + i * boardSprite[j][i].width, boardUpperLeftY + j * boardSprite[j][i].height);
                var unit:Human;
                var unit_x:Float = i * boardSprite[0][0].width;
                var unit_y:Float = j * boardSprite[0][0].height;
                group.add(boardSprite[j][i]);
                if (levelData.getHumanUnitAtPosition(i, j) == 1) {
                    unit = new Soldier(0, 0);
                    unit_x += unit.width;
                    unit_y += 170;
                    unit.setPosition(unit_x, unit_y);
                    add(unit);
                } else if (levelData.getHumanUnitAtPosition(i, j) == 2) {
                    unit = new Archer(0, 0, null);
                    unit_x += unit.width;
                    unit_y += 170;
                    unit.setPosition(unit_x, unit_y);
                    add(unit);
                }
            }
        }
    }

    private function initButtons():Void {
        returnToDeploymentButton = new FlxButton(0, 0, "Return", returnToDeployment);
        returnToDeploymentButton.scale.set(1.2,4.2);
        returnToDeploymentButton.updateHitbox();

        returnToDeploymentButton.label.fieldWidth = returnToDeploymentButton.width;
        returnToDeploymentButton.label.alignment = "center";

        returnToDeploymentButton.label.size = 14;
        returnToDeploymentButton.label.offset.y -= 28;

        returnToDeploymentButton.x = FlxG.width * 0.9;
        returnToDeploymentButton.y = FlxG.height * 0.1;
        add(returnToDeploymentButton);
    }

    private function returnToDeployment():Void {
        close();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }
}