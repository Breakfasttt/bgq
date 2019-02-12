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
import standard.utils.uicontainer.impl.Button;
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
	
	private var m_nextStepBtn : LocTextButton;
	
	private var m_nextCrewBtn : Button;
	private var m_previousCrewBtn : Button;
	
	private var m_crewFile : CrewFileUi;
	
	private var m_infos : Entity;
	
	private var m_lastCrewSelected : Int;
	
	private var m_confirmFiredPopup : ConfirmPopup;
	
	private var m_maxCrewNumber : Int;
	
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
		
		m_nextStepBtn = new LocTextButton(this.entity.name + "::nextBtn", m_appRef, m_entityFactoryRef);
		m_nextStepBtn.init("genericBtn", 99, new Anchor(0.90, 0.75), Anchor.center, onSelectNext, null, null, null, 0.8, 0.8);
		m_nextStepBtn.setLoc("crewSummaryShipSelectionBtn");
		m_nextStepBtn.textDisplay.setFont(FontName.scienceFair);
		m_nextStepBtn.textDisplay.setTextColor(0x846248);
		m_nextStepBtn.textDisplay.setFontSize(50);
		m_nextStepBtn.show(false);
		
		m_nextCrewBtn = new Button(this.entity.name + "::nextCrewBtn", m_appRef, m_entityFactoryRef);
		m_nextCrewBtn.init("nextArrowBtn", 11, new Anchor(0.90, 0.50), Anchor.center);
		m_nextCrewBtn.show(true);
		m_nextCrewBtn.btnBehaviour.onSelect = showNextCrewMember;
		
		m_previousCrewBtn = new Button(this.entity.name + "::previousCrewBtn", m_appRef, m_entityFactoryRef);
		m_previousCrewBtn.init("nextArrowBtn", 12, new Anchor(0.10,0.50), Anchor.center, null,null,null,null,-1.0);
		m_previousCrewBtn.show(true);
		m_previousCrewBtn.btnBehaviour.onSelect = showPreviousCrewMember;
		
		
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
		this.add(m_nextStepBtn.entity);
		this.add(m_nextCrewBtn.entity);
		this.add(m_previousCrewBtn.entity);
	}
	
	override function onCustomScreenInit():Void 
	{
		m_maxCrewNumber = BGQApp.self.datas.crewManager.getCurrentCrewNumber();
		m_nextStepBtn.show(false);
		m_lastCrewSelected = -1;
		
		if (m_maxCrewNumber == 0)
		{
			this.remove(m_crewFile.entity);
			this.add(m_infos);
			m_lastCrewSelected = -1;
			this.remove(m_firedBtn.entity);
			m_nextCrewBtn.show(false);
			m_previousCrewBtn.show(false);
		}
		else
		{
			this.add(m_crewFile.entity);
			this.add(m_firedBtn.entity);
			this.remove(m_infos);
			
			m_lastCrewSelected = 0;
			m_crewFile.setCrewData(BGQApp.self.datas.crewManager.getSelectedCrew(m_lastCrewSelected));
			
			if (m_maxCrewNumber > 1)
			{
				m_nextCrewBtn.show(true);
				m_previousCrewBtn.show(true);
			}
			else
			{	
				m_nextCrewBtn.show(false);
				m_previousCrewBtn.show(false);
			}
			
			if (m_maxCrewNumber == 5)
				m_nextStepBtn.show(true);
		}
		
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
		var crewMember : CrewMember = BGQApp.self.datas.crewManager.getSelectedCrew(m_lastCrewSelected);
		BGQApp.self.datas.crewManager.removeToSelected(crewMember);
		
		if(BGQApp.self.datas.crewManager.getCurrentCrewNumber() <= 0)
			m_lastCrewSelected = -1;
		else
			m_lastCrewSelected = 0;
		
		onCustomScreenInit();
	}
	

	private function showNextCrewMember()
	{
		if (m_lastCrewSelected == -1)
			return;
			m_lastCrewSelected++;
		
		if (m_lastCrewSelected >= m_maxCrewNumber)
			m_lastCrewSelected = 0;
			
		showCrew(m_lastCrewSelected);
	}
	
	private function showPreviousCrewMember()
	{
		if (m_lastCrewSelected == -1)
			return;
			
		m_lastCrewSelected--;
		
		if (m_lastCrewSelected < 0)
			m_lastCrewSelected = m_maxCrewNumber;
			
		showCrew(m_lastCrewSelected);
	}
	
	
	private function showCrew(index : Int) : Void
	{
		m_lastCrewSelected = index;
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