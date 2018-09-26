package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Jared Okun
 */
class MainKnight extends FlxSprite 
{
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/BOSS.png", true, 198, 267);
		animation.add("idle", [0, 1, 2, 3], 6, true);
		animation.play("idle");
	}
	
}