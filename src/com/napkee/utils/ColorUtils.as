package com.napkee.utils
{
  public class ColorUtils
  {
    public function ColorUtils()
    {
    }
    
    public static function intToHex(intValue:Number):String
    {
      var hex:String = intValue.toString(16);
      return ("00000" + hex.toUpperCase()).substr(-6);
    }
    
    public static function getLabelColor(intValue:Number):String
    {
      return intToHex(getLabelColorBasedOnBackground(intValue));
    }
    
    
    public static function getLabelColorBasedOnBackground(param1:Number):Number
    {
      return getPerceivedBrightness(param1) < 60 ? (16777215) : (0);
    }
    
    
    public static function getPerceivedBrightness(param1:Number):Number
    {
      var _loc_2:* = hex2RGB(param1);
      var _loc_3:* = (_loc_2[0] * 299 + _loc_2[1] * 587 + _loc_2[2] * 114) / 2550;
      return _loc_3;
    }
    
    
    public static function hex2RGB(param1:Number):Array
    {
      var _loc_2:* = param1 >> 16 & 255;
      var _loc_3:* = param1 >> 8 & 255;
      var _loc_4:* = param1 & 255;
      return [_loc_2, _loc_3, _loc_4];
    }
    
    
  }
}