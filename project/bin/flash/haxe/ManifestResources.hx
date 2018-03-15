package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_airstrip_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_giantrobotarmy_medium_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_science_fair_italic_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_science_fair_light_italic_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_science_fair_light_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_science_fair_otf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:sizei893y4:typey5:IMAGEy9:classNamey33:__ASSET__img_btn_generic_base_pngy2:idy30:img%2Fbtn%2Fgeneric%2Fbase.pnggoR0i897R1R2R3y34:__ASSET__img_btn_generic_base2_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase2.pnggoR0i888R1R2R3y34:__ASSET__img_btn_generic_base3_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase3.pnggoR0i913R1R2R3y34:__ASSET__img_btn_generic_base4_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase4.pnggoR0i453582R1R2R3y27:__ASSET__img_mainmenubg_pngR5y20:img%2FmainMenuBg.pnggoR0i231R1y4:TEXTR3y29:__ASSET__model_btn_generic_tlR5y24:model%2Fbtn%2Fgeneric.tlgoR0i157R1R15R3y35:__ASSET__model_modeldescriptor_jsonR5y28:model%2FmodelDescriptor.jsongoR0i25956R1y4:FONTR3y27:__ASSET__fonts_airstrip_ttfR5y20:fonts%2Fairstrip.ttfgoR0i79572R1R20R3y40:__ASSET__fonts_giantrobotarmy_medium_ttfR5y33:fonts%2FGiantRobotArmy-Medium.ttfgoR0i24392R1R20R3y38:__ASSET__fonts_science_fair_italic_otfR5y35:fonts%2FScience%20Fair%20Italic.otfgoR0i24852R1R20R3y44:__ASSET__fonts_science_fair_light_italic_otfR5y43:fonts%2FScience%20Fair%20Light%20Italic.otfgoR0i23868R1R20R3y37:__ASSET__fonts_science_fair_light_otfR5y34:fonts%2FScience%20Fair%20Light.otfgoR0i23972R1R20R3y31:__ASSET__fonts_science_fair_otfR5y26:fonts%2FScience%20Fair.otfgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__img_btn_generic_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btn_generic_base2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btn_generic_base3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btn_generic_base4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_mainmenubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__model_btn_generic_tl extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__model_modeldescriptor_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__fonts_airstrip_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_giantrobotarmy_medium_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_science_fair_italic_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_science_fair_light_italic_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_science_fair_light_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_science_fair_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:image("assets/img/btn/generic/base.png") #if display private #end class __ASSET__img_btn_generic_base_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base2.png") #if display private #end class __ASSET__img_btn_generic_base2_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base3.png") #if display private #end class __ASSET__img_btn_generic_base3_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base4.png") #if display private #end class __ASSET__img_btn_generic_base4_png extends lime.graphics.Image {}
@:image("assets/img/mainMenuBg.png") #if display private #end class __ASSET__img_mainmenubg_png extends lime.graphics.Image {}
@:file("assets/model/btn/generic.tl") #if display private #end class __ASSET__model_btn_generic_tl extends haxe.io.Bytes {}
@:file("assets/model/modelDescriptor.json") #if display private #end class __ASSET__model_modeldescriptor_json extends haxe.io.Bytes {}
@:font("assets/fonts/airstrip.ttf") #if display private #end class __ASSET__fonts_airstrip_ttf extends lime.text.Font {}
@:font("assets/fonts/GiantRobotArmy-Medium.ttf") #if display private #end class __ASSET__fonts_giantrobotarmy_medium_ttf extends lime.text.Font {}
@:font("assets/fonts/Science Fair Italic.otf") #if display private #end class __ASSET__fonts_science_fair_italic_otf extends lime.text.Font {}
@:font("assets/fonts/Science Fair Light Italic.otf") #if display private #end class __ASSET__fonts_science_fair_light_italic_otf extends lime.text.Font {}
@:font("assets/fonts/Science Fair Light.otf") #if display private #end class __ASSET__fonts_science_fair_light_otf extends lime.text.Font {}
@:font("assets/fonts/Science Fair.otf") #if display private #end class __ASSET__fonts_science_fair_otf extends lime.text.Font {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__fonts_airstrip_ttf') #if display private #end class __ASSET__fonts_airstrip_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/airstrip.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Airstrip Four"; super (); }}
@:keep @:expose('__ASSET__fonts_giantrobotarmy_medium_ttf') #if display private #end class __ASSET__fonts_giantrobotarmy_medium_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/GiantRobotArmy-Medium.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "GiantRobotArmy Medium"; super (); }}
@:keep @:expose('__ASSET__fonts_science_fair_italic_otf') #if display private #end class __ASSET__fonts_science_fair_italic_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Science Fair Italic.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Science Fair Italic"; super (); }}
@:keep @:expose('__ASSET__fonts_science_fair_light_italic_otf') #if display private #end class __ASSET__fonts_science_fair_light_italic_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Science Fair Light Italic.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Science Fair Light Italic"; super (); }}
@:keep @:expose('__ASSET__fonts_science_fair_light_otf') #if display private #end class __ASSET__fonts_science_fair_light_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Science Fair Light.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Science Fair Light"; super (); }}
@:keep @:expose('__ASSET__fonts_science_fair_otf') #if display private #end class __ASSET__fonts_science_fair_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Science Fair.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Science Fair"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__fonts_airstrip_ttf') #if display private #end class __ASSET__OPENFL__fonts_airstrip_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_airstrip_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_giantrobotarmy_medium_ttf') #if display private #end class __ASSET__OPENFL__fonts_giantrobotarmy_medium_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_giantrobotarmy_medium_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_science_fair_italic_otf') #if display private #end class __ASSET__OPENFL__fonts_science_fair_italic_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_science_fair_italic_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_science_fair_light_italic_otf') #if display private #end class __ASSET__OPENFL__fonts_science_fair_light_italic_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_science_fair_light_italic_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_science_fair_light_otf') #if display private #end class __ASSET__OPENFL__fonts_science_fair_light_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_science_fair_light_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_science_fair_otf') #if display private #end class __ASSET__OPENFL__fonts_science_fair_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_science_fair_otf ()); super (); }}


#end
#end