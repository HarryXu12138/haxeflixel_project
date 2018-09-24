package;

import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Archer extends Human 
{

	static var STARTING_HEALTH:Int = 5;
	static var ATTACK_DELAY:Int = 42;
	static var X_OFFSET:Int = -10;
	static var Y_OFFSET:Int = 30;
	
	
	var _entityGroup:FlxGroup;
	
	
	public function new(?X:Float=0, ?Y:Float=0, entityGroup:FlxGroup) 
	{
		super(X, Y);
		loadGraphic("assets/images/ARCHER_ATTACK.png", true, 144, 199);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("attack", [0, 1, 2, 3, 4, 5, 6, 7], 12, true);
		animation.add("stand", [0], 12, true);
		_hp = STARTING_HEALTH;
		attackDelay = ATTACK_DELAY;
		_entityGroup = entityGroup;
	}
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (laneContainsUndead(lane))
		{
			if (animation.name != "attack")
			{
				animation.play("attack");
			}
			_attack_frame++;
			if (_attack_frame == attackDelay)
			{
				fireArrow(lane);
				_attack_frame = 0;
			}
		}
		else
		{
			if (animation.name != "stand")
			{
				animation.play("stand");
			}
			_attack_frame = 0;
		}
		
	}
	
	private function fireArrow(lane:List<Entity>):Void
	{
		var arrow:Arrow = new Arrow(this.x + X_OFFSET, this.y + Y_OFFSET);
		_entityGroup.add(arrow);
		lane.add(arrow);
	}
	
	private function laneContainsUndead(lane:List<Entity>):Bool
	{
		for (entity in lane)
		{
			if (Std.is(entity, Undead) && entity.alive)
			{
				return true;
			}
		}
		return false;
	}
	
}