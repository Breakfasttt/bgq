package data.ship;
import core.Application;
import core.entity.Entity;
import data.ship.part.ShipPartComp;
import data.ship.types.ShipPartType;
import standard.components.misc.ParentEntity;
import standard.factory.EntityFactory;
import tools.file.csv.CsvData;
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
	
	private var m_shipPartFileDatas : CsvData;
	
	public function new(entityFactoryRef : EntityFactory, shipPartData : CsvData) 
	{
		m_ShipPartEntities = new Array();
		m_factory = entityFactoryRef;
		m_shipPartFileDatas = shipPartData;
		
		
		prepareShipPart();
		prepareEntity();
	}
	
	private function prepareShipPart()  : Void
	{
		m_shipPartsDatas = [];
		
		if (m_shipPartFileDatas == null)
			return;
			
		var shipPartRaw : Map<String,String> = null;
		var modelId : String;
		var nameKey : String = null;
		var descKey : String = null;
		var type : ShipPartType = null;
		var baseResourceGeneration : Int = -1;
		var baseResourceConsumption : Int = -1;
		
		for (shipPartId in m_shipPartFileDatas.getRawIds())
		{
			shipPartRaw = m_shipPartFileDatas.getRaw(shipPartId);
			if (shipPartRaw == null)
				continue;
				
			modelId = shipPartRaw.get("modelId");
			nameKey = shipPartRaw.get("nameLocaleKey");
			descKey = shipPartRaw.get("descLocaleKey");
			baseResourceGeneration = Std.parseInt(shipPartRaw.get("baseResourceGeneration"));
			baseResourceConsumption = Std.parseInt(shipPartRaw.get("baseResourceConsumption"));
			
			try
			{	
				type = ShipPartType.createByName(shipPartRaw.get("type"));
			}
			catch (e : Dynamic)
			{
				type = null;
			}
			
			if (nameKey == null || descKey == null || baseResourceGeneration == -1 || baseResourceConsumption == -1 || type == null)
			{
				trace("Error while prepare part ship : " + shipPartId + ". Please check the csv description file");
				continue;
			}
			
			
			m_shipPartsDatas.push(new ShipPartComp(shipPartId, modelId, nameKey, descKey, type, baseResourceGeneration, baseResourceConsumption));
		}
	}
	
	private function prepareEntity() : Void
	{
		var data : ShipPartComp = null;
		for (i in 0...m_shipPartsDatas.length)
		{
			data = m_shipPartsDatas[i];
			
			var entity : Entity = m_factory.createGameElement(data.id, null, data.modelId, 0, Anchor.topLeft, Anchor.topLeft);
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
	
	public function getShipPartNumb() : Int
	{
		return m_ShipPartEntities.length;
	}
	
}