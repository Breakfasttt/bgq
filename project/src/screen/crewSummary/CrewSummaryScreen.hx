package screen.crewSummary;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import misc.name.ScreenName;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.Screen;
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
class CrewSummaryScreen extends ScreenContainer 
{

	private var m_recruitBtn : TextButton;
	
	private var m_crewSummaryBlock : Array<Entity>;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		
		super(ScreenName.crewSummary, appRef, entityFactory);
	}
	
	override function configure():Void 
	{
		super.configure();
	}
	
	
	override function createElement():Void 
	{
		var entity : Entity = null;
		
		m_crewSummaryBlock = new Array<Entity>();
		
		for (i in 0...5)
		{
			entity = this.m_entityFactoryRef.createGameElement(	this.entity.name + "::summary" + i, 
																this.entity, "crewHeadTimeline", 
																i, 
																new Anchor(25.0,50+150*i,false), Anchor.topLeft, 
																Model.defaultAnim);
																
			entity.getComponent(Animation).useAnimationPivot = false;
			entity.getComponent(Animation).gotoAndStop(0);
			var behaviours : PointerBehavioursComponent = new PointerBehavioursComponent();
			var btnBehaviour : EntityAsSimpleButton = new EntityAsSimpleButton(false,"", false);
			btnBehaviour.onSelect = showCrew.bind(i+1);
			behaviours.addBehaviour(btnBehaviour,0);
			entity.add(behaviours);
			this.add(entity);
			m_crewSummaryBlock.push(entity);
		}
		
		m_recruitBtn = new TextButton(this.entity.name + "::recruitBtn", m_appRef, m_entityFactoryRef);
		m_recruitBtn.init("Recrutement", "genericBtn", 6, new Anchor(0.5, 0.95), Anchor.botCenter, onSelectRecruitBtn);
		m_recruitBtn.textDisplay.setFont(FontName.scienceFair);
		m_recruitBtn.textDisplay.setTextColor(0x846248);
		m_recruitBtn.textDisplay.setFontSize(50);
		
		this.add(m_recruitBtn.entity);
		
		cast(this.display, Screen).onOpen = refreshInformation;
		
	}
	
	private function onSelectRecruitBtn() : Void
	{
		BGQApp.self.screenModule.goToScreen(ScreenName.crewSelection);
	}
	
	
	private function refreshInformation() : Void
	{
		var crews : Array<CrewMember> = BGQApp.self.datas.crewManager.getSelectedCrews();
		
		//todo
		for (i in 0...crews.length)
		{
			if(crews[i] != null)
				m_crewSummaryBlock[i].getComponent(Animation).gotoAndStop(i+1);
		}
		
	}
	
	
	private function showCrew(index : Int) : Void
	{
		trace("showCrew" + index);
	}
	
}