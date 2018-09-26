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
	
	static var SPEED:Int = 300;
	static var STARTING_HEALTH:Int = 10;
	static var ATTACK_DELAY:Int = 45;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic("assets/images/SKELETON_ALL.png", true, 280, 262);
		scale.set(0.5, 0.5);
		updateHitbox();
		width = 60;
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 12, true);
		animation.add("attack", [8, 9, 10, 11, 12, 13, 14, 15, 16], 12, true);
		animation.add("death", [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], 12, false);
		animation.play("walk");
		movementSpeed = SPEED;
		velocity.set(movementSpeed, 0);
		attackDelay = ATTACK_DELAY;
		_hp = STARTING_HEALTH;
	}
	
	
}