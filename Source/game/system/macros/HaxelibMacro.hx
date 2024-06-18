package game.system.macros;

class HaxelibMacro {
	public static macro function buildList():haxe.macro.Expr.ExprOf<Array<String>> {
		var result:Array<String> = [];
	
		var project = new haxe.xml.Access(Xml.parse(sys.io.File.getContent('project.xml')).firstElement());

		for (haxelib in project.nodes.haxelib) {
			var name = haxelib.att.name;
			var version = haxelib.has.version ? haxelib.att.version : getHaxelibVersion(name);

			result.push('$name - $version');
		}

		return macro $v{result};
	}

	#if macro
	static function getHaxelibVersion(name:String):String {
		var path = getHaxelibPath(name);

		var devPath = haxe.io.Path.join([path, '.dev']);
		if (sys.FileSystem.exists(devPath)) return 'dev(${sys.io.File.getContent(devPath)})';

		var currentPath = haxe.io.Path.join([path, '.current']);
		if (!sys.FileSystem.exists(currentPath)) return 'N/A';

		var currentContent = sys.io.File.getContent(currentPath);
		if (currentContent != 'git') return currentContent;

		return getHaxelibGit(path);
	}

	static function getHaxelibPath(name:String):String {
		var process = new sys.io.Process('haxelib', ['libpath', name]);
		var output = process.stdout.readAll().toString();
		
		var path = haxe.io.Path.join([output, '../../']);
		return path;
	}

	static function getHaxelibGit(path:String):String {
		var cwd = Sys.getCwd();
		Sys.setCwd(path);

		var process = new sys.io.Process('git', ['config', '--get', 'remote.origin.url']);
		var url = process.stdout.readAll().toString();

		// TODO: dir, ref

		Sys.setCwd(cwd);
		
		return url;
	}
	#end
}