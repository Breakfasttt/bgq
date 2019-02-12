package data.crew.profession;
import data.crew.CrewMember;

/**
 * ...
 * @author Breakyt
 */
class Profession 
{

	public var eProfessionName(default, null) : EProfessionName;
	
	public function new(eProfName : EProfessionName) 
	{
		this.eProfessionName = eProfName;
	}
	
	public function applyStaticCrewEffect(crewMember : CrewMember) : Void
	{
		trace("Please override applyStaticCrewEffect for " + this.eProfessionName.getName() + " profession");
	}
	
	public function applyStaticShipEffect() : Void
	{
		trace("Please override applyStaticShipEffect for " + this.eProfessionName.getName() + " profession");
	}
	
	public function applyDynamicCrewEffect(crewMember : CrewMember) : Void
	{
		trace("Please override applyDynamicCrewEffect for " + this.eProfessionName.getName() + " profession");
	}
	
	public function applyDynamicShipEffect() : Void
	{
		trace("Please override applyDynamicShipEffect for " + this.eProfessionName.getName() + " profession");
	}
	
}