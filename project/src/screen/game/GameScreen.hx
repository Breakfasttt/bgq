package screen.game;

import core.Application;
import core.entity.Entity;
import misc.name.ScreenName;
import misc.transition.FadeTransition;
import openfl.text.TextFormatAlign;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.display.impl.TextDisplay;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class GameScreen extends ScreenContainer 
{

	private var m_title : Entity;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.gameScreen, appRef, entityFactory);	
	}
	
	override function configure():Void 
	{
		super.configure();
		this.m_opener.setOpenTransition(new FadeTransition(1.0, 0.0));
		this.m_opener.setCloseTransition(new FadeTransition());
	}
	
	override function createElement():Void 
	{
		createTitle();
		
		this.add(m_title);
	}
	
	override function onCustomScreenInit():Void 
	{
		
	}
	
	override function onCustomScreenOpen():Void 
	{
		
	}
	
	override function onCustomScreenClose():Void 
	{
		
	}
	
	private function createTitle() : Void
	{
		m_title = m_entityFactoryRef.createLocTextField("gameScreen::titletemp", null, "wip", null, 99,
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
	
}