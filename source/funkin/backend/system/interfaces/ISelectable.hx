package funkin.backend.system.interfaces;

import flixel.FlxCamera;
import flixel.math.FlxPoint;

/** An object that can be hovered and clicked by FunkinCursor. */
interface ISelectable
{
	public function isSelectable():Bool;
	public function overlapsMouse(mousePosition:FlxPoint, camera:FlxCamera):Bool;
	public function onHover():Void;
	public function onHoverExit():Void;
	public function onClick():Void;
	public function get_unavailable():Bool;
	public function getObject():Dynamic;
}
