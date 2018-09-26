package;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.FlxG;
/**
 * ...
 * @author Jared Okun
 */
class SimulationState extends FlxState
{

	private var TOP_LEFT_X:Float = 0;
	private var TOP_LEFT_Y:Float = 480;
	
	private var UNDEAD_OFFSET_Y:Int = 394;
	private var UNDEAD_OFFSET_X:Int = -744;
	private var HUMAN_OFFSET_Y:Int = 424;
	private var HUMAN_OFFSET_X:Int = 56;
	
	private var NECROGIRL_X:Int = 30;
	private var NECROGIRLY:Int = 180;
	private var MAIN_KNIGHT_X:Int = 1080;
	private var MAIN_KNIGHT_Y:Int = 200;

	private var _board:Array<Array<Tile>>;
	private var _lanes:Array<List<Entity>>;
	private var _levelData:LevelData;
	private var _entityGroup:FlxGroup;
	private var _simulationHUD : SimulationHUD;
	private var _beatenLanes:Array<Bool>;
    private var _showGoToCastleWindow:Bool = false;


	public function new(newLevelData:LevelData)
	{
		_levelData = newLevelData;
		super();
	}

	override public function create():Void
	{
		add(new Background(_levelData.getBackgroundPath()));
		FlxG.sound.playMusic(_levelData.getMusic());
		_board = new Array<Array<Tile>>();
		_lanes = new Array<List<Entity>>();
		_entityGroup = new FlxGroup();

		var necroGirl:NecroGirl = new NecroGirl(NECROGIRL_X, NECROGIRLY);
		var mainKnight:MainKnight = new MainKnight(MAIN_KNIGHT_X, MAIN_KNIGHT_Y);
		_entityGroup.add(necroGirl);
		_entityGroup.add(mainKnight);

		_beatenLanes = [false, false, false, false, false];
		for (y in 0...GlobalValues.BOARD_HEIGHT)
		{
			_board.push(new Array<Tile>());
			_lanes.push(new List<Entity>());
			for (x in 0...GlobalValues.BOARD_WIDTH)
			{
				_board[y].push(new Tile(_levelData.getTilePath()));
				_board[y][x].setPosition(TOP_LEFT_X + x * _board[y][x].width, TOP_LEFT_Y + y * _board[y][x].height);
				add(_board[y][x]);
			}
		}
		placeUnits();
		add(_entityGroup);
		_simulationHUD = new SimulationHUD();
		add(_simulationHUD);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
        super.update(elapsed);
		var undeadTroopsLeft:Bool = false;
		//Have all entities run their act methods
		for (i in 0..._lanes.length)
		{
			var lane:List<Entity> = _lanes[i];
			for (entity in lane)
			{

				entity.act(lane);
				if (!entity.alive)
				{
					lane.remove(entity);
				}
				else if (Std.is(entity, Undead)){
					//If an undead goes offscreen, then that lane is beaten
					if(entity.x >= 1280)
						_beatenLanes[i] = true;
					else
						undeadTroopsLeft = true;
				}
			}
		}

		if (checkWin())
		{
			if(_levelData.getLevel() == 2){
				gameWon();
                return;
			} else {
				goToCastle();
			}
		}

        if(undeadTroopsLeft == false)
            gameOver();
	}

	// Player fails to beat level
	private function gameOver():Void
	{
        if (_showGoToCastleWindow) return;
        var endState:GameEndState = new GameEndState();
        // Have to first update win/lose situation than init the background image
        endState.updateWinLoseStatus(0);
        endState.initBackground();
		FlxG.switchState(endState);
	}

	// Passes level 1 -> go on to level 2
	private function goToCastle():Void
	{
        _showGoToCastleWindow = true;
		_simulationHUD.showEndLevelScreen(_levelData, 1);
	}

	// Passed level 2 -> Player wins the game
	private function gameWon():Void
	{
        if (_showGoToCastleWindow) return;
        var endState:GameEndState = new GameEndState();
        // Have to first update win/lose situation than init the background image
        endState.updateWinLoseStatus(1);
        endState.initBackground();
		FlxG.switchState(endState);
	}

	private function checkWin():Bool
	{
		var amount:Int = 0;
		for (bool in _beatenLanes)
		{
			if (bool)
			{
				amount++;
			}
		}
		return amount >= 3;
	}

	private function placeUnits():Void
	{
		if (_levelData.getHumanPlacementHeight() != _levelData.getUndeadPlacementHeight()) return;
		for (y in 0..._levelData.getHumanPlacementHeight())
		{
			for (x in 0..._levelData.getHumanPlacementWidth())
			{
				var unit:Human;
				if (_levelData.getHumanUnitAtPosition(x, y) == 1)
				{
					unit = new Soldier(HUMAN_OFFSET_X + x * _board[0][0].width, UNDEAD_OFFSET_Y + y * _board[0][0].height);
					_entityGroup.add(unit);
					_lanes[y].add(unit);
				}
				else if (_levelData.getHumanUnitAtPosition(x, y) == 2)
				{
					unit = new Archer(HUMAN_OFFSET_X + x * _board[0][0].width, UNDEAD_OFFSET_Y + y * _board[0][0].height, _entityGroup);
					_entityGroup.add(unit);
					_lanes[y].add(unit);
				}
			}

			for (x in 0..._levelData.getUndeadPlacementWidth())
			{
				var unit:Undead;
				if (_levelData.getUndeadUnitAtPosition(x, y) == 1)
				{
					unit = new Zombie(UNDEAD_OFFSET_X + x * _board[0][0].width, UNDEAD_OFFSET_Y + y * _board[0][0].height);

					_entityGroup.add(unit);
					_lanes[y].add(unit);
				}
				else if (_levelData.getUndeadUnitAtPosition(x, y) == 2)
				{
					unit = new Skeleton(UNDEAD_OFFSET_X + x * _board[0][0].width, UNDEAD_OFFSET_Y + y * _board[0][0].height);

					_entityGroup.add(unit);
					_lanes[y].add(unit);
				}
			}
		}
	}
}