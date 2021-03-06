package screen.crewSelection;

import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import input.behaviour.SlideEntity;
import openfl.text.TextFormatAlign;
import src.misc.name.FontName;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.localization.Localization;
import standard.components.misc.ParentEntity;
import standard.components.space2d.Depth;
import standard.components.space2d.Scale2D;
import standard.factory.EntityFactory;
import standard.module.graphic.LocationModule;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;
import uiblock.CrewMemberSkin;

/**
 * ...
 * @author Breakyt
 */
class CrewFileUi extends UiContainer 
{

	private var m_pointerBehaviours : PointerBehavioursComponent;
	
	private var m_bg : Entity;
	
	private var m_crewSkin : CrewMemberSkin;
	
	private var m_crewMemberRef : CrewMember;
	
	private var m_nameTf: Entity;
	private var m_firstnameTf: Entity;
	private var m_uniqueIdTf: Entity;
	
	private var m_ProfessionTf: Entity;
	private var m_ProfessionDescTf: Entity;
	
	public var slider(default,null) : SlideEntity;

	public function new(name:String, appRef:Application, entityFactory:EntityFactory, parentEntity : Entity, depth : Float) 
	{
		super(name, appRef, entityFactory);
		this.display = new GameElementDisplay(null);
		
		this.entity.add(this.display);
		this.entity.add(new ParentEntity(parentEntity));
		this.entity.add(new Depth(depth));
		
		m_pointerBehaviours = new PointerBehavioursComponent();
		this.entity.add(m_pointerBehaviours);
		this.slider = null;
		
		createElement();
	}
	
	public function initSlideBehaviour(distToConfirm : Float, leftValidXpos : Float, rightValidXpos : Float) : Void
	{
		this.slider = new SlideEntity(m_appRef, distToConfirm, leftValidXpos, rightValidXpos);
		m_pointerBehaviours.addBehaviour(this.slider, 0);
	}
	
	override function createElement():Void 
	{
		m_bg = m_entityFactoryRef.createGameElement(this.entity.name + "::BG", this.entity, "crewfile", 0, Anchor.topLeft, Anchor.topLeft);
		
		m_nameTf = m_entityFactoryRef.createTextField(this.entity.name + "::nameTf", this.entity, "", 1, new Anchor(357,30,false), Anchor.topLeft);
		m_firstnameTf = m_entityFactoryRef.createTextField(this.entity.name + "::firstnameTf", this.entity, "", 2, new Anchor(357,130,false), Anchor.topLeft);
		m_uniqueIdTf = m_entityFactoryRef.createTextField(this.entity.name + "::uniqueId", this.entity, "", 3, new Anchor(357, 230, false), Anchor.topLeft);
		
		m_ProfessionTf = m_entityFactoryRef.createLocTextField(this.entity.name + "::professionTf", this.entity, "", null, 4, new Anchor(30, 320, false), Anchor.topLeft);
		m_ProfessionDescTf = m_entityFactoryRef.createLocTextField(this.entity.name + "::professionDescTf", this.entity, "", null, 4, new Anchor(30, 395, false), Anchor.topLeft);
		
		m_crewSkin = new CrewMemberSkin(this.entity.name + ":CrewSkin", this.m_appRef, this.m_entityFactoryRef,5);
		//m_crewSkin.display.skin.visible = true;
		m_crewSkin.position.position2d.ratioMode = false;
		m_crewSkin.position.position2d.setValue(30, 30);
		
		applyTextFormat(m_nameTf);
		applyTextFormat(m_firstnameTf);
		applyTextFormat(m_uniqueIdTf);
		applyTextFormat(m_ProfessionTf);
		applyTextFormat(m_ProfessionDescTf, true);
		
		resetField();
		
		this.add(m_bg);
		this.add(m_nameTf);
		this.add(m_firstnameTf);
		this.add(m_uniqueIdTf);
		this.add(m_ProfessionTf);
		this.add(m_ProfessionDescTf);
		this.add(m_crewSkin.entity);
	}
	
	private function applyTextFormat(entity : Entity, desc : Bool = false) : Void
	{
		var td : TextDisplay = entity.getComponent(TextDisplay);
		
		if (td == null)
			return;
			
		td.setFont(FontName.scienceFair);
		td.setFontSize(30);
		td.setTextColor(0x002B36);
		td.setAlignment(TextFormatAlign.LEFT);
		
		if (desc)
		{
			td.setSize(722, 170);
			td.setMiscProperties(false, true, true, false, false, false);
		}
		else
		{
			td.setSize(357, 50);
			td.setMiscProperties(false, false, false, false, false, false);
		}
		
	}
	
	private function setText(entity : Entity, text : String) : Void
	{
		
		var loc : Localization = entity.getComponent(Localization);
		
		if (loc == null)
		{
			var td : TextDisplay = entity.getComponent(TextDisplay);
			if(td == null)
				return;
			td.text.text = text;
			return;
		}
			
		loc.set(text);
	}
	
	public function setCrewData(crewMember : CrewMember) : Void
	{
		this.m_crewMemberRef = crewMember;
		this.resetField();
		
		if (this.m_crewMemberRef != null)
			this.applyCrewValue();
	}
	
	
	private function resetField() : Void
	{
		this.setText(m_nameTf, "Nom :  Inconnu");
		this.setText(m_firstnameTf, "Prénom : Inconnu" );
		this.setText(m_uniqueIdTf, "Id : Inconnu");
		
		this.setText(m_ProfessionTf, "unknow");		
	}
	
	private function applyCrewValue() : Void
	{
		this.setText(m_nameTf, "Nom : " + m_crewMemberRef.name);
		this.setText(m_firstnameTf, "Prénom : " + m_crewMemberRef.firstname);
		this.setText(m_uniqueIdTf, "Id : " + m_crewMemberRef.uniqueId);
		
		var keyProfTitle : String = m_crewMemberRef.profession.eProfessionName.getName() + "_title";
		var keyProfDesc : String = m_crewMemberRef.profession.eProfessionName.getName() + "_desc";
		
		this.setText(m_ProfessionTf, keyProfTitle); //m_crewMemberRef.profession.keyName);
		this.setText(m_ProfessionDescTf, keyProfDesc);
		
		//this.m_crewSkin.display.skin.visible = true;
		this.m_crewSkin.set(m_crewMemberRef.bodyId, m_crewMemberRef.eyesId, m_crewMemberRef.worksId);
		
	}
}