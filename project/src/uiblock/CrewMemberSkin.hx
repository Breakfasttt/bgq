package uiblock;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.space2d.Depth;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;
import tools.math.MathUtils;

/**
 * ...
 * @author Breakyt
 */
class CrewMemberSkin extends UiContainer 
{
	private static var m_iconSize : Float = 250.0;
	
	private var m_body : Entity;
	
	private var m_eyes : Entity;
	
	private var m_works : Entity;
	
	private var m_bodyAnimation : Animation;
	
	private var m_eyesAnimation : Animation;
	
	private var m_worksAnimation : Animation;
	
	private var m_bodyId : Int;
	
	private var m_eyesId : Int;
	
	private var m_worksId : Int;
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory, depth : Float) 
	{
		super(name, appRef, entityFactory);
		
		this.display = new GameElementDisplay(null);
		this.entity.add(this.display);
		this.entity.add(new Depth(depth));
		this.utilitySize.autoUtilitySize = false;
		this.utilitySize.height = m_iconSize;
		this.utilitySize.width = m_iconSize;
		
		this.createElement();
	}
	
	override function createElement():Void 
	{
		m_body = m_entityFactoryRef.createGameElement(this.entity.name + "::body", this.entity, "bodyTimeline", 0, Anchor.topLeft, Anchor.topLeft, Model.defaultAnim);
		m_eyes = m_entityFactoryRef.createGameElement(this.entity.name + "::eyes", this.entity, "eyesTimeline", 1, Anchor.topLeft, Anchor.topLeft, Model.defaultAnim);
		m_works = m_entityFactoryRef.createGameElement(this.entity.name + "::works", this.entity, "workTimeLine", 2, Anchor.topLeft, Anchor.topLeft, Model.defaultAnim);
		
		m_bodyAnimation = m_body.getComponent(Animation);
		m_eyesAnimation = m_eyes.getComponent(Animation);
		m_worksAnimation = m_works.getComponent(Animation);

		m_body.getComponent(UtilitySize2D).autoUtilitySize = false;
		m_body.getComponent(UtilitySize2D).width = m_iconSize;
		m_body.getComponent(UtilitySize2D).height = m_iconSize;
		
		m_eyes.getComponent(UtilitySize2D).autoUtilitySize = false;
		m_eyes.getComponent(UtilitySize2D).width = m_iconSize;
		m_eyes.getComponent(UtilitySize2D).height = m_iconSize;
		
		m_works.getComponent(UtilitySize2D).autoUtilitySize = false;
		m_works.getComponent(UtilitySize2D).width = m_iconSize;
		m_works.getComponent(UtilitySize2D).height = m_iconSize;
		
		m_bodyAnimation.useAnimationPivot = false;
		m_eyesAnimation.useAnimationPivot = false;
		m_worksAnimation.useAnimationPivot = false;
		
		set(0, 0, 0);
		
		this.add(m_body);
		this.add(m_eyes);
		this.add(m_works);
		
	}
	
	public function set(bodyId : Int, eyesId : Int, worksId : Int) : Void
	{
		this.setBody(bodyId);
		this.setEyes(eyesId);
		this.setWork(worksId);
	}
	
	public function setBody(id : Int) : Void
	{
		if (m_bodyAnimation == null)
			return;
			
		m_bodyId = MathUtils.intClamp(id, 0, m_bodyAnimation.currentMaxFrame);
		m_bodyAnimation.gotoAndStop(m_bodyId);
	}
	
	public function setEyes(id : Int) : Void
	{
		if (m_eyesAnimation == null)
			return;
			
		m_eyesId= MathUtils.intClamp(id, 0, m_eyesAnimation.currentMaxFrame);
		m_eyesAnimation.gotoAndStop(m_eyesId);
	}
	
	public function setWork(id : Int) : Void
	{
		if (m_worksAnimation == null)
			return;
			
		m_worksId= MathUtils.intClamp(id, 0, m_worksAnimation.currentMaxFrame);
		m_worksAnimation.gotoAndStop(m_worksId);
	}
	
}