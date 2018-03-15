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
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:sizei893y4:typey5:IMAGEy9:classNamey33:__ASSET__img_btn_generic_base_pngy2:idy30:img%2Fbtn%2Fgeneric%2Fbase.pnggoR0i897R1R2R3y34:__ASSET__img_btn_generic_base2_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase2.pnggoR0i888R1R2R3y34:__ASSET__img_btn_generic_base3_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase3.pnggoR0i913R1R2R3y34:__ASSET__img_btn_generic_base4_pngR5y31:img%2Fbtn%2Fgeneric%2Fbase4.pnggoR0i453582R1R2R3y27:__ASSET__img_mainmenubg_pngR5y20:img%2FmainMenuBg.pnggoR0i231R1y4:TEXTR3y29:__ASSET__model_btn_generic_tlR5y24:model%2Fbtn%2Fgeneric.tlgoR0i157R1R15R3y35:__ASSET__model_modeldescriptor_jsonR5y28:model%2FmodelDescriptor.jsongh","version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:image("assets/img/btn/generic/base.png") #if display private #end class __ASSET__img_btn_generic_base_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base2.png") #if display private #end class __ASSET__img_btn_generic_base2_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base3.png") #if display private #end class __ASSET__img_btn_generic_base3_png extends lime.graphics.Image {}
@:image("assets/img/btn/generic/base4.png") #if display private #end class __ASSET__img_btn_generic_base4_png extends lime.graphics.Image {}
@:image("assets/img/mainMenuBg.png") #if display private #end class __ASSET__img_mainmenubg_png extends lime.graphics.Image {}
@:file("assets/model/btn/generic.tl") #if display private #end class __ASSET__model_btn_generic_tl extends haxe.io.Bytes {}
@:file("assets/model/modelDescriptor.json") #if display private #end class __ASSET__model_modeldescriptor_json extends haxe.io.Bytes {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)



#end
#end