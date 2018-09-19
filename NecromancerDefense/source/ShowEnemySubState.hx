package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import GlobalValues;

class ShowEnemySubState extends FlxState {
    /*
    0 -- nothing
    1 -- human type 1
    2 -- human type 2
    */
    public static var enemyBoard:Array<Array<Int>>;

    override public function create():Void {
        super.create();
        initBoardArea();
    }

    private function initBoardArea():Void {}
}