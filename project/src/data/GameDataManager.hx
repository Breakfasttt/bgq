package data;
import assets.audio.AudioLibrary;
import data.audio.AudioSavedValues;
import data.crew.CrewManager;
import data.ship.ShipPartManager;
import data.ship.TemplateManager;
import openfl.Assets;
import standard.factory.EntityFactory;
import tools.file.csv.CsvManager;

/**
 * ...
 * @author Breakyt
 */
class GameDataManager 
{

	public var crewManager(default, null) : CrewManager;
	
	public var shipParts(default, null) : ShipPartManager;
	
	public var templateManager(default, null) : TemplateManager;
	
	public var audiosValue : AudioSavedValues;
	
	public function new(entityFactory : EntityFactory, csvManager : CsvManager) 
	{
		this.audiosValue = new AudioSavedValues();
		this.crewManager = new CrewManager();
		this.templateManager = new TemplateManager("datas/ship/shipTemplates.json");
		this.shipParts = new ShipPartManager(entityFactory, csvManager.getCsv("shipPartData"));
	}
	
	
	
}