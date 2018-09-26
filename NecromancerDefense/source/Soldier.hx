package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jared Okun
 */
class Soldier extends Human 
{
	
	static var STARTING_HEALTH:Int = 9;
	static var ATTACK_DELAY:Int = 21;
	
	var _targets:List<Entity>;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic("assets/images/TANK_ALL.png", true, 220, 255);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("attack", [4, 5, 6, 7], 12, true);
		animation.add("stand", [0, 1, 2, 3], 12, true);
		animation.add("death", [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 12, false);
		_hp = STARTING_HEALTH;
		attackDelay = ATTACK_DELAY;
		_targets = new List<Entity>();
	}
	
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (alive)
		{
			
			if (_fighting)
			{
				if(animation.name != "attack"){
					animation.play("attack");
				}
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
				animation.play("stand");
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