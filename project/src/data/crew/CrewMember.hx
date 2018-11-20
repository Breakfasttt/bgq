package data.crew;
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
	
	
	public function new(crewModelName : String, firstName : String, name : String, uniqueId : String, profession : Profession) 
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
										+ " Prof : " + this.profession.keyName;
		return result;	
	}
	
}