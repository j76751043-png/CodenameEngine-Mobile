package funkin.backend;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import funkin.backend.system.SelectableManager;
import funkin.backend.system.interfaces.ISelectable;

class FunkinCursor extends FlxSpriteGroup
{
	private var cursor:FlxSprite;

	public var hovered:ISelectable = null;
	public var disable:Bool = false;

	public function new(type:Int = 0)
	{
		super();

		FlxG.mouse.visible = false;

		var typeCursor = "Cursor";

		switch (type)
		{
			case 0:
				typeCursor = 'Cursor';
			default:
				typeCursor = 'Cursor';
		}

		cursor = new FlxSprite();
		cursor.frames = Paths.getSparrowAtlas("cursor/" + typeCursor);

		cursor.animation.addByPrefix("idle", "idle", 20, true);
		cursor.animation.addByPrefix("select", "select", 20, true);
		// Liru's atlas has idle/select only, so unavailable reuses select.
		cursor.animation.addByPrefix("not_available", "select", 20, true);

		cursor.animation.play("idle");
		cursor.scale.set(1.2, 1.2);
		cursor.updateHitbox();
		cursor.antialiasing = false;

		add(cursor);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		cursor.visible = !disable;
		if (disable)
			return;

		var cam = (camera != null) ? camera : FlxG.camera;
		var mousePos:FlxPoint = FlxG.mouse.getWorldPosition(cam);

		cursor.setPosition(mousePos.x, mousePos.y);

		var current:ISelectable = null;

		for (obj in SelectableManager.getActive())
		{
			if (!obj.isSelectable())
				continue;

			if (obj.overlapsMouse(mousePos, cam))
			{
				current = obj;
				break;
			}
		}

		if (current != hovered)
		{
			var previous = hovered;
			hovered = current;

			if (previous != null)
				previous.onHoverExit();

			if (hovered != null)
				hovered.onHover();
		}

		if (hovered != null && FlxG.mouse.justPressed && !disable)
		{
			hovered.onClick();
		}

		cursor.animation.play(hovered == null ? "idle" : (!hovered.get_unavailable() ? "select" : "not_available"));
	}
}
