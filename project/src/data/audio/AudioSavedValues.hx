package data.audio;

/**
 * ...
 * @author Breakyt
 */
class AudioSavedValues 
{

	public var globalVolume : Float;
	public var fxVolume : Float;
	public var ambientVolume : Float;
	
	public var globalMute : Bool;
	public var fxMute : Bool;
	public var ambientMute : Bool;
	
	public function new() 
	{
		this.globalVolume = 1.0;
		this.fxVolume = 1.0;
		this.ambientVolume = 1.0;
		
		this.globalMute = false;
		this.fxMute = false;
		this.ambientMute = false;
	}
	
}