package game.input;

class ControlsMacro {
	public static macro function build():Array<haxe.macro.Expr.Field> {
		var fields = haxe.macro.Context.getBuildFields();

		var pos = haxe.macro.Context.currentPos();

		var controls = haxe.macro.Context.getType('game.input.Controls.Control');
		var bool = haxe.macro.Context.getType('Bool');

		switch(controls) {
			case TEnum(t, params):
				for (construct in t.get().constructs.keys()) {
					fields.push({
						name: construct,
						access: [APublic],
						pos: pos,
						kind: FProp('get', 'never', haxe.macro.Context.toComplexType(bool))
					});
					fields.push({
						name: 'get_$construct',
						pos: pos,
						kind: FFun({
							args: [],
							ret: haxe.macro.Context.toComplexType(bool),
							expr: macro {
								return try check(game.input.Controls.Control.createByName($v{construct})) catch(_) false;
							}
						})
					});
				}

			default:
		}

		return fields;
	}
}