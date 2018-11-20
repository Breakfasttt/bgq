package data.randomizer;
import data.crew.profession.Profession;

/**
 * ...
 * @author Breakyt
 */
class ProfessionPicker 
{

	public function new() 
	{
		
	}
	
	public function generate() : Profession
	{
		
		var random : Int = Std.random(1);
		
		switch(random)
		{
			case  0 : return new Profession("wip");
			default : return null;
		}
	}
}