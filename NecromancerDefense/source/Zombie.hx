package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
/**
 * ...
 * @author Jared Okun
 */
class Zombie extends Undead 
{
	
	static var SPEED:Int = 150;
	static var STARTING_HEALTH:Int = 15;
	static var ATTACK_DELAY:Int = 24;
	
	var _target:Entity;
	
	var movementSpeed:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(48, 96, FlxColor.GREEN);
		loadGraphic("assets/images/ZOMBIE_WALK.png", true, 192, 188);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
		animation.play("walk");
		movementSpeed = SPEED;
		velocity.set(movementSpeed, 0);
		attackDelay = ATTACK_DELAY;
		_hp = STARTING_HEALTH;
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
					velocity.set(movementSpeed, 0);
				}
			}
		}
	}
	
}