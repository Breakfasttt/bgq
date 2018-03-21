package data.randomizer;
import data.crew.personality.Personality;

/**
 * ...
 * @author Breakyt
 */
class PersonalityPicker 
{

	public function new() 
	{
		
	}
	
	public function generateGoodNess() : Personality
	{
		//todo
		var random : Int = Std.random(1);
		switch(random)
		{
			default : return new Personality();
		}
	}
	
	public function generateDefect() : Personality
	{
		//todo
		var random : Int = Std.random(1);
		switch(random)
		{
			default : return new Personality();
		}		
	}
	
	
}