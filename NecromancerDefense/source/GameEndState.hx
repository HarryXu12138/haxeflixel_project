package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.FlxG;

class GameEndState extends FlxState {
    private var returnToMainMenuButton:FlxButton;
    private var win:Bool;

    override public function create():Void {
        super.create();
        win = false;
        initreturnToMainMenuButton();
    }

    public function updateWinLoseStatus(status:Int) {
        if (status == 0) win = false;
        else if (status == 1) win = true;
    }

    private function initreturnToMainMenuButton():Void {
        returnToMainMenuButton = new FlxButton(FlxG.width * 0.8, FlxG.height * 0.05, "Restart", restartGame);

        returnToMainMenuButton.scale.set(2.5, 3.5);
        returnToMainMenuButton.updateHitbox();
        returnToMainMenuButton.label.fieldWidth = returnToMainMenuButton.width;
        returnToMainMenuButton.label.alignment = "center";
        returnToMainMenuButton.label.size = 17;
        returnToMainMenuButton.label.offset.y -= 18;

        add(returnToMainMenuButton);
    }

    private function restartGame():Void {
        FlxG.switchState(new MainMenu());
    }

    public function initBackground():Void {
        var background:FlxSprite = new FlxSprite(0, 0);
        if (win)
		{
			background.loadGraphic("assets/images/Victory.png");
			FlxG.sound.playMusic(AssetPaths.HF_Win__ogg, 1, false);
		}
        else  
		{
			background.loadGraphic("assets/images/GameOver.png");
			FlxG.sound.playMusic(AssetPaths.HF_Lose__ogg, 1, false);
		}
        add(background);
    }
}