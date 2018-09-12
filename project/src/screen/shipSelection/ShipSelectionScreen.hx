package screen.shipSelection;

import core.Application;
import core.entity.Entity;
import data.ship.part.ShipPartComp;
import misc.name.ScreenName;
import openfl.text.TextFormatAlign;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.space2d.Position2D;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ShipSelectionScreen extends ScreenContainer 
{

	
	private var m_infos : Entity;
	private var m_infosDisplay : TextDisplay;
	
	private var m_swapTemplate : TextButton;
	
	private var m_currentTemplate : Int;
	
	private var m_shipContainer : Entity;
	
	private var m_shipPosition : Position2D;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.shipScreenSelection, appRef, entityFactory);
		
	}
	
	override function configure():Void 
	{
		super.configure();
		
		cast(this.display, Screen).onInit = onInit;
	}
	
	override function createElement():Void 
	{
		m_infos = m_entityFactoryRef.createTextField("ShipSelectionScreen::infos", this.entity, "", 99,
													new Anchor(0.5, 0.1), Anchor.center);
													
		m_infosDisplay =  m_infos.getComponent(TextDisplay);
		m_infosDisplay.setFont(FontName.scienceFair);
		m_infosDisplay.setTextColor(0x846248);
		m_infosDisplay.setAlignment(TextFormatAlign.CENTER);
		m_infosDisplay.setFontSize(50);
		m_infosDisplay.setSize(m_appRef.width, 60);
		m_infosDisplay.setMiscProperties(false, false, false, false, false, false);
		
		
		m_swapTemplate = new TextButton("ShipSelectionScreen::swapTemplate", this.m_appRef, this.m_entityFactoryRef);
		m_swapTemplate.init("Changer de vaisseau", "genericBtn", 2 , new Anchor(0.5, 0.95), Anchor.center, onSwapTemplate);
		m_swapTemplate.textDisplay.setFontSize(32);
		m_swapTemplate.textDisplay.setFont(FontName.scienceFair);
		m_swapTemplate.textDisplay.setTextColor(0x846248);
		
		m_shipContainer = m_entityFactoryRef.createGameElement(this.entity.name + "::shipContainer", this.entity, "", 0, Anchor.topLeft, Anchor.center);
		
		var shipNumber : Int = BGQApp.self.datas.shipParts.getShipPartNumb();
		m_shipContainer.add(new UtilitySize2D(shipNumber * ShipPartComp.shipPartSizeX , shipNumber * ShipPartComp.shipPartSizeY));
		m_shipPosition = m_shipContainer.getComponent(Position2D);
		m_shipPosition.position2d.setValue(0.5, 0.5);
		
		this.add(m_infos);
		this.add(m_shipContainer);
		this.add(m_swapTemplate.entity);
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
}