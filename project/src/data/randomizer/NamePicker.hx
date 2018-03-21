package data.randomizer;
import openfl.Assets;

/**
 * ...
 * @author Breakyt
 */
class NamePicker 
{

	private var m_names : Array<String>;
	private var m_firstnames : Array<String>;
	
	public function new(nameFile : String, firstNameFile : String)
	{
		var rawData : String = "";
		m_names = [];
		m_firstnames = [];
		
		
		try
		{
			rawData = Assets.getText(nameFile);
			rawData = rawData.toLowerCase();
			m_names  = rawData.split("\r\n");
		}
		catch (e : Dynamic)
		{
			trace("NamePicker::Error while loading and parsing : " + nameFile + " : " + e);
		}
			
		try
		{
			rawData = Assets.getText(firstNameFile);
			rawData = rawData.toLowerCase();
			m_firstnames  = rawData.split("\r\n");	
		}
		catch (e : Dynamic)
		{
			trace("NamePicker::Error while loading and parsing : " + firstNameFile + " : " + e);
		}
	}
	
	public function pickRandomName() : String
	{
		if (m_names.length <= 0)
			return "";
		
		return m_names[Std.random(m_names.length)];
	
	}
	
	public function pickRandomfirstName() : String
	{
		if (m_firstnames.length <= 0)
			return "";
		
		return m_firstnames[Std.random(m_firstnames.length)];
	}
	
}