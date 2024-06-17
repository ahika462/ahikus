package game.system;

import haxe.CallStack;
import flixel.FlxG;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;

class CrashHandler {
	public static function init() {
		#if hl
		hl.Api.setErrorHandler(onHlError);
		#elseif cpp
		untyped __global__.__hxcpp_set_critical_error_handler(onCppError);
		#else
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
		#end
	}

	#if hl
	static function onHlError(v:Dynamic) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);
		FlxG.stage.window.alert('$v\n\n$stackString', 'Uncaught error');
	}
	#elseif cpp
	static function onCppError(msg:String) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);
		FlxG.stage.window.alert('$msg\n\n$stackString', 'Uncaught error');
	}
	#else
	static function onUncaughtError(e:UncaughtErrorEvent) {
		var stack = CallStack.exceptionStack(true);
		var stackString = CallStack.toString(stack);
		FlxG.stage.window.alert('${e.error}\n\n$stackString', 'Uncaught error');
	}
	#end
}