package input.behaviour;

import core.Application;
import core.entity.Entity;
import input.behaviour.impl.DragBehaviour;
import input.data.PointerData;
import openfl.display.DisplayObject;
import openfl.display.Stage;
import standard.components.input.utils.EntityPointerBehaviour;
import standard.group.graphic.location.LocationGroup;
import standard.module.graphic.LocationModule;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class SlideEntity extends EntityPointerBehaviour 
{
	
	private var m_appRef : Application;
	
	private var m_locModuleRef : LocationModule;
	
	private var m_locGroupRef : LocationGroup;
	
	private var m_initSkinPosition : Vector2D;
	
	private var m_startPointerPosition : Vector2D;
	
	private var m_startPointerWorldPosition : Vector2D;
	
	private var m_lastPointerWorldPosition : Vector2D;
	
	private var m_currentXPosition : Vector2D;
	
	private var m_distanceToStartToConfirm : Float; //  pixel
	
	private var m_backToInit : Bool;
	
	private var m_validAnim : Bool;
	
	private var m_calculVector : Vector2D;
	
	private var m_atLeftWhenAnimBegin : Bool;
	
	private var m_angleRotation : Float;
	
	private var m_backSpeed : Float;
	
	private var m_speedConfirm : Float;
	
	private var m_leftXValidPosition : Float;
	private var m_rightXValidPosition : Float;
	
	public var speedDetected(default, null) : Float;
	
	public var confirmRatio(default, null) : Float; 
	
	public var slideSens(default, null) : Float;
	
	public var enable(default, set) : Bool ;
	
	public var onStartSlideCallback : Void->Void;
	public var onSlideCallback : Void->Void;
	public var backToInitCallback : Void->Void;
	public var startConfirmAnimCallback : Void->Void;
	public var onValidPosition : Float->Void;
	
	
	public function new(appRef : Application, distToConfirm : Float, leftValidPosition : Float, rightValidPosition : Float, angleRotation : Float = 5.0, backSpeed : Float = 4000.0, speedConfirmation : Float = 500.0) 
	{
		super();
		
		m_appRef = appRef;
		m_locModuleRef = m_appRef.modManager.getModule(LocationModule);
		m_locGroupRef = null;
		m_distanceToStartToConfirm = distToConfirm;
		m_leftXValidPosition = leftValidPosition;
		m_rightXValidPosition = rightValidPosition;
		m_backSpeed = backSpeed;
		m_speedConfirm = speedConfirmation;
		this.speedDetected = 0.0;
		this.confirmRatio = 0.0;
		this.slideSens = 0.0;
		m_angleRotation = angleRotation;
		m_calculVector = new Vector2D();
		m_backToInit = false;
		m_validAnim = false;
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		if (m_entityRef == null)
			return;
			
		if (m_locModuleRef == null)
			return;
			
		m_locGroupRef = m_locModuleRef.getEntityLocation(m_entityRef);
		
		if (m_locGroupRef == null)
			return;
			
		if (m_locGroupRef.display.skin == null)
			return;
				
		m_pointerBehaviour = new DragBehaviour(m_locGroupRef.display.skin);
		cast (m_pointerBehaviour, DragBehaviour).startCb = onStartSlide;
		cast (m_pointerBehaviour, DragBehaviour).moveCb = onSlide;
		cast (m_pointerBehaviour, DragBehaviour).endCb = onEndSlide;
		enable = true;
		
		m_startPointerPosition = new Vector2D();
		m_startPointerWorldPosition = new Vector2D();
		m_lastPointerWorldPosition = new Vector2D();
		m_currentXPosition = new Vector2D();
		
		m_initSkinPosition = new Vector2D();
		m_initSkinPosition.copy(m_locGroupRef.position.position2d.anchor);
		m_currentXPosition.copy(m_initSkinPosition);
	}
	
	//todo imprrove this ? 
	private function getScaleRatio() : Float
	{
		var result : Float = m_locGroupRef.display.skin.scaleX;
		
		var parent : DisplayObject = m_locGroupRef.display.skin.parent;
		
		while (parent != null)
		{
			result *= parent.scaleX;
			parent = parent.parent;
			
			if (Std.is(parent, Stage))
				parent = null;
		}
		
		return result;
	}
	
	private function onStartSlide(pos : PointerData) : Void
	{
		if (m_backToInit || m_validAnim)
			return;
		
		m_startPointerPosition.copy(pos.localPosition);
		m_startPointerWorldPosition.copy(pos.worldPosition);
		m_lastPointerWorldPosition.copy(m_startPointerWorldPosition);
		this.speedDetected = 0.0;
		rotateEntity();
		
		if (onStartSlideCallback != null)
			onStartSlideCallback();
		
	}
	
	private function onSlide(pos : PointerData) : Void
	{
		var deltaPixel : Float = (pos.worldPosition.x - m_lastPointerWorldPosition.x);
		//m_locGroupRef.display;
		deltaPixel /= getScaleRatio();
		this.speedDetected = Math.abs(deltaPixel / (m_appRef.tick.lastDelta/1000));
		m_lastPointerWorldPosition.copy(pos.worldPosition);
		m_currentXPosition.x += deltaPixel;
		rotateEntity();
		
		if (onSlideCallback != null)
			onSlideCallback();
	}
	
	private function onEndSlide(pos : PointerData) : Void
	{
		if ( (m_speedConfirm <= this.speedDetected && this.confirmRatio >= 0.7) || this.confirmRatio >= 1.0)
		{
			m_validAnim = true;
			m_calculVector.copy(m_currentXPosition).vSubstract(m_initSkinPosition);
			m_atLeftWhenAnimBegin = m_calculVector.x < 0.0;
			m_appRef.tick.tick.add(goToValidPosition);
			
			if (startConfirmAnimCallback != null)
				startConfirmAnimCallback();
			
		}
		else
		{
			m_backToInit = true;
			m_calculVector.copy(m_currentXPosition).vSubstract(m_initSkinPosition);
			m_atLeftWhenAnimBegin = m_calculVector.x < 0.0;
			m_appRef.tick.tick.add(onBackToInit);
		}
	}
	
	private function onBackToInit(dt : Float) : Void
	{
		m_calculVector.copy(m_initSkinPosition).vSubstract(m_currentXPosition);
		m_calculVector.normalize();
		m_currentXPosition.x += m_calculVector.x * dt/1000 * m_backSpeed;
		m_calculVector.copy(m_initSkinPosition).vSubstract(m_currentXPosition);
		
		if ((m_atLeftWhenAnimBegin != (m_calculVector.x > 0)))
		{
			m_backToInit = false;
			m_appRef.tick.tick.remove(onBackToInit);
			m_currentXPosition.copy(m_initSkinPosition);
		}
		
		rotateEntity();
		
		
		if (backToInitCallback != null)
			backToInitCallback();
	}
	
	
	private function rotateEntity() : Void
	{
		m_calculVector.copy(m_currentXPosition).vSubstract(m_initSkinPosition);
		this.slideSens = m_calculVector.x < 0 ? -1.0 : 1.0;
		
		if (m_calculVector.x == 0.0)
			this.slideSens = 0.0;
		
		m_calculVector.rotate(m_angleRotation * this.slideSens);
		m_locGroupRef.position.position2d.anchor.copy(m_initSkinPosition);
		m_locGroupRef.position.position2d.anchor.vAdd(m_calculVector);
		
		
		this.confirmRatio = m_calculVector.length() / m_distanceToStartToConfirm;
		if (m_locGroupRef.rotation != null)
			m_locGroupRef.rotation.angle = m_angleRotation * this.confirmRatio * this.slideSens;
	}
	
	
	private function goToValidPosition(dt : Float) : Void
	{
		m_calculVector.copy(m_currentXPosition).vSubstract(m_initSkinPosition);
		m_calculVector.normalize();
		m_calculVector.scale(dt / 1000 * m_backSpeed);
		m_locGroupRef.position.position2d.anchor.vAdd(m_calculVector);
		
		var isValid : Float = 0;
		
		if (m_locGroupRef.position.position2d.anchor.x < m_leftXValidPosition)
		{
			isValid = -1;
		}
		else if(m_locGroupRef.position.position2d.anchor.x > m_rightXValidPosition)
		{
			isValid = 1;
		}
		
		if (isValid != 0.0)
		{
			m_validAnim = false;
			m_appRef.tick.tick.remove(goToValidPosition); // just in case
			reinitPosition();
			
			if(this.onValidPosition != null)
				this.onValidPosition(isValid);
		}
	}
	
	public function reinitPosition() : Void
	{
		m_backToInit = false;
		m_validAnim = false;
		this.enable = true;
		m_appRef.tick.tick.remove(onBackToInit); // just in case
		m_appRef.tick.tick.remove(goToValidPosition); // just in case
		m_currentXPosition.copy(m_initSkinPosition);
		rotateEntity();
	}
	
	function set_enable(value:Bool):Bool 
	{
		enable = value;
		
		if (this.m_pointerBehaviour != null)
			this.m_pointerBehaviour.enable = enable;
			
		return enable;
	}
	
}