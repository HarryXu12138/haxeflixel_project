package;

import GlobalValues;
import flixel.system.FlxAssets.FlxSoundAsset;

/**
 * ...
 * @author ...
 */
class LevelData
{
	private var humanUnits:Array<Array<Int>>;
	private var undeadUnits:Array<Array<Int>>;
	private var _level:Int;
	
	private var _backgroundPath:String;
	private var _tilePath:String;
	private var _music:FlxSoundAsset;

	public function new(level:Int, backgroundPath:String, tilePath:String, music:FlxSoundAsset)
	{
		humanUnits = new Array<Array<Int>>();
		for (j in 0...GlobalValues.BOARD_HEIGHT) {
			humanUnits.push(new Array<Int>());
			for (i in 0...GlobalValues.BOARD_WIDTH) {
				humanUnits[j].push(0);
			}
		}

		undeadUnits = new Array<Array<Int>>();
		for (j in 0...GlobalValues.DEPLOYMENT_HEIGHT) {
			undeadUnits.push(new Array<Int>());
			for (i in 0...GlobalValues.DEPLOYMENT_WIDTH) {
				undeadUnits[j].push(0);
			}
		}
		_level = level;
		_backgroundPath = backgroundPath;
		_tilePath = tilePath;
		_music = music;
	}

	public function setHumanUnitAtPosition(x:Int, y:Int, unitNum:Int):Void
	{
		if (unitNum >= 3)
		{
			trace("Error: Unit " + unitNum + " does not exist");
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
			trace("Error: Undead " + unitNum + " does not exist");
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
	
	public function getBackgroundPath():String
	{
		return _backgroundPath;
	}
	public function getTilePath():String
	{
		return _tilePath;
	}
	public function getMusic():FlxSoundAsset
	{
		return _music;
	}
	
}