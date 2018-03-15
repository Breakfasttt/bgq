package screen.menu;

import core.Application;
import core.entity.Entity;
import misc.name.ScreenName;
import src.BGQApp;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class MainMenu extends ScreenContainer 
{
	
	private var m_bg : Entity;
	
	private var m_playBtn : Entity;
	
	private var m_optionsBtn : Entity;
	
	private var m_creditsBtn : Entity;

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
		
		m_playBtn = this.m_entityFactoryRef.createSimpleBtn("mainMenu::playBtn", this.entity, "genericBtn", 1, new Anchor(0.5, 0.2), Anchor.center,
															onPlayBtn);
		
		
		m_optionsBtn =  this.m_entityFactoryRef.createSimpleBtn("mainMenu::optionsBtn", this.entity, "genericBtn", 1, new Anchor(0.5, 0.3), Anchor.center,
															onOptionsBtn);
															
		m_creditsBtn =  this.m_entityFactoryRef.createSimpleBtn("mainMenu::creditsBtn", this.entity, "genericBtn", 1, new Anchor(0.5, 0.4), Anchor.center,
															onCreditsbtn);
		
		
		this.add(m_bg);
		this.add(m_playBtn);
		this.add(m_optionsBtn);
		this.add(m_creditsBtn);
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