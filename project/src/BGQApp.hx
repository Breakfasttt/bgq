package src;
import assets.model.library.ModelFactory;
import assets.model.library.ModelLibrary;
import core.Application;
import core.entity.Entity;
import data.DataManager;
import data.randomizer.CrewMemberPicker;
import data.randomizer.NamePicker;
import data.randomizer.NameRandomizer;
import game.ship.ShipModule;
import misc.name.LayerName;
import misc.name.ScreenName;
import openfl.Assets;
import openfl.Lib;
import screen.ScreenFactory;
import src.misc.name.FontName;
import standard.components.debug.impl.ShowFps;
import standard.components.debug.impl.ShowMousePosition;
import standard.components.graphic.display.impl.Layer;
import standard.components.space2d.UtilitySize2D;
import standard.components.space2d.resizer.Resizer;
import standard.components.space2d.resizer.impl.RatioResizer;
import standard.factory.EntityFactory;
import standard.module.debug.DebugModule;
import standard.module.graphic.AnimRenderModule;
import standard.module.graphic.GameElementModule;
import standard.module.graphic.LayerModule;
import standard.module.graphic.LocationModule;
import standard.module.graphic.PopUpModule;
import standard.module.graphic.ScreenModule;
import standard.module.input.PointerBehavioursModule;
import standard.module.localization.LocalizationModule;
import tools.file.csv.CsvManager;
import tools.file.csv.CsvParser;
import tools.math.Anchor;
import tools.time.FrameTicker;

/**
 * ...
 * @author Breakyt
 */
class BGQApp 
{

	
	public static var self : BGQApp;
	
	//base
	public var app(default, null) : Application;
	
	public var modelLibrary(default, null) : ModelLibrary;
	
	public var entityFactory(default, null) : EntityFactory;
	
	
	
	
	//module
	
	public var layerModule(default, null) : LayerModule;
	
	public var screenModule(default, null) : ScreenModule;
	
	public var popupModule(default, null) : PopUpModule;
	
	public var geModule(default, null) : GameElementModule;
	
	public var animRenderModule(default, null) : AnimRenderModule;
	
	public var locationModule(default, null) : LocationModule;
	
	public var pointerModule(default, null) : PointerBehavioursModule;
	
	public var shipModule(default, null) : ShipModule;
	
	public var localeModule(default, null) : LocalizationModule;
	
	//debug
	
	public var debugModule(default, null) : DebugModule;
	
	//Screen 
	
	public var screenFactory(default, null) : ScreenFactory;
	
	//data
	
	public var datas(default, null) : DataManager;
	
	
	public function new() 
	{
		BGQApp.self = this;
		
		FontName.init();
		
		this.app = new Application();
		this.app.init("Bubble Galaxie quest", 1920, 1080);
		
		
		loadModel();
		this.datas = new DataManager(this.entityFactory);
		
		createLayer();
		prepareGameModule();
		prepareScreen();
	}
	

	
	private function loadModel() : Void
	{
		this.modelLibrary = new ModelLibrary(new ModelFactory());
		modelLibrary.loadModels("model/modelDescriptor.json");
		this.entityFactory = new EntityFactory(modelLibrary);
	}
	
	private function createLayer() : Void
	{
		this.layerModule = new LayerModule(Lib.current.stage);
		this.app.addModule(this.layerModule, 0);
		
		for (i in 0...LayerName.ordonedLayerNames.length)
		{
			var layerEntity : Entity = this.entityFactory.createLayer(LayerName.ordonedLayerNames[i], i , this.app.width, this.app.height, Anchor.center, Anchor.center);
			layerEntity.add(new RatioResizer());
			this.app.addEntity(layerEntity);
		}
	}
	
	private function prepareGameModule() : Void
	{
		this.screenModule = new ScreenModule(this.layerModule.getLayer(LayerName.screens));
		
		var popupLayerEntity : Entity = this.app.getEntity(LayerName.popup);
		this.popupModule = new PopUpModule(popupLayerEntity.getComponent(Layer), popupLayerEntity.getComponent(UtilitySize2D));	
		
		this.geModule = new GameElementModule();
		this.animRenderModule = new AnimRenderModule();
		this.locationModule = new LocationModule(Lib.current.stage);
		this.pointerModule = new PointerBehavioursModule();
		this.localeModule = new LocalizationModule("fr");
		
		this.localeModule.addLocalizationFile(this.datas.csvManager.getCsv("localeMenu"));
		this.localeModule.addLocalizationFile(this.datas.csvManager.getCsv("localeShipPart"));
		
		
		this.shipModule = new ShipModule();
		
		this.app.addModule(this.screenModule,0);
		this.app.addModule(this.popupModule,1);
		this.app.addModule(this.geModule,2);
		this.app.addModule(this.animRenderModule,3);
		this.app.addModule(this.locationModule,4);
		this.app.addModule(this.pointerModule,5);
		this.app.addModule(this.shipModule,6);
		this.app.addModule(this.localeModule,7);
		
		
		#if debug
		this.debugModule = new DebugModule(this.app.getEntity(LayerName.debug), this.entityFactory);
		this.app.addModule(this.debugModule);
		this.locationModule.debugShowLocGroupRect();
		createDebugComponent();
		this.debugModule.enable(true);
		#end
	}
	
	private function prepareScreen() : Void
	{
		this.screenFactory = new ScreenFactory(this.app, this.entityFactory);
		this.screenFactory.init();
		this.screenModule.goToScreen(ScreenName.mainMenu);
	}
	
	private function createDebugComponent() : Void
	{
		var fpsEnt : Entity = new Entity("debugFps");
		fpsEnt.add(new ShowFps());
		
		var mouseEnt : Entity = new Entity("debugMouse");
		mouseEnt.add(new ShowMousePosition(this.layerModule));
		
		this.app.addEntity(fpsEnt);
		this.app.addEntity(mouseEnt);
	}
	
}