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
class DataManager 
{

	public var csvManager(default, null) : CsvManager;
	
	public var crewManager(default, null) : CrewManager;
	
	public var shipParts(default, null) : ShipPartManager;
	
	public var templateManager(default, null) : TemplateManager;
	
	public var audios : AudioLibrary;
	
	public var audiosValue : AudioSavedValues;
	
	public function new(entityFactory : EntityFactory) 
	{
		this.csvManager = new CsvManager();
		parseCsv();
		
		this.audiosValue = new AudioSavedValues();
		this.audios = new AudioLibrary();
		this.audios.loadFromCsv(this.csvManager.getCsv("audio"));
		
		this.crewManager = new CrewManager();
		this.templateManager = new TemplateManager("datas/ship/shipTemplates.json");
		this.shipParts = new ShipPartManager(entityFactory, this.csvManager.getCsv("shipPartData"));
	}
	
	private function parseCsv() : Void
	{
		//locale
		this.csvManager.parseAndRegisterCsv("localeMenu", Assets.getText("datas/localization/menu.csv"));
		this.csvManager.parseAndRegisterCsv("localeShipPart", Assets.getText("datas/localization/shipPart.csv"));
		
		//ship data
		this.csvManager.parseAndRegisterCsv("shipPartData", Assets.getText("datas/ship/shipPartDef.csv"));
		
		//sound
		this.csvManager.parseAndRegisterCsv("audio", Assets.getText("datas/audio/audios.csv"));
	}
	
}