package com.napkee.exporters
{
  import mx.core.UIComponent;
  
  public interface IControlParser
  {
    
    function getHtml():String;
    function getCss():String;
    function getJsImport():String;
    function getJsDocReady():String;
    function getCssImport():String;
    
    function set templateRepository(repo: TemplateRepository): void;
  }
}