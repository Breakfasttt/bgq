package screen;
import core.Application;
import screen.menu.MainMenu;
import standard.factory.EntityFactory;

/**
 * ...
 * @author Breakyt
 */
class ScreenFactory 
{
	private var m_appRef : Application;
	private var m_entityFactoryRef : EntityFactory;
	
	public var mainMenuScreen(default,null) : MainMenu;
	
	public function new(appRef : Application, entityFactory : EntityFactory) 
	{
		m_appRef = appRef;
		m_entityFactoryRef = entityFactory;
	}
	
	public function init() : Void
	{
		this.mainMenuScreen = new MainMenu(m_appRef, m_entityFactoryRef);
		
		
		
		this.m_appRef.addEntity(this.mainMenuScreen.entity);
		
	}
	
}