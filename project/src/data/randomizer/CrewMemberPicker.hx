package data.randomizer;
import data.crew.CrewMember;
import data.crew.dna.Dna;
import data.crew.personality.Personality;
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
	
	private var m_personalityPicker : PersonalityPicker;
	
	private var m_professionPicker : ProfessionPicker;
	
	private var m_dnaPicker : DnaPicker;
	

	public function new(nameFile : String, firstNamefile : String) 
	{
		m_crewModelPicker = new CrewModelPicker();
		m_namePicker = new NamePicker(nameFile, firstNamefile);
		m_professionPicker = new ProfessionPicker();
		m_personalityPicker = new PersonalityPicker();
		m_dnaPicker = new DnaPicker();
	}
	
	public function generate() : CrewMember
	{
		var model : String = m_crewModelPicker.generate();
		var name : String = m_namePicker.pickRandomName();
		var firstname : String = m_namePicker.pickRandomfirstName();
		var id : String = UniqueId.generate(10, "0123456789") + "-" + UniqueId.generate(4, "abcdefghijklmnopkrstuvw");
		var personality : Profession = m_professionPicker.generate();
		var goodness : Personality = null;
		var defect : Personality = null;
		var dna : Dna = null;
		
		
		switch(Std.random(3))
		{
			case 1 :
			{
				if (Std.random(2) == 0)
					goodness = m_personalityPicker.generateGoodNess();
				else
					defect = m_personalityPicker.generateDefect();
			}
			case 2 :
			{
				//todo, check incompatibility
				goodness = m_personalityPicker.generateGoodNess();
				defect = m_personalityPicker.generateDefect();
			}
		}
		
		if (Math.random() < 0.03)
			dna = m_dnaPicker.generate();
		
		
		return new CrewMember(model, name, firstname, id, personality, goodness, defect, dna);
	}
	
}