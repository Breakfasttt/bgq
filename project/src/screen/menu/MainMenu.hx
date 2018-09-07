package screen.menu;

import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import misc.name.ScreenName;
import openfl.text.TextFormatAlign;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.LocTextButton;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class MainMenu extends ScreenContainer 
{
	
	private var m_title : Entity;
	
	private var m_playBtn : LocTextButton;
	
	private var m_optionsBtn : LocTextButton;
	
	private var m_creditsBtn : LocTextButton;
	
	private var m_localeBtn : LocTextButton;

	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.mainMenu, appRef, entityFactory);
	}
	
	override function configure():Void 
	{
		super.configure();
		
	
		//nothing special
	}
	
	override function createElement():Void 
	{
		m_playBtn = new LocTextButton("mainMenu::playBtn", this.m_appRef, this.m_entityFactoryRef);
		m_playBtn.init("", "genericBtn", 1 , new Anchor(0.5, 0.3), Anchor.center, onPlayBtn);
		m_playBtn.setLoc("menuPlay", null);
		m_playBtn.textDisplay.setFont(FontName.scienceFair);
		m_playBtn.textDisplay.setTextColor(0x846248);
		
		m_optionsBtn = new LocTextButton("mainMenu::optionsBtn", this.m_appRef, this.m_entityFactoryRef);
		m_optionsBtn.init("", "genericBtn", 2,  new Anchor(0.5, 0.45), Anchor.center, onOptionsBtn);
		m_optionsBtn.setLoc("menuOptions", null);
		m_optionsBtn.textDisplay.setFont(FontName.scienceFair);
		m_optionsBtn.textDisplay.setTextColor(0x846248);
		
		m_creditsBtn = new LocTextButton("mainMenu::creditsBtn", this.m_appRef, this.m_entityFactoryRef);
		m_creditsBtn.init("", "genericBtn", 3 , new Anchor(0.5, 0.6), Anchor.center, onCreditsbtn);
		m_creditsBtn.setLoc("menuCredits", null);
		m_creditsBtn.textDisplay.setFont(FontName.scienceFair);
		m_creditsBtn.textDisplay.setTextColor(0x846248);
		
		m_localeBtn = new LocTextButton("mainMenu::localBtn", this.m_appRef, this.m_entityFactoryRef);
		m_localeBtn.init("", "genericBtn", 4 , new Anchor(0.98, 0.01), Anchor.topRight, onLocalbtn, null ,null , null, 0.6, 0.6);
		m_localeBtn.setLoc("menuLocale", null);
		m_localeBtn.textDisplay.setFont(FontName.scienceFair);
		m_localeBtn.textDisplay.setTextColor(0x846248);
		
		createTitle();
		
		this.add(m_playBtn.entity);
		this.add(m_optionsBtn.entity);
		this.add(m_creditsBtn.entity);
		this.add(m_localeBtn.entity);
		this.add(m_title);
	}
	
	private function createTitle() : Void
	{
		m_title = m_entityFactoryRef.createLocTextField("mainMenu::title", null, "menuTitle", null, 99,
													new Anchor(0.5, 0.05), Anchor.center);
													
		var textdisplay : TextDisplay =  m_title.getComponent(TextDisplay);
		textdisplay.setFont(FontName.scienceFair);
		textdisplay.setTextColor(0x846248);
		textdisplay.setAlignment(TextFormatAlign.CENTER);
		textdisplay.setFontSize(50);
		textdisplay.setSize(m_appRef.width, 60);
		textdisplay.setMiscProperties(false, false, false, false, false, false);
		textdisplay.setMouseEnable(false, false);
		//textdisplay.text.mouseEnabled = false;
	}
	
	private function onPlayBtn() : Void
	{
		BGQApp.self.screenModule.goToScreen(ScreenName.crewSelection);
	}
	
	private function onOptionsBtn() : Void
	{
		
	}
	
	private function onCreditsbtn() : Void
	{
		
	}
	
	private function onLocalbtn() : Void
	{
		if(BGQApp.self.localeModule.localeCode == "fr")
			BGQApp.self.localeModule.setLocaleCode("en");
		else
			BGQApp.self.localeModule.setLocaleCode("fr");
	}
	
	
}