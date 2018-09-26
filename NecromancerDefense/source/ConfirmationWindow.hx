package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flash.system.System;

/*
	This class draws our confirmation window (pop-ups when player still has unspent MP.)
*/
class ConfirmationWindow extends FlxTypedGroup<FlxSprite>
{
    var _levelData : LevelData;

    var _displayText : FlxText;
	var _manaIcon : FlxSprite;

	var _yesButton : FlxButton;
	var _noButton : FlxButton;

	var _panel : FlxSprite;
	var _blackFilter : FlxSprite;

	var _savedTime : Float;

	public function new():Void
	{
		super();
        initWindow();
	}

	function initWindow(): Void
	{
		initBlackFilter();
		initPanel();
        initDisplayText();
		initYesButton();
		initNoButton();
		hide();
	}

	public function hide():Void
	{
		_blackFilter.kill();
		_panel.kill();
        _displayText.kill();
		_manaIcon.kill();
        _yesButton.kill();
        _noButton.kill();
	}

    public function show(currentTime:Float, manaCurrent:Float, levelData:LevelData):Void
	{
        _levelData = levelData;
        
        if(manaCurrent == 0){
            yesAction();
            return;
        }

		_blackFilter.revive();
		_panel.revive();
        _displayText.revive();
		_manaIcon.revive();
        _yesButton.revive();
        _noButton.revive();

        _savedTime = currentTime;
        FlxG.timeScale = 0;
	}
	
    function initDisplayText():Void
	{
		_displayText = new FlxText(FlxG.width * 0.4, FlxG.height * 0.4, 300); // x, y, width
		_displayText.setFormat(20, FlxColor.WHITE, CENTER);
		_displayText.text = "You still have unspent   , are you sure you want to continue?";
		add(_displayText);

		_manaIcon = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.4);
		_manaIcon.loadGraphic("assets/images/Mana.png");
        _manaIcon.scale.set(0.35,0.35);
		add(_manaIcon);
	}

	function initYesButton():Void
	{
		_yesButton = new FlxButton(0, 0, "Yes", yesAction);

		_yesButton.scale.set(1.25,3);
		_yesButton.updateHitbox();
		
		_yesButton.label.fieldWidth = _yesButton.width;
        _yesButton.label.alignment = "center";

		_yesButton.label.size = 24;
		_yesButton.label.offset.y -= 8;

		_yesButton.x = FlxG.width * 0.41;
		_yesButton.y = FlxG.height * 0.6;

		add(_yesButton);
	}

	function initNoButton():Void
	{
		_noButton = new FlxButton(0, 0, "No", noAction);

		_noButton.scale.set(1.25,3);
		_noButton.updateHitbox();
		
		_noButton.label.fieldWidth = _noButton.width;
        _noButton.label.alignment = "center";

		_noButton.label.size = 24;
		_noButton.label.offset.y -= 8;

		_noButton.x = FlxG.width * 0.55;
		_noButton.y = FlxG.height * 0.6;

		add(_noButton);
	}

	function initPanel():Void
	{
		_panel = new FlxSprite();
		_panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_panel);		

		FlxSpriteUtil.drawRoundRect(_panel, FlxG.width * 0.37, FlxG.height * 0.34, FlxG.width * 0.3, FlxG.height * 0.4, 10, 10, FlxColor.fromRGB(61, 57, 66, 256));
	}
	
	// Giant overlay that darkens the rest of the scene
	function initBlackFilter():Void
	{
		_blackFilter = new FlxSprite();
		_blackFilter.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_blackFilter);		

		FlxSpriteUtil.drawRoundRect(_blackFilter, 0, 0, FlxG.width, FlxG.height, 10, 10, FlxColor.fromRGB(24, 26, 30, 130));
	}

	function yesAction():Void
	{
        FlxG.timeScale = 1;
		FlxG.switchState(new SimulationState(_levelData));
	}

	function noAction():Void
	{
		hide();
        FlxG.timeScale = _savedTime;
	}
}
