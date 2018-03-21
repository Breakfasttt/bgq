package data.crew;

/**
 * ...
 * @author Breakyt
 */
class Crew 
{

	public var firstname(default, null) : String;
	public var name(default, null) : String;
	
	public function new(firstName : String, name : String) 
	{
		this.firstname = firstName;
		this.name = name;
	}
	
}