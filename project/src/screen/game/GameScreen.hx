package screen.game;

import core.Application;
import misc.name.ScreenName;
import standard.components.graphic.display.impl.Screen;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;

/**
 * ...
 * @author Breakyt
 */
class GameScreen extends ScreenContainer 
{

	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.gameScreen, appRef, entityFactory);	
	}
	
	override function configure():Void 
	{
		super.configure();
		
		cast(this.display, Screen).onInit = refreshInformation;
		cast(this.display, Screen).onOpen = refreshInformation;
		cast(this.display, Screen).onClose = refreshInformation;
	}
	
	override function createElement():Void 
	{
		
	}
	
}