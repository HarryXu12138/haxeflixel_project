package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Jared Okun
 */
class Entity extends FlxSprite 
{
	
	var _fighting:Bool;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_fighting = false;
	}
	
	public function overlapInLane(other:Entity):Bool
	{
		if (other == this)
		{
			return false;
		}
		
		var entityX1:Float = this.x;
		var entityX2:Float = this.x + this.width;
		
		var otherX1:Float = other.x;
		var otherX2:Float = other.x + other.width;
		
		return entityX2 >= otherX1 && entityX1 <= otherX2;
		
	}
	
	public function act(lane:Array<Entity>):Void
	{
		
	}
	
	
}