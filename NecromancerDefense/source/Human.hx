package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jared Okun
 */
class Human extends Entity 
{
	
	static var STARTING_HEALTH:Int = 3;
	static var ATTACK_DELAY:Int = 12;
	
	var _targets:List<Entity>;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.BLUE);
		_hp = STARTING_HEALTH;
		attackDelay = ATTACK_DELAY;
		_targets = new List<Entity>();
	}
	
	override public function overlapInLane(other:Entity):Bool
	{
		
		return super.overlapInLane(other) && Std.is(other, Zombie);
	}
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (alive)
		{
			
			if (_fighting)
			{
				fight(_targets, 1);
			}
			
			for (entity in lane)
			{
				if (overlapInLane(entity) && !targetsContains(entity))
				{
					_targets.add(entity);
					_fighting = true;
				}
			}
			
			for (entity in _targets)
			{
				if (!entity.alive)
				{
					_targets.remove(entity);
				}
			}
			if (_targets.isEmpty())
			{
				_attack_frame = 0;
				_fighting = false;
			}
		}
	}
	
	private function targetsContains(entity:Entity)
	{
		for (target in _targets)
		{
			if (entity == target)
			{
				return true;
			}
		}
		return false;
	}
	
}