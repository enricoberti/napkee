package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class TagCloudParser extends BasicParser implements IControlParser
  {
    
    public function TagCloudParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier);
      templateName = "tagcloud.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "software%20statistics%20teaching%20technology%20tips%20tool%20tools%20toread%20travel%20tutorial%20tutorials%20tv%20twitter%20typography%20ubuntu%20usability%20video%20videos%20visualization%20web%20web20%20webdesign%20webdev%20wiki%20windows%20wordpress%20work%20writing%20youtube";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%20");
      for (var i:int = 0;i<crumbs.length;i++){
        var link:String = StringUtil.trim(unescape(crumbs[i] as String));
        code += '<li><a href="#">'+StringUtils.escapeCharsAndGetHtml(link)+'</a></li>';
      }
      cp.setPlaceHolder("code",code);
      return cp.getParsed();			
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
      return cp.getParsed();
    }
    
  }
}