package uiblock;

import assets.model.Model;
import core.Application;
import core.entity.Entity;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.space2d.Depth;
import standard.components.space2d.Scale2D;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
enum EPinState
{
	unlockSelected;
	unlock;
	lock;
}
 
class PinsNav extends UiContainer 
{

	private var m_nbrePin : Int;
	
	private var m_nbreUnlock : Int;
	
	private var m_indexSelected : Int;
	
	private var m_pixelSpace : Float;
	
	private var m_pinsNav : Array<Entity>;
	
	private var m_pinAnimation : Array<Animation>;
	
	private var m_pinScale : Array<Scale2D>;
	
	private var m_pinSize : Float;
	
	public function new(name:String, nbrePin : Int, pixelSpace : Float, depth : Int, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
		this.display = new GameElementDisplay(null);
		this.entity.add(this.display);
		this.entity.add(new Depth(depth));
		this.utilitySize.autoUtilitySize = false;
		m_pinSize = 50.0 * 0.60; // todo hardcode dégeu a enlevé un jour
		
		m_nbrePin = nbrePin;
		m_pixelSpace = pixelSpace;
		m_nbreUnlock = 0;
		m_indexSelected = -1;
		
		this.utilitySize.height = m_pinSize;
		this.utilitySize.width = (m_pinSize-1) * m_nbrePin + (m_nbrePin-2) * m_pixelSpace - 25 *0.60;
		
		this.createElement();
	}
	
	override function createElement():Void 
	{
		m_pinsNav = new Array();
		m_pinAnimation = new Array();
		m_pinScale = new Array();
		var tempPin : Entity = null;
		var anim : Animation = null;
		
		for (i in 0...m_nbrePin)
		{
			tempPin = m_entityFactoryRef.createGameElement(this.entity.name + "::pinNav" + i, this.entity, "pinNav", i, new Anchor(m_pixelSpace * i + 25.0 *0.60, 25.0*0.60, false), Anchor.center, Model.defaultAnim);
			
			if (tempPin == null)
				continue;
			
			m_pinsNav.push(tempPin);
			anim = tempPin.getComponent(Animation);
			anim.useAnimationPivot = false;
			anim.gotoAndStop(EPinState.lock.getIndex());
			m_pinAnimation.push(anim);
			m_pinScale.push(tempPin.getComponent(Scale2D));
			this.add(tempPin);
		}
	}
	
	public function setNbreUnlocked(nbre : Int) : Void
	{
		m_nbreUnlock = nbre;
		
		if (m_nbreUnlock < 0)
			m_nbreUnlock = 0;
			
		if (m_nbreUnlock > m_pinAnimation.length)
			m_nbreUnlock = m_pinAnimation.length; 
		
		for (i in 0...m_pinAnimation.length)
		{
			if(i < m_nbreUnlock)
				m_pinAnimation[i].gotoAndStop(EPinState.unlock.getIndex());
			else
				m_pinAnimation[i].gotoAndStop(EPinState.lock.getIndex());
				
			m_pinScale[i].scale.set(0.30, 0.30);	
		}
		
		if (m_indexSelected >= 0 && m_indexSelected < m_pinAnimation.length)
		{
			m_pinAnimation[m_indexSelected].gotoAndStop(EPinState.unlockSelected.getIndex());
			m_pinScale[m_indexSelected].scale.set(0.60, 0.60);
		}
	}
	
	public function setSelectedIndex(selectedIndex : Int) : Void
	{
		if (m_pinAnimation.length == 0)
			return;
		
		if(selectedIndex >= 0)
			m_indexSelected = selectedIndex % m_nbreUnlock;	
		else
			m_indexSelected = -1;
			
		setNbreUnlocked(m_nbreUnlock);
	}
}