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

class TutorialWindow extends FlxTypedGroup<FlxSprite>
{
    var _headerText : FlxText;
    var _bodyText : FlxText;
    var _picture : FlxSprite;

	var _closeButton : FlxButton;

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
        initPicture();
		initCloseButton();
		hide();
	}

	public function hide():Void
	{
		_blackFilter.kill();
		_panel.kill();
        _headerText.kill();
        _bodyText.kill();
        _picture.kill();
        _closeButton.kill();
	}

    public function show(currentTime:Float):Void
	{        
		_blackFilter.revive();
		_panel.revive();
        _headerText.revive();
        _bodyText.revive();
        _picture.revive();
        _closeButton.revive();

        _savedTime = currentTime;
        FlxG.timeScale = 0;
	}
	
    function initDisplayText():Void
	{
        _headerText = new FlxText(FlxG.width * 0.3, FlxG.height * 0.23, 600); // x, y, width
		_headerText.setFormat(18, FlxColor.WHITE, CENTER);
		_headerText.text = "- How To Play -";
		add(_headerText);

		_bodyText = new FlxText(FlxG.width * 0.3, FlxG.height * 0.3, 600); // x, y, width
		_bodyText.setFormat(14, FlxColor.WHITE, LEFT);
		_bodyText.text = "Strategically raise and command your monsters to attack enemy troops. Select a monster and place it the on the board. When you're ready to attack, click \"start round\". To win, you must capture at least 3 out of the 5 lanes. To capture a lane, must defeat all the enemies in a lane.";
		add(_bodyText);
	}

    function initPicture():Void{
        _picture = new FlxSprite(FlxG.width * 0.11, FlxG.height * 0.27);
		_picture.loadGraphic("assets/images/tutorial1.png");
        _picture.scale.set(0.47,0.47);
		add(_picture);
    }

	function initCloseButton():Void
	{
		_closeButton = new FlxButton(0, 0, "OK", closeWindow);
		//_closeButton.loadGraphic("assets/images/custom.png");

		_closeButton.scale.set(1,2.2);
		_closeButton.updateHitbox();
		
		_closeButton.label.fieldWidth = _closeButton.width;
        _closeButton.label.alignment = "center";

		_closeButton.label.size = 15;
		_closeButton.label.offset.y -= 8;

		_closeButton.x = FlxG.width * 0.7;
		_closeButton.y = FlxG.height * 0.78;

		add(_closeButton);
	}

	function initPanel():Void
	{
		_panel = new FlxSprite();
		_panel.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_panel);

        FlxSpriteUtil.drawRoundRect(_panel, FlxG.width * 0.25, FlxG.height * 0.17, FlxG.width * 0.55, FlxG.height * 0.7, 10, 10, FlxColor.fromRGB(61, 57, 66, 256));		
    }

	function initBlackFilter():Void
	{
		_blackFilter = new FlxSprite();
		_blackFilter.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(_blackFilter);		

		FlxSpriteUtil.drawRoundRect(_blackFilter, 0, 0, FlxG.width, FlxG.height, 10, 10, FlxColor.fromRGB(24, 26, 30, 200));
	}

	function closeWindow():Void
	{
		hide();
        FlxG.timeScale = _savedTime;
	}
}
