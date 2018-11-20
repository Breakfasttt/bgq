package data.crew;
import data.crew.profession.Profession;
import tools.math.MathUtils;

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
	public var currentHealth(default,null) : Float;
	
	public var maxStamina(default, null) : Float;
	public var currentStamina(default,null) : Float;
	
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
	
	public function addHealth(delta : Float) : Void
	{
		//delta = MathUtils.clamp(delta, 0 100);
		
		this.currentHealth += delta;
		MathUtils.clamp(delta, 0, this.maxHealth);
	}
	
	public function addStamina(delta : Float) : Void
	{
		this.currentStamina += delta;
		MathUtils.clamp(delta, 0, this.maxStamina);	
	}
	
	public inline function isDead() : Bool
	{
		return this.currentHealth <= 0.0;
	}
	
	public inline function isExhausted() : Bool
	{
		return this.currentStamina <= 0.0;
	}
	
	public inline function addMaxHealth(delta : Float) : Void
	{
		this.maxHealth += delta;
	}
	
	public inline function addMaxStamina(delta : Float) : Void
	{
		this.maxStamina += delta;
	}
	
}