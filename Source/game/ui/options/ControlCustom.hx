package game.ui.options;

import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import game.input.Controls;
import flixel.group.FlxSpriteGroup;

class ControlCustom extends FlxSpriteGroup {
	var bg:FlxSprite;

	var title:FlxText;
	var keyboardBinding:FlxText;
	var gamepadBinding:FlxText;

	var controls:Controls;
	var control:Control;

	public function new(x = 0.0, y = 0.0, control:Control) {
		super(x, y);
		this.control = control;
		controls = new Controls();

		bg = new FlxSprite().makeGraphic(500, 40, 0x77FFFFFF);
		add(bg);

		title = new FlxText(0, 4, control.getName().charAt(0) + control.getName().substr(1).toLowerCase());
		title.size = 32;
		add(title);

		keyboardBinding = new FlxText(0, 4, formatKeyboardBinding(controls.keyboardBindings.get(control)));
		keyboardBinding.x = 300;
		keyboardBinding.size = 32;
		add(keyboardBinding);
	}

	override function update(elapsed:Float) {
		if (FlxG.mouse.overlaps(bg)) {
			bg.color = 0xFFFFFFFF;
			if (FlxG.mouse.justReleased) waitForInput();
		}
		else bg.color = 0xFF000000;
		
		super.update(elapsed);
	}

	function waitForInput() {
		keyboardBinding.text = '> <';
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onInput);
	}
	
	function onInput(e:KeyboardEvent) {
		var formatted = formatKeyboardBinding(e.keyCode);
		if (formatted == null) return;

		Preferences.keyboardBindings[control] = e.keyCode;

		keyboardBinding.text = formatted;
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onInput);
	}

	public static function formatKeyboardBinding(key:FlxKey):String {
		return switch(key) {
			case ZERO: '0';
			case ONE: '1';
			case TWO: '2';
			case THREE: '3';
			case FOUR: '4';
			case FIVE: '5';
			case SIX: '6';
			case SEVEN: '7';
			case EIGHT: '8';
			case NINE: '9';
			case MINUS: '-';
			case PLUS: '+';
			case LBRACKET: '[';
			case RBRACKET: ']';
			case SEMICOLON: ';';
			case QUOTE: '\'';
			case COMMA: ',';
			case PERIOD: '.';
			case SLASH: '/';
			case CONTROL: 'CTRL';
			case A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z: key.toString();
			case ENTER | SHIFT | ALT | SPACE | ESCAPE | UP | DOWN | LEFT | RIGHT | TAB: key.toString();
			case F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 | F10 | F11 | F12: key.toString();
			default: null;
		}
	}
}