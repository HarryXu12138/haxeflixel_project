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
	var _hp:Int;
	var _attack_frame:Int;
	var attackDelay:Int;
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_fighting = false;
		_hp = 0;
		_attack_frame = 0;
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
	
	public function act(lane:List<Entity>):Void
	{
		if (_hp <= 0)
		{
			die();
		}
	}
	
	public function fight(targets:List<Entity>, damage:Int):Void
	{
		_attack_frame++;
		if (_attack_frame == attackDelay)
		{
			_attack_frame = 0;
			for (target in targets)
			{
				target.hit(damage);
			}
			
			
				
		}
		
	}
	
	
	public function hit(damage:Int)
	{
		_hp -= damage;
	}
	
	public function die():Void
	{
		
		kill();
		alive = false;
	}
	
	
	
	
}