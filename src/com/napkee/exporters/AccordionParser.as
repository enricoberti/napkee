package com.napkee.exporters
{
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.containers.Accordion;
  import mx.containers.Canvas;
  import mx.core.UIComponent;
  import mx.utils.StringUtil;
  
  public class AccordionParser extends BasicParser implements IControlParser {
    
    public function AccordionParser(controlCode:XML,offsetModifier:OffsetModifier) {
      super(controlCode,offsetModifier);
      templateName = "accordion.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Item%20One%0AItem%20Two%0A-%20Sub-Item%202.1%0A-%20Sub-Item%202.2%0AItem%20Three%0AItem%20Four";
      }
    }
    
    public override function getHtml():String {
      var cp:ComponentParser = getBaseHtml();
      var selectedIndex:int = StringUtils.isNotBlank(control.controlProperties.selectedIndex)?control.controlProperties.selectedIndex:0;
      var code:String = "";
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      
      //var openSubitems:Boolean = false;
      for (var i:int = 0;i<crumbs.length;i++){
        var link:String = unescape(crumbs[i] as String);
        
        if (link.indexOf("- ") > -1){
          code += '\t\t\t\t<li id="#'+ (getComponentID() + "si" + i) +'">' + StringUtils.escapeCharsAndGetHtml(link.substr(2)) + '</li>\n';
        }
        else {
          if (code != ""){
            code += '\t\t\t</ul>\n';
            code += '\t\t</div>\n';
            code += '\t</div>\n';
            code += '</div>\n';	
          }
          code += '<div class="accordion-group">\n';
          code += '\t<div class="accordion-heading">\n';
          code += '\t\t<a class="accordion-toggle" data-toggle="collapse" data-parent="#'+ getComponentID() +'" href="#'+ (getComponentID() + "i" + i) +'">\n';
          code += '\t\t\t' + StringUtils.escapeCharsAndGetHtml(link) + '\n';
          code += '\t\t</a>\n';
          code += '\t</div>\n';
          var childrenSelected:Boolean = false;
          for (var j:int = i+1;j<crumbs.length;j++){
            var sublink:String = unescape(crumbs[j] as String);
            if (sublink.indexOf("- ") == -1){
              break;
            }
            if (sublink.indexOf("- ") > -1 && selectedIndex == j){
              childrenSelected = true;
            }
          }
          
          code += '\t<div id="'+ (getComponentID() + "i" + i) +'" class="accordion-body collapse '+(selectedIndex==i || childrenSelected?"in":"")+'">\n';
          code += '\t\t<div class="accordion-inner">\n';
          code += '\t\t\t${children'+i+'}\n'
          code += '\t\t\t<ul>\n';
          //code += '<h3 id="'+(getComponentID() + "i" + i)+'"><span>'+StringUtils.escapeCharsAndGetHtml(link)+'</span></h3>\n<div id="'+(getComponentID() + "ic" + i)+'" class="napkeeAccordionDiv">${children'+i+'}';
        }
      }
      if (code != ""){
        code += '\t\t\t</ul>\n';
        code += '\t\t</div>\n';
        code += '\t</div>\n';
        code += '</div>\n';
      }
      cp.setPlaceHolder("code",code);
      return cp.getParsed();			
    }
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      
      var selectedIndex:int = StringUtils.isNotBlank(control.controlProperties.selectedIndex)?control.controlProperties.selectedIndex:0;
      var lastH3:int = -1;
      var subItemsCount:int = 0;
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      for (var i:int = 0;i<crumbs.length;i++){
        var link:String = StringUtil.trim(unescape(crumbs[i] as String));
        if (link.indexOf("- ") > -1){
          if (selectedIndex == i){
            cp.setPlaceHolder("activate",lastH3);
          }
        }
        else {
          lastH3++;
        }
      }
      for (var i:int = 0;i<selectedIndex;i++){
        var link:String = StringUtil.trim(unescape(crumbs[i] as String));
        if (link.indexOf("- ") > -1){
          subItemsCount++;
        }
      }
      cp.setPlaceHolder("activate",selectedIndex-subItemsCount);
      
      cp.setPlaceHolder("clickCode",getJsMultipleLinks());
      return cp.getParsed();
    }
    
    
  }
}