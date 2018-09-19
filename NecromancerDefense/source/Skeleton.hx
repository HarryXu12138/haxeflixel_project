package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
/**
 * ...
 * @author Jared Okun
 */
class Skeleton extends Zombie 
{
	
	static var SPEED:Int = 250;
	static var STARTING_HEALTH:Int = 2;
	static var ATTACK_DELAY:Int = 12;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(48, 96, FlxColor.WHITE);
		movementSpeed = SPEED;
		velocity.set(movementSpeed, 0);
		attackDelay = ATTACK_DELAY;
		_hp = STARTING_HEALTH;
	}
	
	
}