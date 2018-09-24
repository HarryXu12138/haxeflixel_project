package;

/**
 * ...
 * @author ...
 */
class LevelFactory 
{

	static public function generateLevel1():LevelData
	{
		var level:LevelData = new LevelData(1, "assets/images/NECROBG.png", "assets/images/gridTile.png");
		level.setHumanUnitAtPosition(5, 0, 2);
		level.setHumanUnitAtPosition(7, 0, 1);
		level.setHumanUnitAtPosition(6, 0, 1);
		level.setHumanUnitAtPosition(6, 1, 2);
		level.setHumanUnitAtPosition(5, 1, 2);
		level.setHumanUnitAtPosition(6, 2, 1);
		level.setHumanUnitAtPosition(7, 2, 1);
		level.setHumanUnitAtPosition(8, 2, 1);
		level.setHumanUnitAtPosition(6, 3, 1);
		level.setHumanUnitAtPosition(7, 3, 2);
		level.setHumanUnitAtPosition(8, 3, 2);
		level.setHumanUnitAtPosition(4, 4, 2);
		level.setHumanUnitAtPosition(3, 4, 2);
		level.setHumanUnitAtPosition(5, 4, 2);
		
		return level;
	}
	
	
	
	static public function getNextLevel(currentLevelNum:Int):LevelData
	{
		if (currentLevelNum == 1)
		{
			return generateLevel2();
		}
		
	}
	
	static public function generateLevel2():LevelData
	{
		var level:LevelData = new LevelData(2, "assets/images/NECROBG2.png", "assets/images/gridTile2.png");
	}
	
}