package com.napkee.utils
{
  public class ComponentParser {
    
    private var code:String;
    
    public function ComponentParser(codeToParse:String) {
      this.code = codeToParse;
    }
    
    public function setPlaceHolder(name:String,value:Object): void {
      var pattern:String = "${"+name+"}";
      var index:int = this.code.indexOf(pattern);
      while (index > -1){
        this.code = this.code.substr(0,index) + value + this.code.substring(index+pattern.length,this.code.length);
        index = this.code.indexOf(pattern);
      }
    }
    
    public function addCssClass(klass:String): void {
      var pattern:String = "class=\"";
      var index:int = this.code.indexOf(pattern);
      if (index > -1)
        this.code = this.code.substr(0,index+pattern.length) + klass + " " + this.code.substring(index+pattern.length,this.code.length);
    }
    
    public function removeAttribute(attributeName:String): void {
      var pattern:String = attributeName+"=\"";
      var index:int = this.code.indexOf(pattern);
      if (index > -1)
        this.code = this.code.substr(0,index-1) + this.code.substring(this.code.indexOf("\"",index+pattern.length)+1,this.code.length);
    }
    
    public function removeCssAttribute(attributeName:String): void {
      var pattern:String = attributeName+":";
      var index:int = this.code.indexOf(pattern);
      if (index > -1)
        this.code = this.code.substr(0,index-1) + this.code.substring(this.code.indexOf("\n",index+pattern.length)+1,this.code.length);
    }
    
    public function addAttribute(attributeName:String, attributeValue:String): void {
      this.code = this.code.substr(0,this.code.length-4) + attributeName + "=\"" + attributeValue + "\"/>";
    }
    
    public function getParsed(): String {
      return this.code;
    }
  }
}