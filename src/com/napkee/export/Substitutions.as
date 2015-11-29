package com.napkee.export
{
  import org.springextensions.actionscript.ioc.config.property.impl.Properties;
  import org.springextensions.actionscript.ioc.config.property.impl.PropertyPlaceholderResolver;
  
  public class Substitutions implements ITransformContent
  {
    private var props: Properties = new Properties();
    
    public function replace(key:String, val:String): Substitutions {
      props.setProperty(key, val);
      return this;
    }
    
    public function apply(content:String): String {
      var resolver: PropertyPlaceholderResolver = new PropertyPlaceholderResolver();
      resolver.propertiesProvider = props;
      resolver.regExp =  /\$\{[^}]+\}/g;
      resolver.ignoreUnresolvablePlaceholders = true;
      return resolver.resolvePropertyPlaceholders(content);
    }
  }
}