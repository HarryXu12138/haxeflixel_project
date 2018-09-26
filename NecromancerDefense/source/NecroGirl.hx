package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Jared Okun
 */
class NecroGirl extends FlxSprite 
{
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/NECROMANCER.png", true, 255, 320);
		animation.add("idle", [0, 1, 2, 3, 4, 5], 6, true);
		animation.play("idle");
	}
	
}