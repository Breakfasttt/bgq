package data.ship.part;

import core.component.ComponentGroup;
import standard.components.graphic.display.Display;
import standard.components.space2d.Position2D;

/**
 * ...
 * @author Breakyt
 */
class ShipPartGroup extends ComponentGroup 
{

	public var shipParts : ShipPartComp;
	public var position2d : Position2D;
	public var display : Display;
	
	public function new() 
	{
		super();
		this.bindFieldType(ShipPartComp, "shipParts");
		this.bindFieldType(Position2D, "position2d");
		this.bindFieldType(Display, "display");
	}
	
}