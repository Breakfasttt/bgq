package misc.transition;

import flash.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import standard.components.graphic.display.Display;
import standard.components.graphic.transition.impl.EntityTransition;
import standard.components.space2d.UtilitySize2D;
import tools.misc.Color;

/**
 * ...
 * @author Breakyt
 */
class FadeTransition extends EntityTransition 
{

	private var m_shadeMask : Sprite;
	
	private var m_display : Display;
	
	private var m_utilitySize : UtilitySize2D;
	
	private var m_fromAlpha : Float;
	
	private var m_toAlpha : Float;
	
	private var m_alphaPerSecond : Float;
	
	private var m_sens : Float;
	
	public function new(fromAlpha : Float = 0.0, toAlpha : Float = 1.0, alphaPerSecond : Float = 0.5) 
	{
		super();
		
		m_fromAlpha = fromAlpha;
		m_toAlpha = toAlpha;
		m_alphaPerSecond = alphaPerSecond;
		m_sens = m_fromAlpha < m_toAlpha ? 1.0 : -1.0;
	}
	
	override public function start():Void 
	{
		if (this.m_entityRef == null)
		{
			end();
			return;
		}
		
		m_display = m_entityRef.getComponent(Display);
		
		if (m_display == null)
		{
			end();
			return;
		}
			
		m_utilitySize = m_entityRef.getComponent(UtilitySize2D);
		if (m_utilitySize == null)
			m_utilitySize = new UtilitySize2D(m_display.skin.width / m_display.skin.scaleX ,  m_display.skin.height / m_display.skin.scaleY);
		
		m_shadeMask = new Sprite();
		m_shadeMask.graphics.beginFill(Color.black);
		m_shadeMask.graphics.drawRect(0, 0, Math.round(m_utilitySize.width), Math.round(m_utilitySize.height));
		m_shadeMask.graphics.endFill();
		m_shadeMask.alpha = m_fromAlpha;
		this.onTransition = true;
		this.started.dispatch();
	}
	
	override public function update(dt:Float):Void 
	{
		if (!this.onTransition)
			return;
			
		this.m_display.skin.addChild(m_shadeMask);
		m_shadeMask.alpha += m_alphaPerSecond * dt/1000 * m_sens;
		
		
		if (m_sens > 0.0)
		{
			if (m_shadeMask.alpha >= m_toAlpha)
				end();
		}
		else if ( m_sens < 0.0)
		{
			if (m_shadeMask.alpha <= m_toAlpha)
				end();
		}
	}
	
	override function end():Void 
	{
		m_shadeMask.alpha = m_toAlpha;
		this.onTransition = false;
		this.finished.dispatch();
	}
	
	
	
}