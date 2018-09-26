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

	static var BOARD_WIDTH:Int = 8;
	static var BOARD_HEIGHT:Int = 5;

	static var TOP_LEFT_X:Float = 0;
	static var TOP_LEFT_Y:Float = 480;

	var _board:Array<Array<Tile>>;

	var _lanes:Array<List<Entity>>;
	private var _levelData:LevelData;
	var entityGroup:FlxGroup;
	static var undeadOffsetY:Int = 394;
	static var humanOffsetY:Int = 424;
	static var humanOffsetX:Int = 56;
	static var zombieOffsetX:Int = -744;

	var _simulationHUD : SimulationHUD;
	
	private static var necroGirlX:Int = 50;
	private static var necroGirlY:Int = 280;
	
	public var beatenLanes:Array<Bool>;
	
	
	public function new(newLevelData:LevelData)
	{
		_levelData = newLevelData;
		super();
	}
	
	override public function create():Void
	{
		add(new Background(_levelData.getBackgroundPath()));
		_board = new Array<Array<Tile>>();
		_lanes = new Array<List<Entity>>();
		entityGroup = new FlxGroup();
		beatenLanes = [false, false, false, false, false];
		for (y in 0...BOARD_HEIGHT)
		{
			_board.push(new Array<Tile>());
			_lanes.push(new List<Entity>());
			for (x in 0...BOARD_WIDTH)
			{
				_board[y].push(new Tile(_levelData.getTilePath()));
				//_board[y][x].loadGraphic(_levelData.getTilePath());
				_board[y][x].setPosition(TOP_LEFT_X + x * _board[y][x].width, TOP_LEFT_Y + y * _board[y][x].height);
				add(_board[y][x]);
			}
		}
		placeUnits();
		add(entityGroup);
		_simulationHUD = new SimulationHUD();
		add(_simulationHUD);
		var necroGirl:NecroGirl = new NecroGirl(necroGirlX, necroGirlY);
		entityGroup.add(necroGirl);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		var undeadTroopsLeft:Bool = false;
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
					if(entity.x >= 1280)
						beatenLanes[i] = true;
					else
						undeadTroopsLeft = true;
				}
			}
		}

		if(undeadTroopsLeft == false)
			gameOver();

		if (checkWin())
		{
			if(_levelData.getLevel() == 2){
				gameWon();
			}else{
				goToCastle();
			}
		}
		super.update(elapsed);
	}
	
	// Player fails to beat level
	private function gameOver():Void
	{
		_simulationHUD.showEndLevelScreen(_levelData, 0);
	}

	// Passes level 1 -> go on to level 2
	private function goToCastle():Void
	{
		_simulationHUD.showEndLevelScreen(_levelData, 1);
	}

	// Passed level 2 -> Player wins the game
	private function gameWon():Void
	{
		_simulationHUD.showEndLevelScreen(_levelData, 2);
	}
	
	private function checkWin():Bool
	{
		var amount:Int = 0;
		for (bool in beatenLanes)
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
					unit = new Soldier(humanOffsetX + x * _board[0][0].width, undeadOffsetY + y * _board[0][0].height);
					entityGroup.add(unit);
					_lanes[y].add(unit);
				}
				else if (_levelData.getHumanUnitAtPosition(x, y) == 2)
				{
					unit = new Archer(humanOffsetX + x * _board[0][0].width, undeadOffsetY + y * _board[0][0].height, entityGroup);
					entityGroup.add(unit);
					_lanes[y].add(unit);
				}
			}
			
			for (x in 0..._levelData.getUndeadPlacementWidth())
			{
				var unit:Undead;
				if (_levelData.getUndeadUnitAtPosition(x, y) == 1)
				{
					unit = new Zombie(zombieOffsetX + x * _board[0][0].width, undeadOffsetY + y * _board[0][0].height);
					
					entityGroup.add(unit);
					_lanes[y].add(unit);
				}
				else if (_levelData.getUndeadUnitAtPosition(x, y) == 2)
				{
					unit = new Skeleton(zombieOffsetX + x * _board[0][0].width, undeadOffsetY + y * _board[0][0].height);
					
					entityGroup.add(unit);
					_lanes[y].add(unit);
				}
			}
		}
	}
}