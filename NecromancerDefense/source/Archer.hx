package;

import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Archer extends Human 
{

	static var STARTING_HEALTH:Int = 5;
	static var ATTACK_DELAY:Int = 42;
	static var X_OFFSET:Int = -10;
	static var Y_OFFSET:Int = 70;
	
	
	var _entityGroup:FlxGroup;
	
	
	public function new(?X:Float=0, ?Y:Float=0, entityGroup:FlxGroup) 
	{
		super(X, Y);
		loadGraphic("assets/images/ARCHER_ALL.png", true, 215, 255);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("attack", [12, 13, 14, 7, 8, 9, 10, 11], 12, true);
		animation.add("stand", [0, 1, 2, 3, 4, 5, 6], 12, true);
		animation.add("death", [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], 12, false);
		_hp = STARTING_HEALTH;
		attackDelay = ATTACK_DELAY;
		_entityGroup = entityGroup;
	}
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (laneContainsUndead(lane) && alive)
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
		else if (alive)
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