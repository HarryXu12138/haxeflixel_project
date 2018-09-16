package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jared Okun
 */
class Human extends Entity 
{
	
	static var STARTING_HEALTH:Int = 3;
	static var ATTACK_DELAY:Int = 6;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.BLUE);
		_hp = STARTING_HEALTH;
	}
	
	
	override public function act(lane:List<Entity>):Void
	{
		super.act(lane);
		if (alive)
		{
			if (_fighting)
			{
				
			}
		}
	}
	
}