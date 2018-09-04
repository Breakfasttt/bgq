package data.ship;
import data.ship.ShipTemplate;
import haxe.Json;
import openfl.Assets;

/**
 * ...
 * @author Breakyt
 */
class TemplateManager 
{

	private var m_rawData : String;
	
	private var m_jsonData : Dynamic;
	
	private var m_templates : Array<ShipTemplate>;
	
	public function new(templatesFiles : String) 
	{
		m_rawData = Assets.getText(templatesFiles);
		
		m_jsonData = Json.parse(m_rawData);
		
		m_templates = new Array();
		
		var length = m_jsonData.templates.length;
		var template = null;
		
		for (i in 0...length)
			m_templates.push(new ShipTemplate(m_jsonData.templates[i]));
	}
	
	public function getTemplate(index : Int) : ShipTemplate
	{
		if (index < 0 || index >= m_templates.length)
			return null;
			
		return m_templates[index];
	}
	
	public function getMaxTemplate() : Int
	{
		return m_templates.length;
	}
	
}