package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Jared Okun
 */
class Tile extends FlxSprite 
{
	var _occupiedEntity:Entity;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic("assets/images/sampleTile.png");
	}
	
	public function setOccupiedEntity(entity:Entity):Void
	{
		_occupiedEntity = entity;
	}
	
}