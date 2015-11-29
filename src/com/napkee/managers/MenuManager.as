package com.napkee.managers
{
  import com.napkee.NapkeeApplication;
  
  import flash.desktop.NativeApplication;
  import flash.display.NativeMenu;
  import flash.display.NativeMenuItem;
  import flash.display.NativeWindow;
  import flash.events.Event;
  import flash.ui.Keyboard;
  
  import mx.core.FlexGlobals;
  import mx.utils.UIDUtil;
  
  public class MenuManager {
    private var keyModifiers:Array;
    
    public function initMenu():void {
      // windows and linux
      if (NativeWindow.supportsMenu){
        keyModifiers = [Keyboard.CONTROL];    
        createWindowsMenu();
      }
      // mac
      if (NativeApplication.supportsMenu){
        keyModifiers = [Keyboard.COMMAND];    
        createMacMenu();
      }
    }
    
    private function getSeparator():NativeMenuItem {
      return new NativeMenuItem(UIDUtil.createUID(),true);
    }
    
    private function createMacMenu():void {
      var menu:NativeMenu = new NativeMenu();
      
      var menuItem0:NativeMenuItem = new NativeMenuItem("Napkee");
      menuItem0.submenu = createNapkeeMenuMac();
      menuItem0.addEventListener(Event.SELECT, UIManager.selectHandler);
      menu.addItem(menuItem0);
      
      var menuItem1:NativeMenuItem = new NativeMenuItem("File");
      menuItem1.submenu = createFileMenuMac();
      menuItem1.addEventListener(Event.SELECT, UIManager.selectHandler);
      menu.addItem(menuItem1);
      
      var menuItem2:NativeMenuItem = new NativeMenuItem("Help");
      menuItem2.submenu = createHelpMenuMac();
      menuItem2.addEventListener(Event.SELECT, UIManager.selectHandler);
      menu.addItem(menuItem2);
      
      
      NativeApplication.nativeApplication.menu = menu;
      
    }
    
    private function createWindowsMenu():void
    {
      
      var menu:NativeMenu = new NativeMenu();
      NapkeeApplication.application.stage.nativeWindow.menu = menu;
      
      var menuItem0:NativeMenuItem = new NativeMenuItem("File");
      NapkeeApplication.application.stage.nativeWindow.menu.addItem(menuItem0);
      menuItem0.submenu = createFileMenuWindows();
      
      var menuItem1:NativeMenuItem = new NativeMenuItem("Tools");
      NapkeeApplication.application.stage.nativeWindow.menu.addItem(menuItem1);
      menuItem1.submenu = createToolsMenuWindows();
      
      var menuItem2:NativeMenuItem = new NativeMenuItem("Help");
      NapkeeApplication.application.stage.nativeWindow.menu.addItem(menuItem2);
      menuItem2.submenu = createHelpMenuWindows();
      
    }
    
    private function createNapkeeMenuMac():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var aboutItem:NativeMenuItem = new NativeMenuItem("About Napkee");
      aboutItem.addEventListener(Event.SELECT, UIManager.aboutNapkee);
      menu.addItem(aboutItem);
      menu.addItem(getSeparator());
      var preferencesItem:NativeMenuItem = new NativeMenuItem("Preferences");
      preferencesItem.addEventListener(Event.SELECT, UIManager.preferencesNapkee);
      preferencesItem.keyEquivalentModifiers = keyModifiers;
      preferencesItem.keyEquivalent = ",";
      menu.addItem(preferencesItem);
      var updatesItem:NativeMenuItem = new NativeMenuItem("Check for updates");
      updatesItem.addEventListener(Event.SELECT, FlexGlobals.topLevelApplication.updateHandler);
      menu.addItem(updatesItem);
      menu.addItem(getSeparator());
      var hideItem:NativeMenuItem = new NativeMenuItem("Hide Napkee");
      hideItem.addEventListener(Event.SELECT, FlexGlobals.topLevelApplication.hideHandler);
      hideItem.keyEquivalentModifiers = keyModifiers;
      hideItem.keyEquivalent = "h";
      menu.addItem(hideItem);
      var quitItem:NativeMenuItem = new NativeMenuItem("Quit Napkee");
      quitItem.addEventListener(Event.SELECT, FlexGlobals.topLevelApplication.exitHandler);
      quitItem.keyEquivalentModifiers = keyModifiers;
      quitItem.keyEquivalent = "q";
      menu.addItem(quitItem);
      return menu;
    }
    
    private function createFileMenuWindows():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var projectNew:NativeMenuItem = new NativeMenuItem("New Napkee project");
      projectNew.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.newProject);
      projectNew.keyEquivalentModifiers = keyModifiers;
      projectNew.keyEquivalent = "n";
      menu.addItem(projectNew);
      var projectOpen:NativeMenuItem = new NativeMenuItem("Open...");
      projectOpen.keyEquivalentModifiers = keyModifiers;
      projectOpen.keyEquivalent = "o";
      projectOpen.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.loadProject);
      menu.addItem(projectOpen);
      var projectSave:NativeMenuItem = new NativeMenuItem("Save");
      projectSave.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.saveProject);
      projectSave.keyEquivalentModifiers = keyModifiers;
      projectSave.keyEquivalent = "s";
      menu.addItem(projectSave);
      var projectSaveAs:NativeMenuItem = new NativeMenuItem("Save as...");
      projectSaveAs.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.saveProjectAs);
      menu.addItem(projectSaveAs);
      menu.addItem(getSeparator());
      var addMockup:NativeMenuItem = new NativeMenuItem("Import Balsamiq Mockup files");
      addMockup.addEventListener(Event.SELECT, UIManager.loadBMML);
      addMockup.keyEquivalentModifiers = keyModifiers;
      addMockup.keyEquivalent = "i";
      menu.addItem(addMockup);
      var projectExport:NativeMenuItem = new NativeMenuItem("Export project");
      projectExport.addEventListener(Event.SELECT, UIManager.exportProject);
      projectExport.keyEquivalentModifiers = keyModifiers;
      projectExport.keyEquivalent = "e";
      menu.addItem(projectExport);
      menu.addItem(getSeparator());
      var quitItem:NativeMenuItem = new NativeMenuItem("Exit");
      quitItem.addEventListener(Event.SELECT, FlexGlobals.topLevelApplication.exitHandler);
      quitItem.keyEquivalentModifiers = keyModifiers;
      quitItem.keyEquivalent = "q";
      menu.addItem(quitItem);
      return menu;
    }
    
    private function createFileMenuMac():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var projectNew:NativeMenuItem = new NativeMenuItem("New Napkee project");
      projectNew.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.newProject);
      projectNew.keyEquivalentModifiers = keyModifiers;
      projectNew.keyEquivalent = "n";
      menu.addItem(projectNew);
      var projectOpen:NativeMenuItem = new NativeMenuItem("Open...");
      projectOpen.keyEquivalentModifiers = keyModifiers;
      projectOpen.keyEquivalent = "o";
      projectOpen.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.loadProject);
      menu.addItem(projectOpen);
      var projectSave:NativeMenuItem = new NativeMenuItem("Save");
      projectSave.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.saveProject);
      projectSave.keyEquivalentModifiers = keyModifiers;
      projectSave.keyEquivalent = "s";
      menu.addItem(projectSave);
      var projectSaveAs:NativeMenuItem = new NativeMenuItem("Save as...");
      projectSaveAs.addEventListener(Event.SELECT, NapkeeApplication.application.projectManager.saveProjectAs);
      menu.addItem(projectSaveAs);
      menu.addItem(getSeparator());
      var addMockup:NativeMenuItem = new NativeMenuItem("Import Balsamiq Mockup files");
      addMockup.addEventListener(Event.SELECT, UIManager.loadBMML);
      addMockup.keyEquivalentModifiers = keyModifiers;
      addMockup.keyEquivalent = "i";
      menu.addItem(addMockup);
      menu.addItem(getSeparator());
      var projectExport:NativeMenuItem = new NativeMenuItem("Export project");
      projectExport.addEventListener(Event.SELECT, UIManager.exportProject);
      projectExport.keyEquivalentModifiers = keyModifiers;
      projectExport.keyEquivalent = "e";
      menu.addItem(projectExport);
      return menu;
    }
    
    private function createHelpMenuWindows():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var helpItem:NativeMenuItem = new NativeMenuItem("Online support");
      helpItem.addEventListener(Event.SELECT, UIManager.onlineHelp);
      menu.addItem(helpItem);
      var feedbackItem:NativeMenuItem = new NativeMenuItem("Send feedback...");
      feedbackItem.addEventListener(Event.SELECT, UIManager.onlineFeedback);
      menu.addItem(feedbackItem);
      menu.addItem(getSeparator());
      
      var updatesItem:NativeMenuItem = new NativeMenuItem("Check for updates");
      updatesItem.addEventListener(Event.SELECT, FlexGlobals.topLevelApplication.updateHandler);
      menu.addItem(updatesItem);
      menu.addItem(getSeparator());
      var aboutItem:NativeMenuItem = new NativeMenuItem("About Napkee");
      aboutItem.addEventListener(Event.SELECT, UIManager.aboutNapkee);
      menu.addItem(aboutItem);
      return menu;
    }
    
    private function createToolsMenuWindows():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var preferencesItem:NativeMenuItem = new NativeMenuItem("Options...");
      preferencesItem.addEventListener(Event.SELECT, UIManager.preferencesNapkee);
      menu.addItem(preferencesItem);
      return menu;
    }
    
    private function createHelpMenuMac():NativeMenu
    {
      var menu:NativeMenu = new NativeMenu();
      var helpItem:NativeMenuItem = new NativeMenuItem("Online support");
      helpItem.addEventListener(Event.SELECT, UIManager.onlineHelp);
      menu.addItem(helpItem);
      var feedbackItem:NativeMenuItem = new NativeMenuItem("Send feedback...");
      feedbackItem.addEventListener(Event.SELECT, UIManager.onlineFeedback);
      menu.addItem(feedbackItem);
      return menu;
    }
    
    
    
  }
}
