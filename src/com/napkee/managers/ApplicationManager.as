package com.napkee.managers
{
	import com.napkee.NapkeeApplication;
	import com.napkee.utils.StringConstants;
	import com.napkee.utils.TimeUtils;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class ApplicationManager {
		
		public static function exit(event:Event):void {
			// save window position
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.WINDOW_W, NapkeeApplication.application.nativeWindow.width);
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.WINDOW_H, NapkeeApplication.application.nativeWindow.height);
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.WINDOW_X, NapkeeApplication.application.nativeWindow.x);
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.WINDOW_Y, NapkeeApplication.application.nativeWindow.y);
			NapkeeApplication.application.nativeApplication.exit();
		}
		
		public static function getPrefix():String {
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.PREFIX) == null){
				setPrefix("nap");
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.PREFIX);
		}
		
		public static function setPrefix(prefix:String):void {
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.PREFIX, prefix); 
		}
		
		public static function isCheckForUpdates():Boolean {
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.AUTO_UPDATE) == null){
				setCheckForUpdates(true);
			}
			return new Boolean(NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.AUTO_UPDATE)=="true");
		}
		
		public static function setCheckForUpdates(enableUpdates:Boolean):void {
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.AUTO_UPDATE, enableUpdates); 
		}
		
		public static function isOpenExport():Boolean
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.OPEN_EXPORT) == null){
				setOpenExport(true);
			}
			return new Boolean(NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.OPEN_EXPORT)=="true");
		}
		
		public static function setOpenExport(open:Boolean):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.OPEN_EXPORT, open); 
		}
		
		public static function isShowGreenComponents():Boolean
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.SHOW_GREEN_COMPONENTS) == null){
				setShowGreenComponents(true);
			}
			return new Boolean(NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.SHOW_GREEN_COMPONENTS)=="true");
		}
		
		public static function setShowGreenComponents(show:Boolean):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.SHOW_GREEN_COMPONENTS, show); 
		}
		
		public static function isSkipMarkup():Boolean
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.SKIP_MARKUP) == null){
				setSkipMarkup(false);
			}
			return new Boolean(NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.SKIP_MARKUP)=="true");
		}
		
		public static function setSkipMarkup(skip:Boolean):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.SKIP_MARKUP, skip); 
		}
		
		public static function getLastOpenedFolder():String
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.LAST_OPENED_FOLDER) == null){
				var desktop:String = File.desktopDirectory.nativePath;
				setLastOpenedFolder(desktop);
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.LAST_OPENED_FOLDER);
		}
		
		public static function setLastOpenedFolder(path:String):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.LAST_OPENED_FOLDER, path); 
		}
		
		public static function getHTMLIconsFolder():String
		{
			return "icons";
		}
		
		public static function getHTMLTitle():String
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_TITLE) == null){
				setHTMLTitle("Napkee export");
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_TITLE);
		}
		
		public static function setHTMLTitle(title:String):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.HTML_TITLE, title); 
		}
		
		public static function getAdditionalFolder():String
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_ADDITIONAL_FOLDER) == null){
				setAdditionalFolder("");
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_ADDITIONAL_FOLDER);
		}
		
		public static function setAdditionalFolder(path:String):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.HTML_ADDITIONAL_FOLDER, path); 
		}
		
		public static function getMapLocation():String
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.MAP_LOCATION) == null){
				setMapLocation("Amsterdam, The Netherlands");
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.MAP_LOCATION);
		}
		
		public static function setMapLocation(town:String):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.MAP_LOCATION, town); 
		}
		
		public static function getHTMLCustomCode():String
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_CUSTOM_CODE) == null){
				setHTMLCustomCode("");
			}
			return NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.HTML_CUSTOM_CODE);
		}
		
		public static function setHTMLCustomCode(town:String):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.HTML_CUSTOM_CODE, town); 
		}
		
		public static function isBrowserOffsetApplied():Boolean
		{
			if (NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.APPLY_BROWSER_OFFSET) == null){
				setBrowserOffsetApplied(false);
			}
			return new Boolean(NapkeeApplication.application.applicationSettingsDAO.getSetting(StringConstants.APPLY_BROWSER_OFFSET)=="true");
		}
		
		public static function setBrowserOffsetApplied(apply:Boolean):void
		{
			NapkeeApplication.application.applicationSettingsDAO.updateSetting(StringConstants.APPLY_BROWSER_OFFSET, apply); 
		}
	}
}