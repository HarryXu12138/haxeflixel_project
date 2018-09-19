package;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Jared Okun
 */
class Background extends FlxSprite 
{
	
	public function new(filePath:String) 
	{
		super(0, 0);
		loadGraphic(filePath);
	}

	
}