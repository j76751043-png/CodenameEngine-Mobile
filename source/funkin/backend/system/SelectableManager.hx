package funkin.backend.system;

import funkin.backend.system.interfaces.ISelectable;

/** Keeps selectable objects separated by menu/substate layers. */
class SelectableManager
{
	private static var layers:Array<Array<ISelectable>> = [[]];

	public static function pushLayer():Void
	{
		layers.push([]);
	}

	public static function popLayer():Void
	{
		if (layers.length > 1)
			layers.pop();
		else
			layers[0].resize(0);
	}

	public static function add(selectable:ISelectable):Void
	{
		var layer = layers[layers.length - 1];
		if (!layer.contains(selectable))
			layer.push(selectable);
	}

	public static function remove(selectable:ISelectable):Void
	{
		for (layer in layers)
			layer.remove(selectable);
	}

	public static function getActive():Array<ISelectable>
	{
		return layers[layers.length - 1];
	}
}
