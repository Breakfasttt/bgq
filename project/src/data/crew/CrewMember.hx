package data.crew;
import data.crew.dna.Dna;
import data.crew.personality.Personality;
import data.crew.profession.Profession;

/**
 * ...
 * @author Breakyt
 */
class CrewMember 
{

	public var idTimeLine : Int;
	
	public var crewModelName(default, null) : String;
	
	public var firstname(default, null) : String;
	
	public var name(default, null) : String;
	
	public var uniqueId(default, null) : String;
	
	public var maxHealth(default,null) : Float;
	public var currentHealth : Float;
	
	public var maxStamina(default, null) : Float;
	public var currentStamina : Float;
	
	public var profession(default, null) : Profession;
	
	public var goodNessPersonality(default, null) : Personality; // bon
	public var defectPersonality(default, null) : Personality; // mauvais
	
	public var dna(default, null) : Dna;
	
	public function new(crewModelName : String, firstName : String, name : String, uniqueId : String, profession : Profession, gnPerso : Personality = null, dPerso : Personality = null, dna : Dna = null) 
	{
		this.crewModelName = crewModelName;
		this.firstname = firstName;
		this.name = name;
		this.uniqueId = uniqueId;
		
		this.maxHealth = 100;
		this.currentHealth = this.maxHealth ;
		
		this.maxStamina = 100;
		this.currentStamina = this.maxStamina ;
		
		this.profession = profession;
		this.goodNessPersonality = gnPerso;
		this.defectPersonality = dPerso;
		this.dna = dna;
	}
	
	public function toString() : String
	{
		var result =  "CrewMember : " 	+ this.firstname 
										+ " " + this.name
										+ " " + this.uniqueId
										+ " model : " + this.crewModelName
										+ " H : " + this.currentHealth
										+ "/" + this.maxHealth
										+ " S : " + this.currentStamina
										+ "/" + this.maxStamina
										+ " Prof : " + this.profession.name;
		
		
		if (this.goodNessPersonality != null)
			result += " GNP : " +  this.goodNessPersonality.name;
			
		if (this.defectPersonality != null)
			result += " DP : " +  this.defectPersonality.name;
			
		if (this.dna != null)
			result += " Dna : " +  this.dna.name;
			
		return result;	
	}
	
}