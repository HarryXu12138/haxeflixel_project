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
	
	static var SPEED:Int = 80;
	static var STARTING_HEALTH:Int = 3;
	static var ATTACK_SPEED:Int = 2;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.GREEN);
		velocity.set(SPEED, 0);
	}
	
	override public function act(lane:Array<Entity>):Void
	{
		var colliding:Bool = false;
		for (entity in lane)
		{
			if (overlapInLane(entity))
			{
				colliding = true;
				break;
			}
		}
		if (colliding)
		{
			velocity.set(0, 0);
		}
		else
		{
			velocity.set(SPEED, 0);
		}
	}
	
}