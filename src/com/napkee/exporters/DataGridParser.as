package com.napkee.exporters
{
  import com.adobe.utils.StringUtil;
  import com.napkee.utils.ColorUtils;
  import com.napkee.utils.ComponentParser;
  import com.napkee.utils.StringUtils;
  
  import mx.controls.DataGrid;
  import mx.controls.dataGridClasses.DataGridColumn;
  import mx.core.UIComponent;
  
  public class DataGridParser extends BasicParser implements IControlParser
  {
    private var fillingRowHeight:Number = 0;
    private var rowHeight:Number = 30;
    
    private var tableWidth:Number = 0;
    private var tableHeight:Number = 0; 
    
    public function DataGridParser(controlCode:XML,offsetModifier:OffsetModifier)
    {
      super(controlCode,offsetModifier, "table");
      templateName = "datagrid.xml";
      if (StringUtils.isBlank(control.controlProperties.text)){
        control.controlProperties.text = "Name%5Cr%28job%20title%29%20%5E%2C%20Age%20%5Ev%2C%20Nickname%2C%20Employee%20v%0AGiacomo%20Guilizzoni%5CrFounder%20%26%20CEO%2C%2037%2C%20Peldi%2C%20%28o%29%0AMarco%20Botton%5CrTuttofare%2C%2034%2C%20%2C%20%5Bx%5D%0AMariah%20Maclachlan%5CrBetter%20Half%2C%2037%2C%20Patata%2C%20%5B-%5D%0AValerie%20Liberty%5CrHead%20Chef%2C%20%3A%29%2C%20Val%2C%20%5Bx%5D%0AGuido%20Jack%20Guilizzoni%2C%206%2C%20The%20Guids%2C%20%5B%5D%0A%7B65L%2C%200R%2C%2035%2C%200C%7D";
      }
    }
    
    public override function getHtml():String
    {
      var cp:ComponentParser = getBaseHtml();
      
      var code:String = "";
      
      escapeCommas();
      
      var columnsCode:String = "";
      var columnTitles:Array = new Array();
      var rows:Array = new Array();
      var rowsCode:String = "";
      
      var crumbs:Array = (control.controlProperties.text).split("%0A");
      
      var vLines:Boolean = true;
      if (StringUtils.isNotBlank(control.controlProperties.vLines) && (control.controlProperties.vLines)=="false"){
        vLines = false;
      }
      
      var hLines:Boolean = false;
      if (StringUtils.isNotBlank(control.controlProperties.hLines) && (control.controlProperties.hLines)=="true"){
        hLines = true;
      }
      
      var totalRows:Number = crumbs.length;
      var hasHeader:Boolean = true;
      if (StringUtils.isNotBlank(control.controlProperties.hasHeader) && (control.controlProperties.hasHeader)=="false"){
        hasHeader = false;
      }
      
      var extraRows:Number = 0;
      
      
      if (StringUtils.isNotBlank(control.controlProperties.rowHeight)){
        rowHeight = parseInt(control.controlProperties.rowHeight);
      }
      
      
      
      tableWidth = parseInt((control.@w!="-1")?control.@w:control.@measuredW)-6;
      tableHeight = parseInt((control.@h!="-1")?control.@h:control.@measuredH)-10;
      
      if (StringUtils.isNotBlank(control.controlProperties.borderStyle) && (control.controlProperties.borderStyle)=="square"){
        tableHeight = tableHeight-4;
      }
      
      if (hasHeader){
        tableHeight = tableHeight - rowHeight - 3;
        totalRows = totalRows - 1;
      }
      
      if ( (rowHeight * totalRows) < tableHeight){
        extraRows = Math.ceil(tableHeight/rowHeight) - totalRows;
      }
      
      
      if (extraRows > 0){
        fillingRowHeight = tableHeight - (rowHeight*totalRows) - (rowHeight * (extraRows -1));
      } 
      
      if (hLines){
        rowHeight = rowHeight-2;
      }
      
      var headCode:String = "";
      var bodyCode:String = "<tbody>";
      
      if (hasHeader) headCode += "<thead>\n\t<tr>\n";
      
      var lastIndex:int = 0;
      for (var i:int = 0;i<crumbs.length;i++){
        
        var line:String = (crumbs[i] as String);
        if (line.indexOf("%7B") == 0){
          break;
        }
        line = line.replace(/\%09/g,"%2C");
        var columns:Array = line.split("%2C");
        var columnWidth:Number = Math.floor(((control.@w!="-1")?control.@w:control.@measuredW)/columns.length);
        var row:String = "<tr>";
        for (var j:int=0; j<columns.length; j++){
          var oddCssClass:String = (i%2==0)?"even":"odd";
          if (i==0){ // it's a column title
            columnTitles.push(StringUtil.trim(unescape(columns[j])));
            var thClass:String = "";
            if (vLines && j<columns.length-1){
              oddCssClass += " verticalLine";
              thClass = " class=\"verticalLine\"";
            }
            if (hLines){
              oddCssClass += " horizontalLine";
              if (thClass == ""){
                thClass = " class=\"horizontalLine\"";
              }
              else {
                thClass = " class=\"verticalLine horizontalLine\"";
              }
            }
            if (hasHeader){
              //columnsCode += "<th width=\""+columnWidth+"\">"+StringUtils.getHtmlString((columnTitles[j] as String))+ "</th>" + "\n";;
              headCode += "\t\t<th"+thClass+">";
              
              if (StringUtil.trim(unescape(columnTitles[j] as String)) == "[]"){
                headCode += "<input type=\"checkbox\" />";
              }
              else if (StringUtil.trim(unescape(columnTitles[j] as String).toLowerCase()) == "[x]" || StringUtil.trim(unescape(columnTitles[j] as String).toLowerCase()) == "[-]"){
                headCode += "<input type=\"checkbox\" checked=\"checked\" />";
              }
              else if (StringUtil.trim(unescape(columnTitles[j] as String).toLowerCase()) == "(o)"){
                headCode += "<input type=\"radio\" checked=\"checked\" />";
              }
              else {
                //headCode += StringUtils.getHtmlString((columnTitles[j] as String)).replace(/\\r/gi,"<br/>");
                var title:String = StringUtils.escapeCharsAndGetHtml((columnTitles[j] as String),true);
                if (title.substr(title.length - 2) == " v"){
                  title = title.substr(0, title.length - 2) + " <i class='icon-sort-down'></i>";
                }
                if (title.substr(title.length - 2) == " ^"){
                  title = title.substr(0, title.length - 2) + " <i class='icon-sort-up'></i>";
                }
                if (title.substr(title.length - 3) == " ^v"){
                  title = title.substr(0, title.length - 3) + " <i class='icon-sort'></i>";
                }
                headCode += title;
              }
              headCode += "</th>" + "\n";
            }
            else {
              
              row += "<td class=\""+oddCssClass+"\">";
              if (StringUtil.trim(unescape(columns[j])) == "[]"){
                row += "<input type=\"checkbox\" />";
              }
              else if (StringUtil.trim(unescape(columns[j]).toLowerCase()) == "[x]" || StringUtil.trim(unescape(columns[j]).toLowerCase()) == "[-]"){
                row += "<input type=\"checkbox\" checked=\"checked\" />";
              }
              else if (StringUtil.trim(unescape(columns[j]).toLowerCase()) == "(o)"){
                row += "<input type=\"radio\" checked=\"checked\" />";
              }
              else {
                var title:String = StringUtils.escapeCharsAndGetHtml(StringUtil.trim(unescape(columns[j])),true);
                if (title.substr(title.length - 2) == " v"){
                  title = title.substr(0, title.length - 2) + " <i class='icon-sort-down'></i>";
                }
                if (title.substr(title.length - 2) == " ^"){
                  title = title.substr(0, title.length - 2) + " <i class='icon-sort-up'></i>";
                }
                if (title.substr(title.length - 3) == " ^v"){
                  title = title.substr(0, title.length - 3) + " <i class='icon-sort'></i>";
                }
                row += title;
              }
              row += "</td>";
              
            }
          }
          else {
            if (vLines && j<columns.length-1){
              oddCssClass += " verticalLine";
            }
            if (hLines){
              if (extraRows > 0){
                oddCssClass += " horizontalLine";
              }
              else {
                if (i<crumbs.length-1){
                  oddCssClass += " horizontalLine";
                }
              }
            }
            row += "<td class=\""+oddCssClass+"\">";
            if (StringUtil.trim(unescape(columns[j])) == "[]"){
              row += "<input type=\"checkbox\" />";
            }
            else if (StringUtil.trim(unescape(columns[j]).toLowerCase()) == "[x]" || StringUtil.trim(unescape(columns[j]).toLowerCase()) == "[-]"){
              row += "<input type=\"checkbox\" checked=\"checked\" />";
            }
            else if (StringUtil.trim(unescape(columns[j]).toLowerCase()) == "(o)"){
              row += "<input type=\"radio\" checked=\"checked\" />";
            }
            else {
              row += StringUtils.escapeCharsAndGetHtml(StringUtil.trim(unescape(columns[j])),true);
            }
            row += "</td>";
          }
        }
        row += "</tr>";
        if ((i==0 && !hasHeader) || i>0){
          //rows.push(row.toXMLString());
          bodyCode += row + "\n";
        }
        lastIndex++;
      }
      
      for (var xr:int = 0; xr<extraRows; xr++){
        var extraRow:String = "<tr>";
        for (var j:int=0; j<columns.length; j++){
          var oddCssClass:String = ((xr+lastIndex)%2==0)?"even":"odd";
          if (xr == extraRows -1){
            oddCssClass += " filler";
          }
          if (vLines && j<columns.length-1){
            oddCssClass += " verticalLine";
          }
          if (hLines && xr < extraRows -1){
            oddCssClass += " horizontalLine";
          }
          extraRow += "<td class=\""+oddCssClass+"\"></td>";
        }
        extraRow += "</tr>";
        bodyCode += extraRow + "\n";
      }
      
      if (hasHeader) headCode += "</tr></thead>";
      bodyCode += "</tbody>";
      
      
      cp.setPlaceHolder("head",headCode);
      cp.setPlaceHolder("body",bodyCode);	
      
      //			if (getCustomData().indexOf(".napkee") > -1){
      //				cp.setPlaceHolder("style", "napkee");
      //			}
      //			
      //			cp.setPlaceHolder("style", "table" + getCustomCss());
      
      return cp.getParsed();			
    }
    
    public override function getCss():String
    {
      var cp:ComponentParser = getBaseCss();
      if (StringUtils.isNotBlank(control.controlProperties.verticalScrollbar) && control.controlProperties.verticalScrollbar == "true"){
        cp.setPlaceHolder("overflow","auto");
      }
      else {
        cp.setPlaceHolder("overflow","hidden");
      }
      if (StringUtils.isNotBlank(control.controlProperties.color)){
        cp.setPlaceHolder("oddColor","#"+ColorUtils.intToHex(control.controlProperties.color));
      }
      else {
        cp.setPlaceHolder("oddColor","#EEEEEE");
      }
      if (StringUtils.isNotBlank(control.controlProperties.alternateRowColor)){
        cp.setPlaceHolder("evenColor","#"+ColorUtils.intToHex(control.controlProperties.alternateRowColor));
      }
      else {
        cp.setPlaceHolder("evenColor","#FFFFFF");
      }
      if (getCustomData().indexOf(".napkee") > -1){
        if (StringUtils.isNotBlank(control.controlProperties.borderStyle) && (control.controlProperties.borderStyle)=="none"){
          cp.setPlaceHolder("border","0px solid");
        }
        else {
          cp.setPlaceHolder("border","1px solid #000");
        }
      }
      cp.setPlaceHolder("border","none");
      
      cp.setPlaceHolder("tableHeight",tableHeight+"px");
      cp.setPlaceHolder("rowHeight",rowHeight+"px");
      cp.setPlaceHolder("fillerHeight",fillingRowHeight+"px");
      return cp.getParsed();
    }
    
    
    public override function getJsDocReady():String
    {
      var cp:ComponentParser = getBaseJsDocReady();
      cp.setPlaceHolder("width",((control.@w!="-1")?control.@w:control.@measuredW));
      cp.setPlaceHolder("height",((control.@h!="-1")?control.@h:control.@measuredH));
      return cp.getParsed();
    }
    
  }
}