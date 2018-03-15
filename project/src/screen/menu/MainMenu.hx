package screen.menu;

import core.Application;
import core.entity.Entity;
import misc.name.ScreenName;
import src.BGQApp;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class MainMenu extends ScreenContainer 
{
	
	private var m_bg : Entity;
	
	private var m_playBtn : TextButton;
	
	private var m_optionsBtn : TextButton;
	
	private var m_creditsBtn : TextButton;

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
		m_bg = this.m_entityFactoryRef.createGameElement("mainMenu::Bg", this.entity, "mainMenuBg", 0, Anchor.topLeft, Anchor.topLeft);
		
		m_playBtn = new TextButton("mainMenu::playBtn", this.m_appRef, this.m_entityFactoryRef);
		m_playBtn.init("Jouer", "genericBtn", 1 , new Anchor(0.5, 0.3), Anchor.center, onPlayBtn);
		
		m_optionsBtn = new TextButton("mainMenu::optionsBtn", this.m_appRef, this.m_entityFactoryRef);
		m_optionsBtn.init("Options", "genericBtn", 2,  new Anchor(0.5, 0.45), Anchor.center, onOptionsBtn);
		
		m_creditsBtn = new TextButton("mainMenu::creditsBtn", this.m_appRef, this.m_entityFactoryRef);
		m_creditsBtn.init("Credits", "genericBtn", 3 , new Anchor(0.5, 0.6), Anchor.center, onCreditsbtn);
		
		this.add(m_bg);
		this.add(m_playBtn.entity);
		this.add(m_optionsBtn.entity);
		this.add(m_creditsBtn.entity);
	}
	
	
	private function onPlayBtn() : Void
	{
		
	}
	
	private function onOptionsBtn() : Void
	{
		
	}
	
	private function onCreditsbtn() : Void
	{
		
	}
	
}