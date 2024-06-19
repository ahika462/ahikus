package game.ui;

import openfl.display.Bitmap;
import game.graphics.ImageOutline;
import openfl.text.TextFormatAlign;
import haxe.Timer;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.Sprite;

class FPSCounter extends Sprite {
	var tf:TextField;
	var times:Array<Float> = [];

	var outline:Bitmap;
	var doOutline:()->Bitmap;

	public function new(x = 10.0, y = 10.0, color = 0xFF000000) {
		super();
		this.x = x;
		this.y = y;

		tf = new TextField();
		tf.defaultTextFormat = new TextFormat('_sans', 16, color, TextFormatAlign.RIGHT);
		tf.embedFonts = true;
		tf.mouseEnabled = false;
		addChild(tf);

		doOutline = () -> ImageOutline.renderImage(this, 2, 0xFF000000);

		outline = doOutline();
		addChild(outline);
		tf.visible = false;
	}

	override function __enterFrame(deltaTime:Int) {
		super.__enterFrame(deltaTime);

		var time = Timer.stamp();
		times.push(time);
		
		while (times[0] < time - 1)
			times.shift();

		tf.text = '${times.length}';

		tf.visible = true;
		removeChild(outline);
		outline = doOutline();
		addChild(outline);
		tf.visible = false;
	}
}