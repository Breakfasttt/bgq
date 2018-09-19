package screen.crewSelection;

import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import misc.mover.SimpleEntityMover;
import misc.name.ScreenName;
import openfl.text.TextFormatAlign;
import popup.confirmPopup.ConfirmPopup;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.space2d.Position2D;
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
	
	private var m_currentCrewToHire : CrewMember;
	
	private var m_mover : SimpleEntityMover;
	
	private var m_backToMenuPopup : ConfirmPopup;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.crewSelection, appRef, entityFactory);	
		m_mover = new SimpleEntityMover(m_appRef.tick);
		m_backToMenuPopup = new ConfirmPopup(this.m_appRef, this.m_entityFactoryRef, "popupBacktoMenu", "Quitter la partie ?", "Vous êtes sur le point de quitter la partie, votre recrutement sera annulé. Etes vous sûr ?");
		m_backToMenuPopup.confirmCb = onBackToMenu;
		//m_backToMenuPopup.cancelCb = onCancelBackToMenu;
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
		m_backBtn.init("Retour", "genericBtn", 1 , new Anchor(20, 20,false), Anchor.topLeft, onBackButton, null, null, 0.75,0.75);
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
		
		m_crewFile.initSlideBehaviour(650, -this.utilitySize.width / 2.0, this.utilitySize.width * 1.5);
		m_crewFile.slider.onSlideCallback = onFileSlide;
		m_crewFile.slider.onStartSlideCallback = onFileSlide;
		m_crewFile.slider.backToInitCallback = onFileSlide;
		m_crewFile.slider.onValidPosition = validFile;
		m_crewFile.slider.startConfirmAnimCallback = fixTitleWhileConfirmAnim;
		
		this.add(m_infos);
		this.add(m_backBtn.entity);
		this.add(m_crewBtn.entity);
		this.add(m_crewFile.entity);
		this.add(m_slideInfos);
	}
	
	override function onCustomScreenOpen():Void 
	{
		m_currentCrewToHire = BGQApp.self.datas.crewManager.getGeneratedCrewMember();
		m_crewFile.setCrewData(m_currentCrewToHire);
		m_crewFile.slider.reinitPosition();
		updateInfos();
	}
	
	private function onBackButton() : Void
	{
		this.m_appRef.addEntity(m_backToMenuPopup.entity);
	}
	
	private function onBackToMenu() : Void
	{
		this.invertTransition();
		BGQApp.self.screenFactory.mainMenuScreen.invertTransition();
		
		BGQApp.self.datas.crewManager.reset();
		BGQApp.self.screenModule.goToScreen(ScreenName.mainMenu);
	}
	
	private function onCrewButton() : Void
	{
		BGQApp.self.screenModule.goToScreen(ScreenName.crewSummary);
	}
	
	private function onFileSlide() : Void
	{
		if (m_crewFile.slider.slideSens < 0.0)
			m_slideTextDisplay.text.text = "Merci pour cet entretien, on vous rappellera...";
		else if(m_crewFile.slider.slideSens > 0.0)
			m_slideTextDisplay.text.text = "On vous engage ! Bienvenue au BSE.";
		else
			m_slideTextDisplay.text.text = "";
			
		
		m_slideTextDisplay.skin.alpha = m_crewFile.slider.confirmRatio;
		
		if (m_crewFile.slider.confirmRatio >= 1.0)
		{
			if(m_crewFile.slider.slideSens > 0.0)
				m_slideTextDisplay.setTextColor(0x005f1a);
			else
				m_slideTextDisplay.setTextColor(0x5f1a00);
				
			m_slideTextDisplay.skin.alpha = 1.0;
		}
		else
			m_slideTextDisplay.setTextColor(0x846248);
		
	}
	
	private function fixTitleWhileConfirmAnim() : Void
	{
		if(m_crewFile.slider.slideSens > 0.0)
			m_slideTextDisplay.setTextColor(0x005f1a);
		else
			m_slideTextDisplay.setTextColor(0x5f1a00);
				
		m_slideTextDisplay.skin.alpha = 1.0;
	}
	
	private function validFile(sens : Float) : Void
	{
		m_slideTextDisplay.text.text = "";
		m_slideTextDisplay.setTextColor(0x846248);
		m_slideTextDisplay.skin.alpha = 1.0;
		
		if (sens > 0.0)
		{
			BGQApp.self.datas.crewManager.addToSelected(m_currentCrewToHire);
			trace("added : " + m_currentCrewToHire.toString());
		}
		
		if (BGQApp.self.datas.crewManager.crewIsFull())
		{
			updateInfos();
			return;
		}
		
		m_currentCrewToHire = BGQApp.self.datas.crewManager.getGeneratedCrewMember();
		m_crewFile.setCrewData(m_currentCrewToHire);
		m_crewFile.slider.enable = false;
		
		m_mover.setEntityRef(m_crewFile.entity);
		
		m_crewFile.position.position2d.anchor.x = this.utilitySize.width / 2.0 - 80;
		m_crewFile.position.position2d.anchor.y = -10.0;  //this.utilitySize.height * 0.80;
		m_mover.moveTo(this.utilitySize.width / 2.0, this.utilitySize.height * 0.80, 4000, onNewCrewReveal);
		
	}
	
	private function onNewCrewReveal() : Void
	{
		m_crewFile.slider.reinitPosition();
	}
	
	private function updateInfos() : Void
	{
		var pos : Position2D = m_infos.getComponent(Position2D);
		var td : TextDisplay = m_infos.getComponent(TextDisplay);
		
		if (BGQApp.self.datas.crewManager.crewIsFull())
		{
			pos.position2d.setValue(0.5, 0.5);
			td.text.text = "Votre équipage est au complet. Appuyez sur le bouton Equipage pour l'inspecter.";
			//m_crewFile.display.skin.visible = false;
			this.remove(m_crewFile.entity);
		}
		else
		{
			pos.position2d.setValue(0.5, 0.1);
			td.text.text = "Engager les membres d'équipages";
			//m_crewFile.display.skin.visible = true;
			this.add(m_crewFile.entity);
		}
	}
}