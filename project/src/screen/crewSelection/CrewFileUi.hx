package screen.crewSelection;

import core.Application;
import core.entity.Entity;
import data.crew.CrewMember;
import input.behaviour.SlideEntity;
import openfl.text.TextFormatAlign;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.misc.ParentEntity;
import standard.components.space2d.Depth;
import standard.factory.EntityFactory;
import standard.module.graphic.LocationModule;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class CrewFileUi extends UiContainer 
{

	private var m_pointerBehaviours : PointerBehavioursComponent;
	
	private var m_bg : Entity;
	
	private var m_icon : Entity;
	
	private var m_crewMemberRef : CrewMember;
	
	private var m_nameTf: Entity;
	private var m_firstnameTf: Entity;
	private var m_uniqueIdTf: Entity;
	
	private var m_ProfessionTf: Entity;
	
	private var m_gnPersonalityTf: Entity;
	private var m_defectPersonalityTf: Entity;
	
	private var m_dnaTf: Entity;
	
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
		
		m_nameTf = m_entityFactoryRef.createTextField(this.entity.name + "::nameTf", this.entity, "", 1, new Anchor(30,315,false), Anchor.topLeft);
		m_firstnameTf = m_entityFactoryRef.createTextField(this.entity.name + "::firstnameTf", this.entity, "", 2, new Anchor(30,385,false), Anchor.topLeft);
		m_uniqueIdTf = m_entityFactoryRef.createTextField(this.entity.name + "::uniqueId", this.entity, "", 3, new Anchor(30, 455, false), Anchor.topLeft);
		
		m_ProfessionTf = m_entityFactoryRef.createTextField(this.entity.name + "::professionTf", this.entity, "", 4, new Anchor(400, 30, false), Anchor.topLeft);
		
		m_gnPersonalityTf = m_entityFactoryRef.createTextField(this.entity.name + "::gnPersonalityTf", this.entity, "", 5, new Anchor(400, 160, false), Anchor.topLeft);
		m_defectPersonalityTf = m_entityFactoryRef.createTextField(this.entity.name + "::defectPersonalityTf", this.entity, "", 6, new Anchor(400, 230, false), Anchor.topLeft);
		
		m_dnaTf = m_entityFactoryRef.createTextField(this.entity.name + "::dnaTf", this.entity, "Nom : ", 7, new Anchor(400, 380, false), Anchor.topLeft);
		
		applyTextFormat(m_nameTf);
		applyTextFormat(m_firstnameTf);
		applyTextFormat(m_uniqueIdTf);
		applyTextFormat(m_ProfessionTf);
		applyTextFormat(m_gnPersonalityTf);
		applyTextFormat(m_defectPersonalityTf);
		applyTextFormat(m_dnaTf);
		
		resetField();
		
		this.add(m_bg);
		this.add(m_nameTf);
		this.add(m_firstnameTf);
		this.add(m_uniqueIdTf);
		this.add(m_ProfessionTf);
		this.add(m_gnPersonalityTf);
		this.add(m_defectPersonalityTf);
		this.add(m_dnaTf);
	}
	
	private function applyTextFormat(entity : Entity) : Void
	{
		var td : TextDisplay = entity.getComponent(TextDisplay);
		
		if (td == null)
			return;
			
		td.setFont(FontName.scienceFair);
		td.setFontSize(22);
		td.setTextColor(0xF2F2F2);
		td.setAlignment(TextFormatAlign.LEFT);
		td.setSize(357, 50);
		td.setMiscProperties(false, false, false, false, false, false);
	}
	
	private function setText(entity : Entity, text : String) : Void
	{
		var td : TextDisplay = entity.getComponent(TextDisplay);
		
		if (td == null)
			return;
			
		td.text.text = text;
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
		this.setText(m_ProfessionTf, "Profession : Inconnu");
		this.setText(m_gnPersonalityTf, "Qualité : Inconnu");
		this.setText(m_defectPersonalityTf, "Imperfection : Inconnu");
		this.setText(m_dnaTf, "Gène : Inconnu");		
	}
	
	private function applyCrewValue() : Void
	{
		this.setText(m_nameTf, "Nom : " + m_crewMemberRef.name);
		this.setText(m_firstnameTf, "Prénom : " + m_crewMemberRef.firstname);
		this.setText(m_uniqueIdTf, "Id : " + m_crewMemberRef.uniqueId);
		
		this.setText(m_ProfessionTf, "Profession : " +  m_crewMemberRef.profession.name);
		
		if (m_crewMemberRef.goodNessPersonality != null)
			this.setText(m_gnPersonalityTf, "Qualité : " +   m_crewMemberRef.goodNessPersonality.name);
		else
			this.setText(m_gnPersonalityTf, "Qualité : aucune");
			
		if (m_crewMemberRef.defectPersonality != null)
			this.setText(m_defectPersonalityTf, "Imperfection : " +  m_crewMemberRef.defectPersonality.name);
		else
			this.setText(m_defectPersonalityTf, "défaut : aucun");
			
		if (m_crewMemberRef.dna != null)
			this.setText(m_dnaTf, "Gène : " +  m_crewMemberRef.dna.name);
		else
			this.setText(m_dnaTf, "Gène : Aucun");
			
	}
}