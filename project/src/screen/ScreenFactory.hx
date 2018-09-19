package screen;
import core.Application;
import core.entity.Entity;
import misc.name.LayerName;
import screen.crewSelection.CrewSelectionScreen;
import screen.crewSummary.CrewSummaryScreen;
import screen.game.GameScreen;
import screen.menu.MainMenu;
import screen.shipSelection.ShipSelectionScreen;
import standard.factory.EntityFactory;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ScreenFactory 
{
	private var m_appRef : Application;
	private var m_entityFactoryRef : EntityFactory;
	
	private var m_bg : Entity;
	
	public var mainMenuScreen(default, null) : MainMenu;
	public var crewSelectionScreen(default, null) : CrewSelectionScreen;
	public var crewSelectionSummary(default, null) : CrewSummaryScreen;
	public var shipSelection(default, null) : ShipSelectionScreen;
	public var gameScreen(default, null) : GameScreen;
	
	public function new(appRef : Application, entityFactory : EntityFactory) 
	{
		m_appRef = appRef;
		m_entityFactoryRef = entityFactory;
	}
	
	public function init() : Void
	{
		var backEntity : Entity = m_appRef.getEntity(LayerName.back);
		
		this.m_bg = this.m_entityFactoryRef.createGameElement("mainMenu::Bg", backEntity, "mainMenuBg", 0, Anchor.topLeft, Anchor.topLeft);
		
		this.mainMenuScreen = new MainMenu(m_appRef, m_entityFactoryRef);
		this.crewSelectionScreen = new CrewSelectionScreen(m_appRef, m_entityFactoryRef);
		this.crewSelectionSummary = new CrewSummaryScreen(m_appRef, m_entityFactoryRef);
		this.shipSelection = new ShipSelectionScreen(m_appRef, m_entityFactoryRef);
		this.gameScreen = new GameScreen(m_appRef, m_entityFactoryRef);
		
		
		this.m_appRef.addEntity(this.m_bg);
		this.m_appRef.addEntity(this.mainMenuScreen.entity);
		this.m_appRef.addEntity(this.crewSelectionScreen.entity);
		this.m_appRef.addEntity(this.crewSelectionSummary.entity);
		this.m_appRef.addEntity(this.shipSelection.entity);
		this.m_appRef.addEntity(this.gameScreen.entity);
	}
	
}