package input.behaviour;

import core.entity.Entity;
import input.behaviour.impl.DragBehaviour;
import input.data.PointerData;
import openfl.display.DisplayObject;
import openfl.display.InteractiveObject;
import openfl.display.Stage;
import src.BGQApp;
import standard.components.input.utils.EntityPointerBehaviour;
import standard.components.space2d.Position2D;
import standard.group.graphic.location.LocationGroup;
import standard.module.graphic.LocationModule;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class SlideEntity extends EntityPointerBehaviour 
{
	
	private var m_locModuleRef : LocationModule;
	
	private var m_locGroupRef : LocationGroup;
	
	
	private var m_initSkinPosition : Vector2D;
	
	private var m_startPointerPosition : Vector2D;
	
	private var m_startPointerWorldPosition : Vector2D;
	
	private var m_lastPointerWorldPosition : Vector2D;
	
	public var speedDetected(default,null) : Float;
	
	
	public function new(locModuleRef : LocationModule) 
	{
		super();
		
		m_locModuleRef = locModuleRef;
		m_locGroupRef = null;
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
		
		
		m_startPointerPosition = new Vector2D();
		m_startPointerWorldPosition = new Vector2D();
		m_lastPointerWorldPosition = new Vector2D();
		
		m_initSkinPosition = new Vector2D();
		m_initSkinPosition.copy(m_locGroupRef.position.position2d.anchor);
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
		m_startPointerPosition.copy(pos.localPosition);
		m_startPointerWorldPosition.copy(pos.worldPosition);
		m_lastPointerWorldPosition.copy(m_startPointerWorldPosition);
		this.speedDetected = 0.0;
	}
	
	private function onSlide(pos : PointerData) : Void
	{
		var deltaPixel : Float = (pos.worldPosition.x - m_lastPointerWorldPosition.x);
		//m_locGroupRef.display;
		deltaPixel /= getScaleRatio();
		this.speedDetected = deltaPixel / BGQApp.self.app.tick.lastDelta;
		m_lastPointerWorldPosition.copy(pos.worldPosition);
		m_locGroupRef.position.position2d.anchor.x += deltaPixel;
	}
	
	private function onEndSlide(pos : PointerData) : Void
	{
		m_locGroupRef.position.position2d.anchor.copy(m_initSkinPosition);
	}
	
}