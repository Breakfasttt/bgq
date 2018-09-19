package module.ship;

import core.module.Module;
import data.ship.ShipTemplate;
import data.ship.part.ShipPartComp;
import data.ship.part.ShipPartGroup;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class ShipTemplateModule extends Module<ShipPartGroup>
{

	
	
	public var currentShipTemplate(default,null) : ShipTemplate;
	
	public function new() 
	{
		super(ShipPartGroup);	
	}
	
	override function onCompGroupAdded(group:ShipPartGroup):Void 
	{
		
	}
	
	override function onCompGroupRemove(group:ShipPartGroup):Void 
	{
		
	}
	
	override public function update(delta:Float):Void 
	{
		//super.update(delta);
	}
	
	public function setShipTemplate(newTemplate : ShipTemplate) : Void
	{
		this.currentShipTemplate = newTemplate;
		relocate();
	}
	
	private function relocate() : Void
	{
		var positionId : Vector2D = null;
		var x : Float = 0;
		var y : Float = 0;
		
		if (this.currentShipTemplate == null)
		{
			for (group in this.m_compGroups)
				group.display.skin.visible = false;
		}
		else
		{
			for (group in this.m_compGroups)
			{
				positionId = this.currentShipTemplate.getPosition(group.shipParts.id);
				
				x = positionId.x * ShipPartComp.shipPartSizeX;
				y = positionId.y * ShipPartComp.shipPartSizeY;
				group.position2d.position2d.ratioMode = false;
				group.position2d.position2d.setValue(x, y);
			}
		}
	}
	
}