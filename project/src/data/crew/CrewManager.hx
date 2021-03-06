package data.crew;
import data.randomizer.CrewMemberPicker;

/**
 * ...
 * @author Breakyt
 */
class CrewManager 
{

	private var m_maxCrewMember : Int;
	
	private var m_crewMemberPicker : CrewMemberPicker;
	
	private var m_selectedCrew : Array<CrewMember>;
	
	//todo => héros déja revenu d'une mission
	private var m_crewMemberHeroes : Array<CrewMember>;
	
	private var m_selectableCrewMember : Array<CrewMember>;
	
	public function new(maxCrewMember : Int = 5) 
	{
		m_crewMemberPicker = new CrewMemberPicker("datas/nameLibrary/name.txt", "datas/nameLibrary/firstname.txt");
		m_maxCrewMember = maxCrewMember;
		m_selectedCrew = [];
		m_crewMemberHeroes = []; //todo
		m_selectableCrewMember = [];
	}
	
	private function generate5CrewMember() : Void
	{
		for (i in 0...m_maxCrewMember)
			m_selectableCrewMember.push(m_crewMemberPicker.generate());
	}
	
	public function getGeneratedCrewMember() : CrewMember
	{
		
		if (m_selectableCrewMember.length < m_maxCrewMember)
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
	
	public function removeToSelected(crew : CrewMember) : Void
	{
		if (m_selectedCrew != null)
			m_selectedCrew.remove(crew);
	}
	
	public function crewIsFull() : Bool
	{
		return m_selectedCrew.length == m_maxCrewMember;
	}
	
	public function getSelectedCrews() : Array<CrewMember>
	{
		return m_selectedCrew.copy();
	}
	
	public function getCurrentCrewNumber() : Int
	{
		if (m_selectedCrew == null)
			return 0;
		
		return m_selectedCrew.length;
	}
	
	public function getSelectedCrew(index : Int) : CrewMember
	{
		if (index < 0 || index >= m_selectedCrew.length)
			return null;
			
		return m_selectedCrew[index];
	}
	
	public function reset() : Void
	{
		m_selectedCrew = new Array<CrewMember>();
	}
	
	
}