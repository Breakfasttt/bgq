package screen.crewSelection;

import core.Application;
import core.entity.Entity;
import misc.name.ScreenName;
import openfl.text.TextFormatAlign;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.display.impl.TextDisplay;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class CrewSelectionScreen extends ScreenContainer 
{

	private var m_infos : Entity;
	
	private var m_slideInfos : Entity;
	private var m_slideTextDisplay : TextDisplay;
	
	private var m_backBtn : TextButton;
	
	private var m_crewBtn : TextButton;
	
	private var m_crewFile : CrewFileUi;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.crewSelection, appRef, entityFactory);	
	}
	
	override function configure():Void 
	{
		super.configure();
		
	}
	
	override function createElement():Void 
	{
		
		m_infos = m_entityFactoryRef.createTextField("CrewSelectionScreen::infos", this.entity, "Engager les membres d'équipage", 99,
													new Anchor(0.5, 0.1), Anchor.center);
													
		var textdisplay : TextDisplay =  m_infos.getComponent(TextDisplay);
		textdisplay.setFont(FontName.scienceFair);
		textdisplay.setTextColor(0x846248);
		textdisplay.setAlignment(TextFormatAlign.CENTER);
		textdisplay.setFontSize(50);
		textdisplay.setSize(m_appRef.width, 60);
		textdisplay.setMiscProperties(false, false, false, false, false, false);
		
		m_backBtn = new TextButton("CrewSelectionScreen::backButton", this.m_appRef, this.m_entityFactoryRef);
		m_backBtn.init("Retour", "genericBtn", 1 , new Anchor(0.01, 0.01), Anchor.topLeft, onBackButton, null, null, 0.8,0.8);
		m_backBtn.textDisplay.setFont(FontName.scienceFair);
		m_backBtn.textDisplay.setTextColor(0x846248);
		m_backBtn.textDisplay.setFontSize(50);
		
		m_crewBtn = new TextButton("CrewSelectionScreen::crewButton", this.m_appRef, this.m_entityFactoryRef);
		m_crewBtn.init("Voir équipage", "genericBtn", 2 , new Anchor(0.5, 0.95), Anchor.center, onCrewButton);
		m_crewBtn.textDisplay.setFont(FontName.scienceFair);
		m_crewBtn.textDisplay.setTextColor(0x846248);
		
		
		m_slideInfos = m_entityFactoryRef.createTextField("CrewSelectionScreen::SlideInfos", this.entity, "test", 4,  new Anchor(0.5, 0.20), Anchor.center);
		m_slideTextDisplay =  m_slideInfos.getComponent(TextDisplay);
		m_slideTextDisplay.setFont(FontName.scienceFair);
		m_slideTextDisplay.setTextColor(0x846248);
		m_slideTextDisplay.setAlignment(TextFormatAlign.CENTER);
		m_slideTextDisplay.setFontSize(50);
		m_slideTextDisplay.setSize(m_appRef.width, 60);
		m_slideTextDisplay.setMiscProperties(false, false, false, false, false, false);
		m_slideTextDisplay.skin.alpha = 0.0;
		
		
		m_crewFile = new CrewFileUi("CrewSelectionScreen::crewFile", this.m_appRef, this.m_entityFactoryRef, this.entity, 3);
		m_crewFile.position.position2d.ratioMode = false;
		m_crewFile.position.position2d.anchor.x = this.utilitySize.width / 2.0;
		m_crewFile.position.position2d.anchor.y = this.utilitySize.height * 0.80;
		m_crewFile.pivot.pivot = Anchor.botCenter;
		m_crewFile.slider.onSlideCallback = onFileSlide;
		m_crewFile.slider.onSlideStartCallback = onFileSlide;
		m_crewFile.slider.onSlideBackCallback = onFileSlide;
		
		this.add(m_infos);
		this.add(m_backBtn.entity);
		this.add(m_crewBtn.entity);
		this.add(m_crewFile.entity);
		this.add(m_slideInfos);
			
		cast(this.display, Screen).onOpen = onOpen;
	}
	
	private function onOpen() : Void
	{
		m_crewFile.setCrewData(BGQApp.self.datas.crewManager.getGeneratedCrewMember());
	}
	
	private function onBackButton() : Void
	{
		BGQApp.self.screenModule.goToScreen(ScreenName.mainMenu);
	}
	
	private function onCrewButton() : Void
	{
		
	}
	
	private function onFileSlide() : Void
	{
		if (m_crewFile.slider.slideSens < 0.0)
			m_slideTextDisplay.text.text = "Merci pour cette entretien, on vous rappelera...";
		else if(m_crewFile.slider.slideSens > 0.0)
			m_slideTextDisplay.text.text = "On vous engage ! Bienvenue au BSE.";
		else
			m_slideTextDisplay.text.text = "";
			
		
		m_slideTextDisplay.skin.alpha = m_crewFile.slider.confirmRatio;
		
		if (m_slideTextDisplay.skin.alpha > 1.0)
			m_slideTextDisplay.skin.alpha = 1.0;
		
	}
	
}