package;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
/**
 * ...
 * @author ...
 */
class Arrow extends Entity 
{
	
	static var SPEED = 150;
	static var DAMAGE = 1;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(50, 10, FlxColor.BROWN);
		velocity.set(-SPEED, 0);
	}
	
	override public function overlapInLane(other:Entity):Bool
	{
		
		return super.overlapInLane(other) && Std.is(other, Undead);
	}
	
	override public function act(lane:List<Entity>):Void
	{
		for (entity in lane)
		{
			if (overlapInLane(entity))
			{
				entity.hit(DAMAGE);
				die();
				break;
			}
		}
	}
	
}