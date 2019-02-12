package src;
import assets.audio.AudioLibrary;
import assets.model.library.ModelFactory;
import assets.model.library.ModelLibrary;
import core.Application;
import core.entity.Entity;
import data.GameDataManager;
import data.randomizer.NameRandomizer;
import misc.name.LayerName;
import misc.name.ScreenName;
import module.ship.ShipTemplateModule;
import openfl.Assets;
import openfl.Lib;
import openfl.media.Sound;
import openfl.ui.Keyboard;
import screen.ScreenFactory;
import src.misc.name.FontName;
import standard.components.debug.impl.DebugKeyBinding;
import standard.components.debug.impl.ShowFps;
import standard.components.debug.impl.ShowMousePosition;
import standard.components.graphic.display.impl.Layer;
import standard.components.audio.Audio;
import standard.components.audio.AudioType;
import standard.components.space2d.UtilitySize2D;
import standard.components.space2d.resizer.impl.RatioResizer;
import standard.factory.EntityFactory;
import standard.module.audio.AudioModule;
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
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class BGQApp 
{

	
	public static var self : BGQApp;
	
	//base
	public var app(default, null) : Application;
	
	public var csvManager(default, null) : CsvManager;
	
	public var modelLibrary(default, null) : ModelLibrary;
	
	public var audiosLibrary(default, null) : AudioLibrary;
	
	public var entityFactory(default, null) : EntityFactory;
	
	//module
	
	public var layerModule(default, null) : LayerModule;
	
	public var screenModule(default, null) : ScreenModule;
	
	public var popupModule(default, null) : PopUpModule;
	
	public var geModule(default, null) : GameElementModule;
	
	public var animRenderModule(default, null) : AnimRenderModule;
	
	public var locationModule(default, null) : LocationModule;
	
	public var pointerModule(default, null) : PointerBehavioursModule;
	
	public var audioModule(default, null) : AudioModule;
	
	public var shipModule(default, null) : ShipTemplateModule;
	
	public var localeModule(default, null) : LocalizationModule;
	
	//debug
	
	public var debugModule(default, null) : DebugModule;
	
	//Screen 
	
	public var screenFactory(default, null) : ScreenFactory;
	
	//data
	
	public var datas(default, null) : GameDataManager;
	
	private var m_nameParser : NameRandomizer;
	
	public function new() 
	{
		BGQApp.self = this;
		
		FontName.init();
		
		this.app = new Application();
		this.app.init("Bubble Galaxie quest", 1920, 1080);
		
		//m_nameParser = new NameRandomizer();
		//m_nameParser.init("datas/nameLibrary/refList/noms2008nat_txt.txt",onParsingEnded);
		onParsingEnded();
	}
	
	private function onParsingEnded() : Void
	{
		loadLibraryAndGameData();
		createLayer();
		prepareGameModule();
		prepareScreen();
	}
	
	private function loadLibraryAndGameData() : Void
	{
		this.csvManager = new CsvManager();
		parseCsv();
		
		this.modelLibrary = new ModelLibrary(new ModelFactory());
		modelLibrary.loadModels("model/modelDescriptor.json");
		
		this.audiosLibrary = new AudioLibrary();
		this.audiosLibrary.loadFromCsv(this.csvManager.getCsv("audio"));
		
		this.entityFactory = new EntityFactory(modelLibrary, audiosLibrary);
		
		this.datas = new GameDataManager(this.entityFactory, this.csvManager);
	}
	
	private function parseCsv() : Void
	{
		//locale
		this.csvManager.parseAndRegisterCsv("localeMenu", Assets.getText("datas/localization/menu.csv"));
		this.csvManager.parseAndRegisterCsv("localeShipPart", Assets.getText("datas/localization/shipPart.csv"));
		this.csvManager.parseAndRegisterCsv("localeProfession", Assets.getText("datas/localization/profession.csv"));
		
		//ship data
		this.csvManager.parseAndRegisterCsv("shipPartData", Assets.getText("datas/ship/shipPartDef.csv"));
		
		//sound
		this.csvManager.parseAndRegisterCsv("audio", Assets.getText("datas/audio/audios.csv"));
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
		this.audioModule = new AudioModule();
		this.localeModule = new LocalizationModule("fr");
		
		this.localeModule.addLocalizationFile(this.csvManager.getCsv("localeMenu"));
		this.localeModule.addLocalizationFile(this.csvManager.getCsv("localeShipPart"));
		this.localeModule.addLocalizationFile(this.csvManager.getCsv("localeProfession"));
		
		
		this.shipModule = new ShipTemplateModule();
		
		this.app.addModule(this.screenModule,0);
		this.app.addModule(this.popupModule,1);
		this.app.addModule(this.geModule,2);
		this.app.addModule(this.animRenderModule,3);
		this.app.addModule(this.locationModule,4);
		this.app.addModule(this.pointerModule, 5);
		this.app.addModule(this.audioModule,6);
		this.app.addModule(this.shipModule,7);
		this.app.addModule(this.localeModule,8);
		
		
		#if debug
		this.debugModule = new DebugModule(this.app.getEntity(LayerName.debug), this.entityFactory);
		this.app.addModule(this.debugModule);
		
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
		
		var keyboardBindingEnt : Entity = new Entity("debugBinding");
		var keyboardBinding : DebugKeyBinding = new DebugKeyBinding();
		keyboardBinding.addCallBack(Keyboard.L, showLayer);
		keyboardBinding.addCallBack(Keyboard.M, showMousePos);
		keyboardBinding.addCallBack(Keyboard.F, showFps);
		keyboardBinding.addCallBack(Keyboard.N, generateName);
		keyboardBindingEnt.add(keyboardBinding);
		
		this.app.addEntity(fpsEnt);
		this.app.addEntity(mouseEnt);
		this.app.addEntity(keyboardBindingEnt);
	}
	
	
	private function showLayer() : Void
	{
		this.locationModule.debugShowLocGroupRect();
	}
	
	private function showMousePos() : Void
	{
		var mDebugEnt : Entity = this.app.getEntity("debugMouse");
		
		if (mDebugEnt == null)
			return;
			
		var dComp : ShowMousePosition = mDebugEnt.getComponent(ShowMousePosition);
		
		if (dComp == null)
			return;
			
		dComp.show();	
	}
	
	private function showFps() : Void
	{
		var mDebugEnt : Entity = this.app.getEntity("debugFps");
		
		if (mDebugEnt == null)
			return;
			
		var dComp : ShowFps = mDebugEnt.getComponent(ShowFps);
		
		if (dComp == null)
			return;
			
		dComp.show();	
	}
	
	private function generateName() : Void
	{
		for (i in 0...1000)
			trace(m_nameParser.generate(4, 10));
	}
}