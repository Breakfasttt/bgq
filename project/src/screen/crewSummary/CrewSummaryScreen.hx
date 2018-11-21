package screen.crewSummary;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import misc.name.ScreenName;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import popup.confirmPopup.ConfirmPopup;
import screen.crewSelection.CrewFileUi;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.Screen;
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
class CrewSummaryScreen extends ScreenContainer 
{

	private var m_recruitBtn : LocTextButton;
	
	private var m_firedBtn : LocTextButton;
	
	private var m_nextBtn : LocTextButton;
	
	private var m_crewSummaryBlock : Array<Entity>;
	
	private var m_crewFile : CrewFileUi;
	
	private var m_infos : Entity;
	
	private var m_lastSelected : Int;
	
	private var m_confirmFiredPopup : ConfirmPopup;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.crewSummary, appRef, entityFactory);
		
		m_confirmFiredPopup = new ConfirmPopup(this.m_appRef, this.m_entityFactoryRef, "popupConfirmFired", "popupFiredCrewTitle", "popupFiredCrewInfos");
		m_confirmFiredPopup.confirmCb = confirmFired;
		
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
																
			
			var anim = entity.getComponent(Animation);
			
			if (anim != null)
			{
				anim.useAnimationPivot = false;
				anim.gotoAndStop(0);
			}
			
			
			var behaviours : PointerBehavioursComponent = new PointerBehavioursComponent();
			var btnBehaviour : EntityAsSimpleButton = new EntityAsSimpleButton(false,"", false);
			btnBehaviour.onSelect = showCrew.bind(i);
			behaviours.addBehaviour(btnBehaviour,0);
			entity.add(behaviours);
			this.add(entity);
			m_crewSummaryBlock.push(entity);
		}
		
		m_recruitBtn = new LocTextButton(this.entity.name + "::recruitBtn", m_appRef, m_entityFactoryRef);
		m_recruitBtn.init("genericBtn", 6, new Anchor(0.33, 0.97), Anchor.botCenter, onSelectRecruitBtn);
		m_recruitBtn.setLoc("crewSummaryRecruitBtn");
		m_recruitBtn.textDisplay.setFont(FontName.scienceFair);
		m_recruitBtn.textDisplay.setTextColor(0x846248);
		m_recruitBtn.textDisplay.setFontSize(50);
		
		m_firedBtn = new LocTextButton(this.entity.name + "::firedBtn", m_appRef, m_entityFactoryRef);
		m_firedBtn.init("genericBtn", 7, new Anchor(0.66, 0.97), Anchor.botCenter, onSelectFiredBtn);
		m_firedBtn.setLoc("crewSummaryHireBtn");
		m_firedBtn.textDisplay.setFont(FontName.scienceFair);
		m_firedBtn.textDisplay.setTextColor(0x846248);
		m_firedBtn.textDisplay.setFontSize(50);
		
		m_nextBtn = new LocTextButton(this.entity.name + "::nextBtn", m_appRef, m_entityFactoryRef);
		m_nextBtn.init("genericBtn", 99, new Anchor(0.97, 0.50), Anchor.centerRight, onSelectNext, null, null, null, 0.7, 0.7);
		m_nextBtn.setLoc("crewSummaryShipSelectionBtn");
		m_nextBtn.textDisplay.setFont(FontName.scienceFair);
		m_nextBtn.textDisplay.setTextColor(0x846248);
		m_nextBtn.textDisplay.setFontSize(50);
		m_nextBtn.display.skin.visible = false;
		
		
		m_infos = this.m_entityFactoryRef.createLocTextField(this.entity.name + "::infos", null, "crewSummaryNoMembers", null, 10, Anchor.center, Anchor.center);
		var dispInfos : TextDisplay = m_infos.getComponent(TextDisplay);
		dispInfos.setFont(FontName.scienceFair);
		dispInfos.setAutoSize(TextFieldAutoSize.LEFT);
		dispInfos.setAlignment(TextFormatAlign.CENTER);
		dispInfos.setTextColor(0x846248);
		dispInfos.setFontSize(40);
		dispInfos.setMiscProperties(false, false, false, false, false, false);
		
		m_crewFile = new CrewFileUi(this.entity.name + "::crewFile", this.m_appRef, this.m_entityFactoryRef, this.entity, 3);
		m_crewFile.scale.scale.set(1.5,1.5);
		m_crewFile.position.position2d = new Anchor(0.5, 0.05);
		m_crewFile.pivot.pivot = Anchor.topCenter;
		
		this.add(m_recruitBtn.entity);
		this.add(m_firedBtn.entity);
		this.add(m_nextBtn.entity);
	}
	
	override function onCustomScreenInit():Void 
	{
		refreshInformation();
	}
	
	private function onSelectRecruitBtn() : Void
	{
		
		this.invertTransition();
		BGQApp.self.screenFactory.crewSelectionScreen.invertTransition();
		BGQApp.self.screenModule.goToScreen(ScreenName.crewSelection);
	}
	
	private function onSelectFiredBtn() : Void
	{
		this.m_appRef.addEntity(m_confirmFiredPopup.entity);
	}
	
	private function confirmFired() : Void
	{
		var crewMember : CrewMember = BGQApp.self.datas.crewManager.getSelectedCrew(m_lastSelected);
		BGQApp.self.datas.crewManager.removeToSelected(crewMember);
		
		if(BGQApp.self.datas.crewManager.getCurrentCrewNumber() <= 0)
			m_lastSelected = -1;
		else
			m_lastSelected = 0;
		
		refreshInformation();
	}
	
	private function refreshInformation() : Void
	{
		var crewsNumber : Int = BGQApp.self.datas.crewManager.getCurrentCrewNumber();
		
		var anim : Animation = null;
		for (i in 0...m_crewSummaryBlock.length)
		{
			anim = m_crewSummaryBlock[i].getComponent(Animation);
			
			if (anim == null)
				continue;
			
			if (i < crewsNumber)
				anim.gotoAndStop(i + 1);
			else
				anim.gotoAndStop(0);
			
		}
		
		m_nextBtn.display.skin.visible = false;
		
		if (crewsNumber == 0)
		{
			this.remove(m_crewFile.entity);
			this.add(m_infos);
			m_lastSelected = -1;
			this.remove(m_firedBtn.entity);
		}
		else
		{
			this.add(m_crewFile.entity);
			this.add(m_firedBtn.entity);
			this.remove(m_infos);
			
			if (m_lastSelected == -1)
				m_lastSelected = 0;
			m_crewFile.setCrewData(BGQApp.self.datas.crewManager.getSelectedCrew(m_lastSelected));
			
			if (crewsNumber == 5)
				m_nextBtn.display.skin.visible = true;
		}
	}
	
	private function showCrew(index : Int) : Void
	{
		m_lastSelected = index;
		var crewMember : CrewMember = BGQApp.self.datas.crewManager.getSelectedCrew(index);
		if(crewMember!=null)
			m_crewFile.setCrewData(crewMember);
	}
	
	private function onSelectNext() : Void
	{
		//todo goto next step
		BGQApp.self.screenModule.goToScreen(ScreenName.shipScreenSelection);
	}
	
}