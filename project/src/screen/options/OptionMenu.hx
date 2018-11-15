package screen.options;

import core.Application;
import core.entity.Entity;
import data.audio.AudioSavedValues;
import misc.name.ScreenName;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import src.BGQApp;
import src.misc.name.FontName;
import standard.components.audio.AudioType;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.localization.Localization;
import standard.factory.EntityFactory;
import standard.module.audio.AudioModule;
import standard.utils.uicontainer.impl.Button;
import standard.utils.uicontainer.impl.LocTextButton;
import standard.utils.uicontainer.impl.ScreenContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class OptionMenu extends ScreenContainer 
{

	private var m_audiosValueRef : AudioSavedValues;
	
	private var m_audioModuleRef : AudioModule;
	
	private var m_title : Entity;
	
	private var m_globalVolumeText : Entity;
	private var m_fxVolumeText : Entity;
	private var m_ambientVolumeText : Entity;
	
	private var m_globalLocText : Localization;
	private var m_fxLocText : Localization;
	private var m_ambientLocText : Localization;
	
	private var m_globalMinusButtons : Button;
	private var m_globalPlusButtons : Button;
	
	private var m_fxMinusButtons : Button;
	private var m_fxPlusButtons : Button;
	
	private var m_ambientMinusButtons : Button;
	private var m_ambientPlusButtons : Button;
	
	private var m_localeBtn : LocTextButton;
	
	private var m_backBtn : LocTextButton;
	 
	private var m_functWhenVolumePress : Dynamic;
	private var m_startStepVolume : Float; // En ms
	private var m_currentStepVolume : Float;  // En ms
	private var m_timeElapsed : Float;
	private var m_alreadyPress : Bool;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super(ScreenName.optionsMenu, appRef, entityFactory);
		m_startStepVolume = 800; // on comment par modifier de 0.01 toutes les 800 ms
		m_currentStepVolume = m_startStepVolume;
		m_timeElapsed = 0.0;
		m_alreadyPress = false;
	}
	
	override function configure():Void 
	{
		super.configure();
		m_audiosValueRef = BGQApp.self.datas.audiosValue;
		m_audioModuleRef = m_appRef.modManager.getModule(AudioModule);
	}
	
	override function createElement():Void 
	{
		createTitle();
		createGlobalVolumeText();
		createFxVolumeText();
		createAmbientVolumeText();
		createAllButton();
		
		this.add(m_title);
		this.add(m_globalVolumeText);
		this.add(m_fxVolumeText);
		this.add(m_ambientVolumeText);
		
		this.add(m_globalPlusButtons.entity);
		this.add(m_fxPlusButtons.entity);
		this.add(m_ambientPlusButtons.entity);
		
		this.add(m_globalMinusButtons.entity);
		this.add(m_fxMinusButtons.entity);
		this.add(m_ambientMinusButtons.entity);
		
		
		this.add(m_localeBtn.entity);
		this.add(m_backBtn.entity);
		
		refreshValue();
	}
	
	
	private function createTitle() : Void
	{
		m_title = m_entityFactoryRef.createLocTextField(this.entity.name + "::title", null, "optionsMenuTitle", null, 99,
													new Anchor(0.5, 0.05), Anchor.center);
													
		var textdisplay : TextDisplay =  m_title.getComponent(TextDisplay);
		textdisplay.setFont(FontName.scienceFair);
		textdisplay.setTextColor(0x846248);
		textdisplay.setAlignment(TextFormatAlign.CENTER);
		textdisplay.setFontSize(72);
		textdisplay.setSize(m_appRef.width, 60);
		textdisplay.setMiscProperties(false, false, false, false, false, false);
		textdisplay.setMouseEnable(false, false);
	}
	
	private function createGlobalVolumeText() : Void
	{
		m_globalVolumeText = m_entityFactoryRef.createLocTextField(this.entity.name + "::optionsGlobalVolumeTxt", this.entity, "optionsGlobalVolume", [1.0], 1, new Anchor(0.1,0.25), Anchor.centerLeft, null);
		var textDisplay = m_globalVolumeText.getComponent(TextDisplay);
		textDisplay.setFont(FontName.scienceFair);
		textDisplay.setFontSize(56);
		textDisplay.setTextColor(0x846248);
		textDisplay.setAlignment(TextFormatAlign.LEFT);
		textDisplay.setAutoSize(TextFieldAutoSize.LEFT);
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		textDisplay.setMouseEnable(false, false);
		
		m_globalLocText = m_globalVolumeText.getComponent(Localization);
	}
	
	private function createFxVolumeText() : Void
	{
		m_fxVolumeText = m_entityFactoryRef.createLocTextField(this.entity.name + "::optionsFxVolumeTxt", this.entity, "optionsFxVolume", [1.0], 1, new Anchor(0.1,0.50), Anchor.centerLeft, null);
		var textDisplay = m_fxVolumeText.getComponent(TextDisplay);
		textDisplay.setFont(FontName.scienceFair);
		textDisplay.setFontSize(56);
		textDisplay.setTextColor(0x846248);
		textDisplay.setAlignment(TextFormatAlign.LEFT);
		textDisplay.setAutoSize(TextFieldAutoSize.LEFT);
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		textDisplay.setMouseEnable(false, false);
		
		m_fxLocText = m_fxVolumeText.getComponent(Localization);
	}
	
	private function createAmbientVolumeText() : Void
	{
		m_ambientVolumeText = m_entityFactoryRef.createLocTextField(this.entity.name + "::optionsAmbientVolumeTxt", this.entity, "optionsAmbientVolume", [1.0], 1, new Anchor(0.1,0.75), Anchor.centerLeft, null);
		var textDisplay = m_ambientVolumeText.getComponent(TextDisplay);
		textDisplay.setFont(FontName.scienceFair);
		textDisplay.setFontSize(56);
		textDisplay.setTextColor(0x846248);
		textDisplay.setAlignment(TextFormatAlign.LEFT);
		textDisplay.setAutoSize(TextFieldAutoSize.LEFT);
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		textDisplay.setMouseEnable(false, false);
		
		m_ambientLocText = m_ambientVolumeText.getComponent(Localization);
	}
	
	private function createAllButton() : Void
	{

		m_globalPlusButtons = new Button(this.entity.name + "::globalplusbtn", this.m_appRef, this.m_entityFactoryRef);
		m_globalMinusButtons = new Button(this.entity.name + "::globalminusbtn", this.m_appRef, this.m_entityFactoryRef);
		m_fxPlusButtons = new Button(this.entity.name + "::fxplusbtn", this.m_appRef, this.m_entityFactoryRef);
		m_fxMinusButtons = new Button(this.entity.name + "::fxminusbtn", this.m_appRef, this.m_entityFactoryRef);
		m_ambientPlusButtons = new Button(this.entity.name + "::ambientplusbtn", this.m_appRef, this.m_entityFactoryRef);
		m_ambientMinusButtons = new Button(this.entity.name + "::ambientminusbtn", this.m_appRef, this.m_entityFactoryRef);
		
		m_globalPlusButtons.init("btnPlus", 1 , new Anchor(0.5, 0.25), Anchor.center);
		m_globalMinusButtons.init("btnMoins", 1 , new Anchor(0.4, 0.25), Anchor.center);
		m_fxPlusButtons.init("btnPlus", 1 , new Anchor(0.5, 0.50), Anchor.center);
		m_fxMinusButtons.init("btnMoins", 1 , new Anchor(0.4, 0.50), Anchor.center);
		m_ambientPlusButtons.init("btnPlus", 1 , new Anchor(0.5, 0.75), Anchor.center);
		m_ambientMinusButtons.init("btnMoins", 1 , new Anchor(0.4, 0.75), Anchor.center);
		
		m_globalPlusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.misc, 1.0);
		m_globalMinusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.misc, -1.0);
		m_globalPlusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		m_globalMinusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		
		m_fxPlusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.fx, 1.0);
		m_fxMinusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.fx, -1.0);
		m_fxPlusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		m_fxMinusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		
		m_ambientPlusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.ambient, 1.0);
		m_ambientMinusButtons.btnBehaviour.onPress = this.onPressVolumeBtn.bind(AudioType.ambient, -1.0);
		m_ambientPlusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		m_ambientMinusButtons.btnBehaviour.onRelease = this.onReleaseVolumeBtn;
		
		
		m_localeBtn = new LocTextButton(this.entity.name + "::localBtn", this.m_appRef, this.m_entityFactoryRef);
		m_localeBtn.init("genericBtn", 4 , new Anchor(0.66, 0.5), Anchor.centerLeft, onLocalbtn, null , null , null, 1.0, 1.0);
		m_localeBtn.setLoc("menuLocale", null);
		m_localeBtn.textDisplay.setFont(FontName.scienceFair);
		m_localeBtn.textDisplay.setTextColor(0x846248);
		
		
		m_backBtn = new LocTextButton(this.entity.name + "::backButton", this.m_appRef, this.m_entityFactoryRef);
		m_backBtn.init("genericBtn", 1 , new Anchor(20, 20, false), Anchor.topLeft, onBackButton, null, null, 0.75, 0.75);
		m_backBtn.setLoc("btnBack");
		m_backBtn.textDisplay.setFont(FontName.scienceFair);
		m_backBtn.textDisplay.setTextColor(0x846248);
		m_backBtn.textDisplay.setFontSize(50);
		
	}
	
	private function refreshValue() : Void
	{
		if (m_audiosValueRef == null)
			return;
		
		m_globalLocText.setDataAt(0, Math.round(m_audiosValueRef.globalVolume * 100));
		m_fxLocText.setDataAt(0, Math.round(m_audiosValueRef.fxVolume * 100));
		m_ambientLocText.setDataAt(0, Math.round(m_audiosValueRef.ambientVolume * 100));
	}
	
	private function onLocalbtn() : Void
	{
		if(BGQApp.self.localeModule.localeCode == "fr")
			BGQApp.self.localeModule.setLocaleCode("en");
		else
			BGQApp.self.localeModule.setLocaleCode("fr");
	}
	
	private function onBackButton() : Void
	{
		this.invertTransition();
		BGQApp.self.screenFactory.mainMenuScreen.invertTransition();
		
		BGQApp.self.datas.crewManager.reset();
		BGQApp.self.screenModule.goToScreen(ScreenName.mainMenu);
	}
	
	
	private function addGlobalVolume(delta : Float) : Void
	{
		BGQApp.self.audioModule.addGlobalVolume(delta); // clamp la dedans, pas besoin de le refaire
		m_audiosValueRef.globalVolume = BGQApp.self.audioModule.globalVolume; // pour la sauvegarde éventuel
	}
	
	private function addFxVolume(delta : Float) : Void
	{
		BGQApp.self.audioModule.addTypeVolume(AudioType.fx, delta); // clamp la dedans, pas besoin de le refaire
		m_audiosValueRef.fxVolume = BGQApp.self.audioModule.getTypeVolume(AudioType.fx); // pour la sauvegarde éventuel
	}
	
	private function addAmbientVolume(delta : Float) : Void
	{
		BGQApp.self.audioModule.addTypeVolume(AudioType.ambient, delta); // clamp la dedans, pas besoin de le refaire
		m_audiosValueRef.ambientVolume = BGQApp.self.audioModule.getTypeVolume(AudioType.ambient); // pour la sauvegarde éventuel
	}
	
	public function onPressVolumeBtn(audioType : AudioType, factor : Float) : Void
	{
		//m_timeElapsed += this.m_appRef.tick.lastDelta;
		
		//var step : Float = 8 / (m_timeElapsed * m_timeElapsed);
		
		/*trace("== ===== ==");
		trace("this.m_appRef.tick.lastDelta = " + this.m_appRef.tick.lastDelta);
		trace("m_timeElapsed = " + m_timeElapsed);
		trace("step = " + step);
		trace("== ===== ==");*/
		
		//if (m_timeElapsed < step)
		//{
			switch(audioType)
			{
				case AudioType.ambient : 	addAmbientVolume(0.01 * factor);
				case AudioType.fx : 		addFxVolume(0.01 * factor);
				case AudioType.misc : 		addGlobalVolume(0.01 * factor);
				default : {}
			}
			
			this.refreshValue();
		//}
		
		if (!m_alreadyPress)
		{
			m_alreadyPress = true;
			m_functWhenVolumePress = alreadyPress.bind(_, audioType, factor);
			m_appRef.tick.tick.add(m_functWhenVolumePress);
		}
		
	}
	
	public function onReleaseVolumeBtn() : Void
	{
		m_timeElapsed = 0.0;
		m_currentStepVolume = m_startStepVolume;
		m_alreadyPress = false;
		m_appRef.tick.tick.remove(m_functWhenVolumePress);
		m_functWhenVolumePress = null;
	}
	
	public function alreadyPress(delta : Float, audioType : AudioType, factor : Float) : Void
	{
		m_timeElapsed += delta;
		
		if (m_timeElapsed >= m_currentStepVolume)
		{
			onPressVolumeBtn(audioType, factor);
			m_currentStepVolume = m_currentStepVolume / 2.0;
			m_timeElapsed = 0.0;
			
			if (m_currentStepVolume <= m_startStepVolume / 20.0)
				m_currentStepVolume = m_startStepVolume / 20.0;
		}
	}
	
}