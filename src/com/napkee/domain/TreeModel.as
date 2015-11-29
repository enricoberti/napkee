package com.napkee.domain
{
  public class TreeModel
  {
    public var label:String;
    public var parent:TreeModel;
    public var children:Array;
    public var problem:Boolean;
    
    public function TreeModel(lbl:String)
    {
      this.label = lbl;
      this.parent = null;
      this.children = new Array();
      this.problem = false;
    }
    
  }
}