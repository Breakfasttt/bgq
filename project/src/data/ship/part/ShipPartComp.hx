package data.ship.part;
import core.component.Component;
import data.crew.CrewMember;
import data.ship.types.ShipPartLevel;
import data.ship.types.ShipPartState;
import data.ship.types.ShipPartType;

/**
 * ...
 * @author Breakyt
 */
class ShipPartComp extends Component
{

	public static var shipPartSizeX : Float  = 100.0; 
	public static var shipPartSizeY : Float  = 100.0; 
	
	public var id(default, null) : String;
	
	public var modelId(default, null) : String;
	
	public var nameLocaleKey(default,null) : String;
	
	public var descLocaleKey(default,null) : String;
	
	public var type(default,null) : ShipPartType;
	
	public var baseResourceGeneration(default,null) : Int;
	
	public var baseResourceConsumption(default,null) : Int;
	
	public var state(default,null) : ShipPartState;
	
	public var currentCrew(default,null) : CrewMember;
	
	public var locked(default,null) : Bool;
	
	public var level(default,null) : ShipPartLevel;
	
	public function new(id : String, 
						modelId : String,
						name : String,
						description : String, 
						type : ShipPartType, 
						baseResourceGeneration : Int,
						baseResourceConsumption : Int
						) 
	{
		
		super();
		this.id = id;
		this.modelId = modelId;
		this.nameLocaleKey = name;
		this.descLocaleKey = description;
		this.type = type;
		this.baseResourceGeneration = baseResourceGeneration;
		this.baseResourceConsumption = baseResourceConsumption;
		
		this.state = ShipPartState.intact;
		this.currentCrew = null;
		this.locked = false;
		this.level = ShipPartLevel.basic;
	}
	
}