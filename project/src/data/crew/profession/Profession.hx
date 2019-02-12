package data.crew.profession;
import data.crew.CrewMember;

/**
 * ...
 * @author Breakyt
 */
class Profession 
{

	public var eProfessionName(default, null) : EProfessionName;
	
	public var keyName(default, null) : String;
	
	public var maxLevel(default, null) : Int;
	
	public var currentLevel : Int;
	
	public function new(eProfName : EProfessionName, keyName : String, maxLevel : Int = 3, currentLevel : Int = 0) 
	{
		this.eProfessionName = eProfName;
		this.keyName = keyName;
		this.maxLevel = maxLevel;
		this.currentLevel = currentLevel;
	}
	
	public function applyStaticCrewEffect(crewMember : CrewMember) : Void
	{
		trace("Please override applyStaticCrewEffect for " + this.keyName + " profession");
	}
	
	public function applyStaticShipEffect() : Void
	{
		trace("Please override applyStaticShipEffect for " + this.keyName + " profession");
	}
	
	public function applyDynamicCrewEffect(crewMember : CrewMember) : Void
	{
		trace("Please override applyDynamicCrewEffect for " + this.keyName + " profession");
	}
	
	public function applyDynamicShipEffect() : Void
	{
		trace("Please override applyDynamicShipEffect for " + this.keyName + " profession");
	}
	
}