package data;
import data.crew.CrewManager;

/**
 * ...
 * @author Breakyt
 */
class DataManager 
{

	public var crewManager(default,null) : CrewManager;
	
	public function new() 
	{
		this.crewManager = new CrewManager();
	}
	
}