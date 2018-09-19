package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
/**
 * ...
 * @author Jared Okun
 */
class Zombie extends Entity 
{
	
	static var SPEED:Int = 150;
	static var STARTING_HEALTH:Int = 3;
	static var ATTACK_DELAY:Int = 24;
	
	var _target:Entity;
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.GREEN);
		velocity.set(SPEED, 0);
		attackDelay = ATTACK_DELAY;
		_hp = STARTING_HEALTH;
	}
	
	override public function overlapInLane(other:Entity):Bool
	{
		
		return super.overlapInLane(other) && Std.is(other, Human);
	}
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (alive)
		{
			if (_fighting)
			{
				
				var targets:List<Entity> = new List<Entity>();
				targets.add(_target);
				fight(targets, 1);
				if (_target.alive == false)
				{
					_attack_frame = 0;
					_fighting = false;
				}
					
			}
			else
			{
				var isColliding:Bool = false;
				var collidingEntity:Entity = null;
				for (entity in lane)
				{
					if (overlapInLane(entity))
					{
						isColliding = true;
						collidingEntity = entity;
						break;
					}
				}
				if (isColliding)
				{
					_fighting = true;
					_attack_frame = 0;
					_target = collidingEntity;
					velocity.set(0, 0);
				}
				else
				{
					velocity.set(SPEED, 0);
				}
			}
		}
	}
	
}