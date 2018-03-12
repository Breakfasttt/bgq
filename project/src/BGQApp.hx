package src;
import assets.model.library.ModelLibrary;
import core.Application;
import core.entity.Entity;
import misc.LayerName;
import openfl.Lib;
import standard.components.graphic.display.impl.Layer;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import standard.module.debug.DebugModule;
import standard.module.graphic.AnimRenderModule;
import standard.module.graphic.GameElementModule;
import standard.module.graphic.LayerModule;
import standard.module.graphic.LocationModule;
import standard.module.graphic.PopUpModule;
import standard.module.graphic.ScreenModule;
import standard.module.input.PointerBehavioursModule;
import tools.time.FrameTicker;

/**
 * ...
 * @author Breakyt
 */
class BGQApp 
{

	
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
	
	
	//debug
	
	public var debugModule : DebugModule;
	
	
	
	public function new() 
	{
		this.app = new Application();
		this.app.init("Application test", 1280, 720);
		
		loadModel();
		createLayer();
		prepareGameModule();
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
			var layerEntity : Entity = this.entityFactory.createLayer(LayerName.ordonedLayerNames[i], i , this.app.width, this.app.height);
			this.app.addEntity(layerEntity);
		}
	}	
	
	private function prepareGameModule() : Void
	{
		this.screenModule = new ScreenModule(this.layerModule.getLayer(LayerName.screens));
		var popupLayer : Layer = this.layerModule.getLayer(LayerName.popup);
		this.popupModule = new PopUpModule(popupLayer, popupLayer.getComponent(UtilitySize2D));	
		this.geModule = new GameElementModule();
		this.animRenderModule = new AnimRenderModule();
		this.locationModule = new LocationModule(Lib.current.stage);
		this.pointerModule = new PointerBehavioursModule();
		
		this.app.addModule(this.screenModule);
		this.app.addModule(this.popupModule);
		this.app.addModule(this.geModule);
		this.app.addModule(this.animRenderModule);
		this.app.addModule(this.locationModule);
		this.app.addModule(this.pointerModule);
		
		#if debug
		this.debugModule = new DebugModule();
		this.app.addModule(this.debugModule);
		#end
			
	}
	

	
	
}