package data.randomizer;
import data.crew.profession.EProfessionName;
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
		
		var random : Int = Std.random(Type.allEnums(EProfessionName).length-1) + 1;
		var randEnum : EProfessionName = Type.createEnumIndex(EProfessionName, random);
		return new Profession(randEnum); //Todo, corrigé ça
	}
}