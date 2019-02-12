package data.randomizer;
import data.crew.CrewMember;
import data.crew.profession.Profession;
import tools.math.UniqueId;

/**
 * ...
 * @author Breakyt
 */
class CrewMemberPicker 
{
	
	private var m_crewModelPicker : CrewModelPicker;
	
	private var m_namePicker : NamePicker;
	
	
	private var m_professionPicker : ProfessionPicker;
	
	

	public function new(nameFile : String, firstNamefile : String) 
	{
		m_crewModelPicker = new CrewModelPicker();
		m_namePicker = new NamePicker(nameFile, firstNamefile);
		m_professionPicker = new ProfessionPicker();
	}
	
	public function generate() : CrewMember
	{
		var model : String = m_crewModelPicker.generate();
		var name : String = m_namePicker.pickRandomName();
		var firstname : String = m_namePicker.pickRandomfirstName();
		var id : String = UniqueId.generate(10, "0123456789") + "-" + UniqueId.generate(4, "abcdefghijklmnopkrstuvw");
		var profession : Profession = m_professionPicker.generate();
		
		//todo => enlever le hardcode un jour peut etre
		return new CrewMember(model, firstname, name, id, Std.random(11)+1, Std.random(11)+1, profession);
	}
	
}