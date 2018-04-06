package screen.crewSummary;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import misc.name.ScreenName;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.animation.Animation;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class CrewSummaryScreen extends ScreenContainer 
{

	private var m_recruitBtn : TextButton;
	
	private var m_crewSummaryBlock : Array<Entity>;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		m_crewSummaryBlock = new Array<Entity>();
		super(ScreenName.crewSummary, appRef, entityFactory);
	}
	
	override function configure():Void 
	{
		super.configure();
	}
	
	override function createElement():Void 
	{
		super.createElement();
		
		var entity : Entity = null;
		
		for (i in 0...5)
		{
			entity = this.m_entityFactoryRef.createGameElement(	this.entity.name + "::summary" + i, 
																this.entity, "crewHeadTimeline", 
																i, 
																new Anchor(25.0,50+150*i,false), Anchor.topLeft, 
																Model.defaultAnim);
																
			entity.getComponent(Animation).useAnimationPivot = false;
			entity.getComponent(Animation).gotoAndStop(i);
			this.add(entity);
		}
		
		m_recruitBtn = new TextButton(this.entity.name + "::recruitBtn", m_appRef, m_entityFactoryRef);
		m_recruitBtn.init("Recrutement", "genericBtn", 6, new Anchor(0.5, 0.95), Anchor.botCenter, onSelectRecruitBtn);
		m_recruitBtn.textDisplay.setFont(FontName.scienceFair);
		m_recruitBtn.textDisplay.setTextColor(0x846248);
		m_recruitBtn.textDisplay.setFontSize(50);
		
		this.add(m_recruitBtn.entity);
	}
	
	
	private function onSelectRecruitBtn() : Void
	{
		BGQApp.self.screenModule.goToScreen(ScreenName.crewSelection);
	}
	
}