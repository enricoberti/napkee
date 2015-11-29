package com.napkee.exporters
{
  public interface IParserFactory
  {
    function set skipMarkup(skipMarkup: Boolean): void;
    
    function createParser(controlCode:XML, offsetModifier:OffsetModifier): IControlParser;
  }
}