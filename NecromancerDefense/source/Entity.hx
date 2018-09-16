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
	var _target:Entity;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_fighting = false;
		_hp = 0;
		
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
		
		if (entityX2 >= otherX1 && entityX1 <= otherX2)
		{
			_fighting = true;
			_target = other;
			other._fighting = true;
			other._target = this;
			_attack_frame = 0;
			other._attack_frame = 0;
		}
		
	}
	
	public function act(lane:List<Entity>):Void
	{
		if (_hp == 0)
		{
			die();
		}
	}
	
	public function hit()
	{
		_hp--;
	}
	
	public function die():Void
	{
		kill();
	}
	
	
	
	
}