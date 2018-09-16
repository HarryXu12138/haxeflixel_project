package;
import flixel.FlxState;

/**
 * ...
 * @author Jared Okun
 */
class SimulationState extends FlxState
{
	
	static var BOARD_WIDTH:Int = 5;
	static var BOARD_HEIGHT:Int = 5;
	
	static var TOP_LEFT_X:Float = 20;
	static var TOP_LEFT_Y:Float = 50;
	
	var _board:Array<Array<Tile>>;
	
	var _lanes:Array<Array<Entity>>;

	var _simulationHUD : SimulationHUD;

	override public function create():Void
	{
		_board = new Array<Array<Tile>>();
		_lanes = new Array<Array<Entity>>();
		for (y in 0...BOARD_HEIGHT)
		{
			_board.push(new Array<Tile>());
			_lanes.push(new Array<Entity>());
			for (x in 0...BOARD_WIDTH)
			{
				_board[y].push(new Tile());
				_board[y][x].setPosition(TOP_LEFT_X + x * _board[y][x].width, TOP_LEFT_Y + y * _board[y][x].height);
				add(_board[y][x]);
			}
		}
		test1();

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
			}
		}
		super.update(elapsed);
	}
	
	private function test1():Void
	{
		var zombie1:Zombie = new Zombie(20, 72);
		add(zombie1);
		_lanes[1].push(zombie1);
		
		var zombie2:Zombie = new Zombie(32, 136);
		add(zombie2);
		_lanes[2].push(zombie2);
		
		var human1:Human = new Human(284, 136);
		add(human1);
		_lanes[2].push(human1);
	
	}
	
}