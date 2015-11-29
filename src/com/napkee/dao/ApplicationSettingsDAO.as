package com.napkee.dao
{
  import com.napkee.domain.ApplicationSetting;
  import com.napkee.orm.EntityManager;
  
  import mx.collections.ArrayCollection;
  
  public class ApplicationSettingsDAO
  {
    
    private static var entityManager:EntityManager;
    
    public function ApplicationSettingsDAO(em:EntityManager)
    {
      entityManager = em;
    }
    
    public function createSetting(sProperty:String,value:Object):ApplicationSetting
    {
      var s:ApplicationSetting = new ApplicationSetting();
      s.property = sProperty;
      s.value = new String(value);
      entityManager.save(s);
      return s;
    }
    
    public function getSetting(sProperty:String):String
    {
      var setting:ApplicationSetting = getSettingObj(sProperty);
      if (setting != null){
        return setting.value;
      }
      return null;
    }
    
    public function getSettingObj(sProperty:String):ApplicationSetting
    {
      var allSettings:ArrayCollection = findAll();
      for each (var s:ApplicationSetting in allSettings){
        if (s.property == sProperty){
          return s;
        }
      }
      return null;
    }
    
    public function updateSetting(sProperty:String,value:Object):void
    {
      var setting:ApplicationSetting = getSettingObj(sProperty);
      if (setting != null){
        setting.value = new String(value);
        updateSettingObj(setting);
      }
      else {
        createSetting(sProperty,value);
      }
    }
    
    public function updateSettingObj(s:ApplicationSetting):void
    {
      entityManager.save(s);
    }
    
    public function removeSetting(sProperty:String):void
    {
      var setting:ApplicationSetting = getSettingObj(sProperty);
      if (setting != null){
        removeSettingObj(setting);
      }
    }
    
    public function removeSettingObj(s:ApplicationSetting):void
    {
      entityManager.remove(s);
    }
    
    public function findAll():ArrayCollection
    {
      return entityManager.findAll(ApplicationSetting);
    }
    
  }
}