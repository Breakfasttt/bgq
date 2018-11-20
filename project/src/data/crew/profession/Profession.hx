package data.crew.profession;

/**
 * ...
 * @author Breakyt
 */
class Profession 
{

	public var keyName(default, null) : String;
	
	public var maxLevel(default, null) : Int;
	
	public var currentLevel : Int;
	
	public function new(keyName : String, maxLevel : Int = 3, currentLevel : Int = 0) 
	{
		this.keyName = keyName;
		this.maxLevel = maxLevel;
		this.currentLevel = currentLevel;
	}
	
	
	public function applyEffect() : Void
	{
		//todo
	}
	
}