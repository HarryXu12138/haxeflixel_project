package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;


class Human extends Entity 
{
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	override public function overlapInLane(other:Entity):Bool
	{
		//Humans can only overlap with enemies
		return super.overlapInLane(other) && Std.is(other, Undead);
	}
	
	
	
}