package popup.confirmPopup;

import core.Application;
import core.entity.Entity;
import openfl.text.TextFormatAlign;
import src.misc.name.FontName;
import standard.components.graphic.display.impl.TextDisplay;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.LocTextButton;
import standard.utils.uicontainer.impl.PopupContainer;
import standard.utils.uicontainer.impl.TextButton;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ConfirmPopup extends PopupContainer 
{
	
	private var m_titleLocKey : String;
	private var m_infosLocKey : String;
	
	private var m_titleDatas : Array<Dynamic>;
	private var m_infosDatas : Array<Dynamic>;
	
	public var confirmCb : Void->Void;
	public var cancelCb : Void->Void;
	
	private var m_background : Entity;
	private var m_titleTd : Entity;
	private var m_infosTd : Entity;
	private var m_confirmBtn : LocTextButton;
	private var m_cancelBtn : LocTextButton;
	
	private var m_canceled : Bool;

	public function new(appRef:Application, entityFactory:EntityFactory, entityName : String, titleLocKey : String, infosLocKey: String, titleDatas : Array<Dynamic> = null, infosDatas : Array<Dynamic> = null) 
	{
		m_titleLocKey = titleLocKey;
		m_infosLocKey = infosLocKey;
		m_titleDatas = titleDatas;
		m_infosDatas = infosDatas;
		
		this.confirmCb = null;
		this.cancelCb = null;
		super(entityName, appRef, entityFactory);
		m_canceled = false;
	}
	
	override function configure():Void 
	{
		super.configure();

		this.utilitySize.autoUtilitySize = false;
		this.utilitySize.width = 800.0;
		this.utilitySize.height = 600.0;		
	}
	
	override function createElement():Void 
	{
		m_background = this.m_entityFactoryRef.createGameElement(this.entity.name + "::simplePopupBg", null, "simplePopupBg", 0, Anchor.topLeft, Anchor.topLeft);
		
		
		m_titleTd = this.m_entityFactoryRef.createLocTextField(this.entity.name + "title", m_background, m_titleLocKey, m_titleDatas,  1, new Anchor(12.55, 36.35, false), Anchor.topLeft);
		m_infosTd = this.m_entityFactoryRef.createLocTextField(this.entity.name + "infos", m_background, m_infosLocKey, m_infosDatas, 2, new Anchor(38.25, 168.50, false), Anchor.topLeft);
		
		//m_titleTd = this.m_entityFactoryRef.createTextField("title", m_background, m_title, 1, new Anchor(0, 0), Anchor.topLeft);
		//m_infosTd = this.m_entityFactoryRef.createTextField("infos", m_background, m_infos, 1, new Anchor(0, 0), Anchor.topLeft);
		
		var titleDispl : TextDisplay = m_titleTd.getComponent(TextDisplay);
		titleDispl.setFont(FontName.scienceFair);
		titleDispl.setTextColor(0xFF6600);
		titleDispl.setAlignment(TextFormatAlign.CENTER);
		titleDispl.setFontSize(42);
		titleDispl.setSize(773, 56.60);
		titleDispl.setMiscProperties(false, false, false, false, false, false);
		titleDispl.skin.alpha = 0.8;
		
		var infosDisplay : TextDisplay = m_infosTd.getComponent(TextDisplay);
		infosDisplay.setFont(FontName.scienceFair);
		infosDisplay.setTextColor(0xFF9933);
		infosDisplay.setAlignment(TextFormatAlign.CENTER);
		infosDisplay.setFontSize(37);
		infosDisplay.setSize(722.25, 392.40);
		infosDisplay.setMiscProperties(false, true, true, false, false, false);
		infosDisplay.skin.alpha = 0.8;
		
		//m_confirmBtn = this.m_entityFactoryRef.createSimpleBtn("confirmBtn", null, "genericBtn", 3, new Anchor(0.0, 571.80, false), Anchor.topCenter, onSelectConfirm);
		//m_cancelBtn = this.m_entityFactoryRef.createSimpleBtn("cancelBtn", null, "genericBtn", 4, new Anchor(428.10, 571.80, false), Anchor.topCenter, onSelectCancel);
		m_confirmBtn = new LocTextButton(this.entity.name + "confirmBtn", this.m_appRef, this.m_entityFactoryRef);
		m_cancelBtn = new LocTextButton(this.entity.name + "cancelBtn", this.m_appRef, this.m_entityFactoryRef);
		
		m_confirmBtn.init("genericBtn", 3, new Anchor(428.10, 571.80, false), Anchor.topLeft, onSelectConfirm);
		m_cancelBtn.init("genericBtn", 4, new Anchor(0.0, 571.80, false), Anchor.topLeft, onSelectCancel);
		
		m_confirmBtn.setLoc("accept");
		m_cancelBtn.setLoc("cancel");
		
		m_confirmBtn.textDisplay.setTextColor(0xFF9933);
		m_cancelBtn.textDisplay.setTextColor(0xFF9933);
		
		m_confirmBtn.textDisplay.setFont(FontName.scienceFair);
		m_cancelBtn.textDisplay.setFont(FontName.scienceFair);
		
		this.add(m_background);
		this.add(m_confirmBtn.entity);
		this.add(m_cancelBtn.entity);
		
		m_appRef.addEntity(m_titleTd);
		m_appRef.addEntity(m_infosTd);
		
	}
	
	private function onSelectConfirm() : Void
	{
		this.closePopup();
		m_canceled = false;
	}
	
	private function onSelectCancel() : Void
	{
		this.closePopup();
		m_canceled = true;
	}
	
	override function onCustomClose():Void 
	{
		if (!m_canceled && this.confirmCb != null)
			this.confirmCb();
		else if (m_canceled && this.cancelCb != null)
			this.cancelCb();
			
		m_canceled = false;
	}
	
}