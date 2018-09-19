package;
import flixel.FlxState;

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

	public static var deploymentUnits:Array<Array<Int>>;
	public static var humanUnits:Array<Array<Int>> = [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]];


	static var entityOffsetY:Int = 424;
	static var humanOffsetX:Int = 56;
	static var zombieOffsetX:Int = -744;

	var _simulationHUD : SimulationHUD;
	override public function create():Void
	{
		add(new Background("assets/images/NECROBG.png"));
		_board = new Array<Array<Tile>>();
		_lanes = new Array<List<Entity>>();
		for (y in 0...BOARD_HEIGHT)
		{
			_board.push(new Array<Tile>());
			_lanes.push(new List<Entity>());
			for (x in 0...BOARD_WIDTH)
			{
				_board[y].push(new Tile());
				_board[y][x].setPosition(TOP_LEFT_X + x * _board[y][x].width, TOP_LEFT_Y + y * _board[y][x].height);
				add(_board[y][x]);
			}
		}
		test2();
		placeUndeadUnits();
		placeHumanUnits();
		_simulationHUD = new SimulationHUD();
		add(_simulationHUD);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		for (lane in _lanes)
		{
			for (entity in lane)
			{
				entity.act(lane);
				if (!entity.alive)
				{
					lane.remove(entity);
				}
			}
		}
		super.update(elapsed);
	}

	private function test1():Void
	{

		var zombie1:Zombie = new Zombie(20, 472);
		add(zombie1);
		_lanes[1].add(zombie1);

		var zombie2:Zombie = new Zombie(32, 520);
		add(zombie2);
		_lanes[2].add(zombie2);

		var human1:Human = new Human(1176, 520);
		add(human1);
		_lanes[2].add(human1);

	}

	private function test2():Void
	{
		deploymentUnits[0] = [2, 2, 2, 1, 1];
		humanUnits[0] = [0, 0, 0, 0, 0, 0, 1, 1];
	}

	private function placeUndeadUnits():Void
	{

		for (y in 0...deploymentUnits.length)
		{
			for (x in 0...deploymentUnits[y].length)
			{
				var unit:Zombie;
				if (deploymentUnits[y][x] == 1)
				{
					unit = new Zombie(zombieOffsetX + x * _board[0][0].width, entityOffsetY + y * _board[0][0].height);
					add(unit);
					_lanes[y].add(unit);
				}
				else if (deploymentUnits[y][x] == 2)
				{
					unit = new Skeleton(zombieOffsetX + x * _board[0][0].width, entityOffsetY + y * _board[0][0].height);
					add(unit);
					_lanes[y].add(unit);
				}

			}
		}
	}

	private function placeHumanUnits():Void
	{
		for (y in 0...humanUnits.length)
		{
			for (x in 0...humanUnits[y].length)
			{
				var unit:Human;
				if (humanUnits[y][x] == 1)
				{
					unit = new Human(humanOffsetX + x * _board[0][0].width, entityOffsetY + y * _board[0][0].height);
					add(unit);
					_lanes[y].add(unit);
				}
			}
		}
	}

}