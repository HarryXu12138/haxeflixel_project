package;

/**
 * ...
 * @author ...
 */
class LevelData
{
	private var humanUnits:Array<Array<Int>>;
	private var undeadUnits:Array<Array<Int>>;
	private var _level:Int;

	public function new(level:Int)
	{
		humanUnits = [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]];

		undeadUnits = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
		_level = level;
	}

	public function setHumanUnitAtPosition(x:Int, y:Int, unitNum:Int):Void
	{
		if (unitNum >= 3)
		{
			trace("Angry Unit Noises");
		}
		else
		{
			humanUnits[y][x] = unitNum;
		}

	}

	public function getHumanUnitAtPosition(x:Int, y:Int):Int
	{
		return humanUnits[y][x];
	}

	public function getHumanPlacementHeight():Int
	{
		return humanUnits.length;
	}

	public function getHumanPlacementWidth():Int
	{
		return humanUnits[0].length;
	}

	public function setUndeadUnitAtPosition(x:Int, y:Int, unitNum:Int):Void
	{
		if (unitNum >= 3)
		{
			trace("Angry Zombie Noises");
		}
		else
		{
			undeadUnits[y][x] = unitNum;
		}
	}

	public function getUndeadUnitAtPosition(x:Int, y:Int):Int
	{
		return undeadUnits[y][x];
	}

	public function getUndeadPlacementHeight():Int
	{
		return undeadUnits.length;
	}

	public function getUndeadPlacementWidth():Int
	{
		return undeadUnits[0].length;
	}

	public function getLevel():Int
	{
		return _level;
	}

}