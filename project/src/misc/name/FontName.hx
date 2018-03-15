package src.misc.name;
import openfl.Assets;

/**
 * ...
 * @author Breakyt
 */
class FontName 
{

	public static var airStrip : String;
	public static var giantRobot : String;
	public static var scienceFair : String;
	
	public static function init() : Void
	{
		try{
			airStrip = Assets.getFont("fonts/airstrip.ttf").fontName;
			giantRobot = Assets.getFont("fonts/GiantRobotArmy-Medium.ttf").fontName;
			scienceFair = Assets.getFont("fonts/Science Fair.otf").fontName;
		}
		catch (e : Dynamic)
		{
			trace("fail to embed font : " + e);
			airStrip = "";
			giantRobot = "";
			scienceFair = "";
		}
	}
	
}