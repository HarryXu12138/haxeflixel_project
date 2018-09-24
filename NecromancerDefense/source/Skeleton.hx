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
	static var STARTING_HEALTH:Int = 10;
	static var ATTACK_DELAY:Int = 12;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic("assets/images/SKELETON_WALK.png", true, 205, 126);
		scale.set(0.5, 0.5);
		updateHitbox();
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 12, true);
		animation.play("walk");
		movementSpeed = SPEED;
		velocity.set(movementSpeed, 0);
		attackDelay = ATTACK_DELAY;
		_hp = STARTING_HEALTH;
	}
	
	
}