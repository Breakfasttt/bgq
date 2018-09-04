package data.ship;
import data.ship.part.ShipPartComp;
import lime.math.Vector2;
import openfl.Assets;
import tools.math.Vector2D;
import tools.math.Vector2D;

/**
 * Gére les positions des modules d'un vaisseaux.
 * Prend un Json en entrée.
 * Le vaisseau est un tableau de 12 lignes par 12 colonnes. Les positions sont défini comme suit : 
 * 
 * 
 * @author Breakyt
 */
class ShipTemplate 
{

	public var name(default,null) : String;
	//
	private var m_datas : Dynamic;
	
	private var m_modulesPositions : Map<String, Vector2D>; //module id - position
	
	public function new(jsonData : Dynamic) 
	{
		m_modulesPositions = new Map();
		m_datas = jsonData;
		
		try
		{
			this.name = m_datas.name;
			var length = m_datas.modules.length;
			var module = null;
			for (i  in 0...length)
			{
				module =  m_datas.modules[i];
				
				if (module.id == null || module.position)
					continue;
					
				if(!m_modulesPositions.exists(module.id))
					m_modulesPositions.set(module.id, new Vector2D(module.positionX, module.positionY));
				else
					trace(this.name + " => can't add module : " + module.id + " at position : " + module.positionX);
			}
		}
		catch (e : Dynamic)
		{
			trace("an error occur on ship template : " + e + " abort");
		}
		
	}
	
	public function getPosition(id : String) : Vector2D
	{
		if (!m_modulesPositions.exists(id))
			return null;
		
		return m_modulesPositions.get(id);
	}
	
	
} 