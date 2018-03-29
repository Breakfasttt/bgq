package data.crew;
import data.randomizer.CrewMemberPicker;

/**
 * ...
 * @author Breakyt
 */
class CrewManager 
{

	private var m_crewMemberPicker : CrewMemberPicker;
	
	private var m_selectedCrew : Array<CrewMember>;
	
	//todo
	private var m_crewMemberHeroes : Array<CrewMember>;
	
	private var m_selectableCrewMember : Array<CrewMember>;
	
	public function new() 
	{
		m_crewMemberPicker = new CrewMemberPicker("datas/name.txt", "datas/firstname.txt");
		m_selectedCrew = [];
		m_crewMemberHeroes = []; //todo
		m_selectableCrewMember = [];
	}
	
	private function generate5CrewMember() : Void
	{
		for (i in 0...5)
			m_selectableCrewMember.push(m_crewMemberPicker.generate());
	}
	
	public function getGeneratedCrewMember() : CrewMember
	{
		
		if (m_selectableCrewMember.length < 5)
			generate5CrewMember();
			
		var result : CrewMember = 	m_selectableCrewMember.shift();
		m_selectableCrewMember.push(m_crewMemberPicker.generate());
		return result;
	}
	
	public function addToSelected(crew : CrewMember) : Void
	{
		if (m_selectedCrew.length < 5 && !Lambda.has(m_selectedCrew, crew))
			m_selectedCrew.push(crew);
		else
			trace("can't add this crew because to many crew or already added : " + crew);
	}
	
	public function crewIsFull() : Bool
	{
		return m_selectedCrew.length == 5;
	}
	
	
}