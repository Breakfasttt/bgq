package screen.shipSelection;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import data.ship.ShipTemplate;
import data.ship.part.ShipPartComp;
import misc.mover.SimpleEntityMover;
import misc.name.ScreenName;
import openfl.text.TextFormatAlign;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.LocTextButton;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class ShipSelectionScreen extends ScreenContainer 
{

	
	private var m_infos : Entity;
	private var m_infosDisplay : TextDisplay;
	
	private var m_swapTemplateBtn : LocTextButton;
	
	private var m_startBtn : LocTextButton;
	
	private var m_currentTemplate : Int;
	
	private var m_shipContainer : Entity;
	
	private var m_shipPosition : Position2D;
	
	private var m_spatioport : Entity;
	
	private var m_light1 : Entity;
	private var m_light2 : Entity;
	
	private var m_mover : SimpleEntityMover;
	
	private var m_tempPosition : Vector2D;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.shipScreenSelection, appRef, entityFactory);
		
	}
	
	override function configure():Void 
	{
		super.configure();
		
		cast(this.display, Screen).onInit = onInit;
		m_mover = new SimpleEntityMover(this.m_appRef.tick);
		m_tempPosition = new Vector2D();
	}
	
	override function createElement():Void 
	{
		m_infos = m_entityFactoryRef.createTextField("ShipSelectionScreen::infos", this.entity, "", 99,
													new Anchor(0.04, 0.26), Anchor.centerLeft);
													
		m_infosDisplay =  m_infos.getComponent(TextDisplay);
		m_infosDisplay.setFont(FontName.scienceFair);
		m_infosDisplay.setTextColor(0x846248);
		m_infosDisplay.setAlignment(TextFormatAlign.LEFT);
		m_infosDisplay.setFontSize(50);
		m_infosDisplay.setSize(600, 60);
		m_infosDisplay.setMiscProperties(false, false, false, false, false, false);
		
		
		m_swapTemplateBtn = new LocTextButton("ShipSelectionScreen::swapTemplate", this.m_appRef, this.m_entityFactoryRef);
		m_swapTemplateBtn.init("Changer de vaisseau", "genericBtn", 4 , new Anchor(0.04, 0.11), Anchor.centerLeft, onSwapTemplate);
		m_swapTemplateBtn.setLoc("shipSelectionSwapShip");
		m_swapTemplateBtn.textDisplay.setFontSize(32);
		m_swapTemplateBtn.textDisplay.setFont(FontName.scienceFair);
		m_swapTemplateBtn.textDisplay.setTextColor(0x846248);
		
		m_startBtn = new LocTextButton("ShipSelectionScreen::startbtn", this.m_appRef, this.m_entityFactoryRef);
		m_startBtn.init("Décoller", "genericBtn", 5 , new Anchor(0.04, 0.5), Anchor.centerLeft, onFlyOff);
		m_startBtn.setLoc("shipSelectionStartButton");
		m_startBtn.textDisplay.setFontSize(32);
		m_startBtn.textDisplay.setFont(FontName.scienceFair);
		m_startBtn.textDisplay.setTextColor(0x846248);
		
		m_shipContainer = m_entityFactoryRef.createGameElement(this.entity.name + "::shipContainer", this.entity, "", 3, Anchor.topLeft, Anchor.center);
		
		
		m_shipContainer.add(new UtilitySize2D(ShipTemplate.shipRaw * ShipPartComp.shipPartSizeX , ShipTemplate.shipLine * ShipPartComp.shipPartSizeY));
		m_shipPosition = m_shipContainer.getComponent(Position2D);
		m_shipPosition.position2d.ratioMode = false;
		m_shipPosition.position2d.setValue(this.utilitySize.width/2.0, this.utilitySize.height/2.0);
		
		
		m_spatioport = m_entityFactoryRef.createGameElement(this.entity.name+ "::spatioport", this.entity, "spatioport", 2, Anchor.topRight, Anchor.topRight);
		m_light1 = m_entityFactoryRef.createGameElement(this.entity.name+ "::light1", this.entity, "lightEffect", 1, new Anchor(0.58,0.27), Anchor.center, Model.defaultAnim);
		m_light2 = m_entityFactoryRef.createGameElement(this.entity.name+ "::light2", this.entity, "lightEffect", 1, new Anchor(0.58,0.73), Anchor.center, Model.defaultAnim);
		
		m_light1.getComponent(Animation).useAnimationPivot = false;
		m_light2.getComponent(Animation).useAnimationPivot = false;
		
		//m_light1.getComponent(Pivot2D).pivot.anchor.copy(Anchor.center.anchor);
		//m_light2.getComponent(Pivot2D).pivot.anchor.copy(Anchor.center.anchor);
		
		
		this.add(m_infos);
		this.add(m_shipContainer);
		this.add(m_swapTemplateBtn.entity);
		this.add(m_startBtn.entity);
		this.add(m_spatioport);
		this.add(m_light1);
		this.add(m_light2);
	}
	
	private function  onInit() : Void
	{
		m_currentTemplate = 0;
		BGQApp.self.datas.shipParts.setShipPartParentEntity(m_shipContainer);
		BGQApp.self.datas.shipParts.addShipPartToApp(m_appRef);
		updateTemplate();
	}
	
	
	private function onSwapTemplate() : Void
	{
		m_currentTemplate++;
		if (m_currentTemplate  >= BGQApp.self.datas.templateManager.getMaxTemplate())
			m_currentTemplate = 0;
		updateTemplate();
	}
	
	private function updateTemplate() : Void
	{
		var template = BGQApp.self.datas.templateManager.getTemplate(m_currentTemplate);
		BGQApp.self.shipModule.setShipTemplate(template);
		m_infosDisplay.text.text = template.name;
	}
	
	private function onFlyOff() : Void
	{
		this.remove(m_light1);
		this.remove(m_light2);
		this.remove(m_infos);
		this.remove(m_swapTemplateBtn.entity);
		this.remove(m_startBtn.entity);
		
		var disp : Display = m_shipContainer.getComponent(Display);
		
		m_tempPosition.copy(m_shipPosition.position2d.anchor);
		m_mover.setEntityRef(m_shipContainer);
		m_mover.moveTo( -m_shipContainer.getComponent(UtilitySize2D).width, m_tempPosition.y, 300 ,onShipOut);
	}
	
	private function onShipOut() : Void
	{
		m_shipPosition.position2d.setValue(m_tempPosition.x, m_tempPosition.y);
	}
}