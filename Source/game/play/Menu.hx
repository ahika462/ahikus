package game.play;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import game.system.Paths;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;

class Menu extends State{
    override function create(){
        var bg:FlxSprite;
        var logo:FlxSprite;
        var cat:FlxSprite;
        var text:FlxText;
        bg = new FlxSprite(Paths.image('bgmenu'));
        bg.screenCenter();
        add(bg);
        logo = new FlxSprite(Paths.image('logo'));
        logo.setGraphicSize(logo.width * 1.8, logo.height * 1.4);
        logo.screenCenter(X);
        logo.y = 150;
        add(logo);
        cat = new FlxSprite(Paths.image('catcreep'));
        cat.setGraphicSize(cat.width * 1.4, cat.height * 1.4);
        cat.screenCenter(X);
        cat.y = 700;
        add(cat);
        FlxTween.tween(cat, {y: 300}, 1.5, {ease: FlxEase.cubeOut});
        var text:FlxText = new FlxText(0, 650, 0, "Press Enter to Play!", 6);
        text.screenCenter(X);
        text.x - 100;
		text.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(text);
    }

    override function update(elasped){
        if (FlxG.keys.justPressed.ENTER) {
            FlxG.switchState(new PlayState());
        }
    }
    
}