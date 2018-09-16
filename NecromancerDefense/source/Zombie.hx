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
	
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.GREEN);
		velocity.set(SPEED, 0);
		_hp = STARTING_HEALTH;
	}
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (alive)
		{
			if (_fighting)
			{
				_attack_frame++;
				if (_attack_frame == ATTACK_DELAY)
				{
					_attack_frame = 0;
					_target.hit();
					trace("on");
					
				}
				if (_target.alive == false)
				{
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