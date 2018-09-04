package data;
import data.crew.CrewManager;
import data.ship.ShipPartManager;
import data.ship.TemplateManager;
import standard.factory.EntityFactory;

/**
 * ...
 * @author Breakyt
 */
class DataManager 
{

	public var crewManager(default, null) : CrewManager;
	
	public var shipParts(default, null) : ShipPartManager;
	
	public var templateManager(default, null) : TemplateManager;
	
	public function new(entityFactory : EntityFactory) 
	{
		this.crewManager = new CrewManager();
		this.templateManager = new TemplateManager("datas/shipTemplates.json");
		this.shipParts = new ShipPartManager(entityFactory);
	}
	
}