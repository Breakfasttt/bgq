package data.ship;
import core.Application;
import core.entity.Entity;
import data.ship.part.ShipPartComp;
import data.ship.types.ShipPartType;
import standard.components.misc.ParentEntity;
import standard.factory.EntityFactory;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ShipPartManager 
{

	private var m_factory : EntityFactory;
	
	private var m_ShipPartEntities : Array<Entity>;
	
	private var m_shipPartsDatas : Array<ShipPartComp>;
	
	public function new(entityFactoryRef : EntityFactory) 
	{
		m_ShipPartEntities = new Array();
		m_factory = entityFactoryRef;
		
		prepareShipPart();
		prepareEntity();
	}
	
	//todo dégager le hardcode
	private function prepareShipPart()  : Void
	{
		m_shipPartsDatas = [];
		
		m_shipPartsDatas.push(new ShipPartComp("shipPart0", "générateur", "fournit l'énergie au vaisseau", ShipPartType.primary, 10 , 0));
		m_shipPartsDatas.push(new ShipPartComp("shipPart1", "Centre de navigation", "to do", ShipPartType.primary, 0 , 2));
		m_shipPartsDatas.push(new ShipPartComp("shipPart2", "Salle des moteurs", "to do", ShipPartType.primary, 0 , 2));
		m_shipPartsDatas.push(new ShipPartComp("shipPart3", "Système de survie", "to do", ShipPartType.primary, 1 , 5));
		m_shipPartsDatas.push(new ShipPartComp("shipPart4", "Générateur de bouclier", "to do", ShipPartType.secondary, 0 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart5", "Générateur de gravité", "to do", ShipPartType.secondary, 0 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart6", "centre de défense", "to do", ShipPartType.secondary, 0 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart7", "centre médical", "to do", ShipPartType.secondary, 0 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart8", "Soute", "to do", ShipPartType.secondary, 3 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart9", "hangar", "to do", ShipPartType.secondary, 0 , 1));
		m_shipPartsDatas.push(new ShipPartComp("shipPart10", "centre de repos","to do", ShipPartType.secondary, 0 , 1));
	}
	
	private function prepareEntity() : Void
	{
		var data : ShipPartComp = null;
		for (i in 0...11)
		{
			data = m_shipPartsDatas[i];
			
			var entity : Entity = m_factory.createGameElement(data.id, null, "tempModule", 0, Anchor.topLeft, Anchor.topLeft);
			entity.add(data);
			m_ShipPartEntities.push(entity);
		}
	}
	
	public function addShipPartToApp(app : Application) : Void
	{
		if (app == null)
			return;
		
			
		for (ent in m_ShipPartEntities)
			app.addEntity(ent);
	}
	
	public function removeShipPartToApp(app : Application) : Void
	{
		if (app == null)
			return;
		
		for (ent in m_ShipPartEntities)
			app.removeEntity(ent);
	}
	
	public function setShipPartParentEntity(entParent : Entity) : Void
	{
		var parentComp : ParentEntity = null;
		for (ent in m_ShipPartEntities)
		{
			parentComp = ent.getComponent(ParentEntity);
			
			if (parentComp == null)
				ent.add(new ParentEntity(entParent));
			else
				parentComp.setParent(entParent);
		}
	}
	
}