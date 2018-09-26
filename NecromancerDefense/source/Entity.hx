package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Entity extends FlxSprite 
{
	
	var _fighting:Bool;
	var _hp:Int;
	var _attack_frame:Int;
	var _attackDelay:Int;
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_fighting = false;
		_hp = 0;
		_attack_frame = 0;
	}
	
	public function overlapInLane(other:Entity):Bool
	{
		//Overlap only occurs if both entities are touching x-wise
		if (other == this)
		{
			return false;
		}
		
		var entityX1:Float = this.x;
		var entityX2:Float = this.x + this.width;
		
		var otherX1:Float = other.x;
		var otherX2:Float = other.x + other.width;
		
		return entityX2 >= otherX1 && entityX1 <= otherX2 && other.alive;
	}
	
	public function act(lane:List<Entity>):Void
	{
		//Entities can only interact with their own lane
		if (_hp <= 0)
		{
			die();
		}
		if (!alive && animation.frameIndex == animation.frames - 1)
		{
			//Remove entity if it is done with its dying animation
			kill();
		}
	}
	
	public function fight(targets:List<Entity>, damage:Int):Void
	{
		//checks to see if the windup for the attack is done, then deals damage to all targets
		_attack_frame++;
		if (_attack_frame == _attackDelay)
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
		//Play death only if agent has an animation
		alive = false;
		velocity.set(0, 0);
		if (animation.getByName("death") != null)
		{
			animation.play("death");
		}
		else
		{
			kill();
		}
		
		
	}
	
	
	
	
}