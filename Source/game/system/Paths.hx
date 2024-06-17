package game.system;

import haxe.io.Path;
import openfl.Assets;

class Paths {
	public static var IMAGE_EXTENSIONS = [
		'png',
		'jpg', 'jpeg'
	];

	public static var AUDIO_EXTENSIONS = #if web [
		'mp3'
	] #else [
		'ogg',
		'wav'
	] #end;

	public static function file(key:String):String {
		return 'assets/$key';
	}

	public static function data(key:String):String {
		return 'assets/data/$key';
	}

	public static function image(key:String):String {
		return searchWithExtensions('assets/images/$key', IMAGE_EXTENSIONS);
	}

	public static function music(key:String):String {
		return searchWithExtensions('assets/music/$key', AUDIO_EXTENSIONS);
	}

	public static function sound(key:String):String {
		return searchWithExtensions('assets/sounds/$key', AUDIO_EXTENSIONS);
	}

	public static function searchWithExtensions(path:String, extensions:Array<String>):String {
		for (ext in extensions) {
			var pathWithExtension = Path.withExtension(path, ext);
			if (Assets.exists(pathWithExtension)) return pathWithExtension;
		}
		if (Assets.exists(path)) return path;
		return null;
	}
}