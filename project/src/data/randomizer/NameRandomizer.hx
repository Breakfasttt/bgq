package data.randomizer;
import openfl.Assets;

/**
 * Only for debug
 * @author Breakyt
 */
class NameRandomizer 
{
	
	private var m_rawDataFirstName : String;
	private var m_rawDataName : String;
	
	private var m_firstNameProba : Map<String, Map<String, Int>>;
	private var m_NameProba : Map<String, Map<String, Int>>;
	
	public function new ()
	{
		
	}
	
	public function init(firstNameFile : String, nameFile : String, NickName : String) : Void
	{
		m_rawDataFirstName = Assets.getText(firstNameFile);
		//m_rawDataName = Assets.getText(nameFile);
		
		m_firstNameProba = loadProbaMap(m_rawDataFirstName);
		//loadProbaMap(m_NameProba, m_rawDataName);
	}
	
	
	private function loadProbaMap(rawData : String) : Map<String, Map<String,Int>>
	{
		rawData = rawData.toLowerCase();
		var datas : Array<String> = rawData.split("\r\n");
		var probaMap = new Map();
		
		for (data in datas)
		{
			for (i in 0...data.length)
			{
				var letter : String = data.charAt(i);
				
				if (!probaMap.exists(letter))
					probaMap.set(letter, new Map());
					
				var map : Map<String,Int> = probaMap.get(letter);
				
				incrementeMap(map, "total");
				
				if(i == 0)
					incrementeMap(map, "firstcharacter");
				
				if (i + 1 >= data.length)
					incrementeMap(map, "end");
				else
					incrementeMap(map, data.charAt(i + 1));
			}
		}
		
		return probaMap;
	}
	
	private function incrementeMap(map : Map<String, Int>, key : String)
	{
		if (!map.exists(key))
			map.set(key, 1);
		else
		{
			var value : Int = map.get(key) + 1;
			map.set(key, value);	
		}
	}
	
	
	private function pickLetter(map : Map<String, Map<String,Int>>, reference : String, withEnd : Bool) : String
	{
		if (map == null)
			return null;
			
		var probaArray : Array<Float> = [];
		var characArray : Array<String> = [];
			
		if (reference == null)
		{
			var totalFirst : Float  = 0;
			var secondMap : Map<String,Int> = null;
			for (key in map.keys())
			{
				secondMap = map.get(key);
				
				if (secondMap.exists("firstcharacter"))
					totalFirst += secondMap.get("firstcharacter");
			}
			
			for (key in map.keys())
			{
				secondMap = map.get(key);
				if (secondMap != null && secondMap.exists("firstcharacter"))
				{
					var lastProba : Float = 0.0;
					
					if(probaArray.length > 0)
						lastProba = probaArray[probaArray.length - 1];
						
					probaArray.push(lastProba + (secondMap.get("firstcharacter") / totalFirst));
					characArray.push(key);
				}
				else
					return continue;
			}
		}
		else
		{
			var secondMap : Map<String,Int> = map.get(reference);
			var endNumber : Int = secondMap.get("end");
			
			if (withEnd)
				endNumber = 0;
			
			if (secondMap != null)
			{
				for (key in secondMap.keys())
				{
					if (!withEnd && key == "end")
						continue;
						
					if (key == "firstcharacter")
						continue;
						
					if (key == "total")
						continue;
					
					var lastProba : Float = 0.0;
					
					if(probaArray.length > 0)
						lastProba = probaArray[probaArray.length - 1];
						
					probaArray.push(lastProba + (secondMap.get(key) / (secondMap.get("total") - endNumber )));
					characArray.push(key);
				}
			}	
		}
		
		if (characArray.length <= 0)
			return null;
			
		var random : Float  = Math.random();
		
		for (i in 0...probaArray.length)
		{
			if (random <= probaArray[i])
				return characArray[i];
		}
		
		return null;
	}
	
	private function generate(map : Map<String, Map<String, Int>>, minLetter : Int = -1, maxLetter : Int = -1) : String
	{
		if (map == null)
			return null;
		
		var result : String = "";
		var nameLength : Int = -1;
		
		if(minLetter > 0 && maxLetter > 0)
			nameLength = Std.random(maxLetter + 1) + minLetter;
			
		var generated : Bool = false;
		var pickedLetter : String = null;
		var withEnd : Bool = false;
		
		while (!generated)
		{
			withEnd = minLetter < 0 ? (result.length > 0) : (result.length >= minLetter);
			
			pickedLetter = this.pickLetter(map, pickedLetter, withEnd);
			
			if (pickedLetter == null)
			{
				trace("An error as occured on firstname generation. Maybe some missing data ? Generation aborted. We return an incomplet name");
				generated = true;
			}
			else if (pickedLetter == "end")
				generated = true;
			else
				result += pickedLetter;
				 
			if (maxLetter > 0 && result.length >= maxLetter)
				generated = true;
		}
		
		
		return result;		
	}
	
	public function generateName() : String
	{
		return generate(m_NameProba);
	}
	
	public function generateFirstName(minLetter : Int = 4, MaxLetter : Int = 10) : String
	{
		return generate(m_firstNameProba, minLetter, MaxLetter);
		return generate(m_NameProba, minLetter, MaxLetter);
	}
	
}