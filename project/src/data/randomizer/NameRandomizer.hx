package data.randomizer;
import haxe.Timer;
import openfl.Assets;

/**
 * Only for debug
 * @author Breakyt
 */
class NameRandomizer 
{
	
	private var m_rawData : String;
	
	private var m_datas : Array<String>;
	
	private var m_alreadyParsed : Array<String>;
	
	private var m_parsePerFrame : Int = 1000;
	
	private var m_parsed : Int = 0;
	
	private var m_firstLetterProba : Array<String>;
	
	private var m_groupProba : Map<String, Array<String>>;
	
	private var m_init : Bool;
	
	private var m_parsingEnded : Void->Void;
	
	public function new ()
	{
		m_init = false;
	}
	
	public function init(wordsLibraryFileName : String, parsingEnded : Void->Void) : Void
	{
		m_init = false;
		m_parsingEnded  = parsingEnded;
		
		m_rawData = Assets.getText(wordsLibraryFileName);
		m_rawData = m_rawData.toLowerCase();
		m_datas = m_rawData.split("\r\n");
		trace("to parse : " + m_datas.length);
		
		m_firstLetterProba = new Array();
		m_groupProba = new Map();
		m_alreadyParsed = new Array();
		
		loadProbaMap();
		
		m_init  = true;
	}
	
	private function keepOneOccurence(arr : Array<String>) :  Array<String>
	{
		var result : Array<String> = [];
		
		for (item in arr)
		{
			if (Lambda.has(result, item))
				continue;
				
			
			result.push(item);
		}
		
		return result;
	}
	
	
	private function loadProbaMap() : Void
	{
		var softParsed : Int = 0;
		var data : String = null;
		
		while(softParsed < m_parsePerFrame && m_parsed < m_datas.length)
		{
			data = m_datas[m_parsed];
			
			if (data == null || data == "" || Lambda.has(m_alreadyParsed, data))
			{
				softParsed++;
				m_parsed++;
				continue;
			}
			
			m_alreadyParsed.push(data);
				
			for (i in 0...data.length+1)
			{
				var letterM2 : String = data.charAt(i-2);
				var letterM1 : String = data.charAt(i-1);
				var letterM0 : String = data.charAt(i);
				var groupBeforeLetterToTest : String = letterM2 + letterM1;
				
				if (groupBeforeLetterToTest.length == 0)
					m_firstLetterProba.push(letterM0);
				else
				{
					var groupMapProba : Array<String> = null;
					if (!m_groupProba.exists(groupBeforeLetterToTest))
						groupMapProba = new Array<String>();
					else
						groupMapProba = m_groupProba.get(groupBeforeLetterToTest);
					
					if(letterM0.length !=0)
						groupMapProba.push(letterM0);
					else
						groupMapProba.push("$");
					
					m_groupProba.set(groupBeforeLetterToTest, groupMapProba);
				}
			}
			
			softParsed++;
			m_parsed++;
		}
		
		if (m_parsed < m_datas.length  && m_parsed < 20000)
		{
			trace("wait 10ms for parsing, parsed = " + m_parsed + "/" + m_datas.length);
			Timer.delay(loadProbaMap, 10);
		}
		else if (m_parsingEnded != null)
		{
			trace("name parsing ended");
			m_parsingEnded();
		}
			
		
	}
		
	/*private function incrementeMap(map : Map<String, Int>, key : String)
	{
		if (!map.exists(key))
			map.set(key, 1);
		else
		{
			var value : Int = map.get(key) + 1;
			map.set(key, value);	
		}
	}*/
	
	
	private function pickLetter(group : String) : String
	{
		var result : String = null;
		
		if(group == null || group.length ==0)
			return m_firstLetterProba[Std.random(m_firstLetterProba.length)];
			
		
		var arrProbaForGroup : Array<String> = m_groupProba.get(group);
		
		if (arrProbaForGroup == null || arrProbaForGroup.length == 0)
			return null;
		else
			return arrProbaForGroup[Std.random(arrProbaForGroup.length)];
		
		return null;
	}
	
	public function generate(minLetter : Int = -1, maxLetter : Int = -1) : String
	{
		
		if (!m_init)
		{
			trace("NameRandomizer is not initialized");
			return null;
		}
		
		var result : String = "";
		var lastPick : String = "";
		var lastGroup : String = "";
		
		while (lastPick != "$")
		{
			lastPick = pickLetter(lastGroup);
			
			if (lastPick != "$")
				result += lastPick;
			
			lastGroup = result.charAt(result.length - 2) + result.charAt(result.length - 1);
			
			if (lastPick == "$" && result.length < minLetter)
			{
				lastPick = "";
				lastGroup = "";
				result = "";
			}
			
			if (maxLetter > 0 && result.length >= maxLetter)
				lastPick = "$";
		}
		
		return result;
	}
	
}