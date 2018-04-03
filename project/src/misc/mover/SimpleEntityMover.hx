package misc.mover;
import core.entity.Entity;
import standard.components.space2d.Position2D;
import tools.math.Vector2D;
import tools.time.FrameTicker;

/**
 * ...
 * @author Breakyt
 */
class SimpleEntityMover 
{

	private var m_entityRef : Entity;
	
	private var m_position : Position2D;
	
	private var m_cible : Vector2D;
	
	
	private var m_calculVector : Vector2D;
	
	private var m_onEnd : Void->Void;
	
	private var m_startVector : Vector2D;
	
	private var m_speed : Float;
	
	private var m_tickerRef : FrameTicker;
	
	public function new(ticker : FrameTicker) 
	{
		m_cible = new Vector2D();
		m_calculVector = new Vector2D();
		m_startVector = new Vector2D();
		m_tickerRef = ticker;
	}
	
	public function setEntityRef(ent : Entity) : Void
	{
		m_entityRef = ent;
		m_position = m_entityRef.getComponent(Position2D);
	}
	
	public function moveTo(x : Float, y : Float, speed : Float, onEnd : Void->Void) : Void
	{
		m_speed = speed;
		m_onEnd = onEnd;
		if (m_entityRef == null || m_position == null || m_tickerRef == null)
		{
			if(m_onEnd != null)
				onEnd();
			return;
		}
		
		m_cible.set(x, y);
		m_startVector.copy(m_cible).vSubstract( m_position.position2d.anchor);
		m_startVector.normalize();
		m_tickerRef.tick.add(update);
		trace("=== Start ===");
	}
	
	private function update(dt : Float) : Void
	{
		m_calculVector.copy(m_cible).vSubstract( m_position.position2d.anchor);
		m_calculVector.normalize();
		m_calculVector.scale(dt / 1000  * m_speed);
		m_position.position2d.anchor.vAdd(m_calculVector);
		
		m_calculVector.copy(m_cible).vSubstract(m_position.position2d.anchor);
		m_calculVector.normalize();
		
		trace("=======");
		trace("cible = " + m_cible.toString());
		trace("pos = " + m_position.position2d.anchor.toString());
		trace(m_calculVector.toString());
		trace(m_startVector.toString());
		trace("=======");
		
		m_calculVector.vAdd(m_startVector);
		
		if (m_calculVector.isLengthEqual(0.0))
		{
			m_position.position2d.anchor.copy(m_cible);
			m_tickerRef.tick.remove(update);
			
			if (m_onEnd != null)
				m_onEnd();
				
			trace("=== end ===");
		}
	}
}