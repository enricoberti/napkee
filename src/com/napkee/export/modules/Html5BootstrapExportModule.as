package com.napkee.export.modules
{
  import com.napkee.export.ExportEvent;
  import com.napkee.export.ExportSpec;
  import com.napkee.export.ExportTaskBuilder;
  import com.napkee.export.Substitutions;
  import com.napkee.exporters.OffsetModifier;
  import com.napkee.exporters.TemplateRepository;
  import com.napkee.importers.BMMLParser;
  import com.napkee.managers.ApplicationManager;
  import com.napkee.utils.StringConstants;
  import com.napkee.utils.StringUtils;
  import com.napkee.vo.BMMLFile;
  
  import flash.errors.IllegalOperationError;
  import flash.events.IEventDispatcher;
  import flash.filesystem.File;
  
  import mx.collections.ArrayCollection;
  import mx.modules.ModuleBase;
  
  public class Html5BootstrapExportModule extends ModuleBase implements IExportModule {
    
    private var _eventDispatcher:IEventDispatcher;
    
    private var repository: TemplateRepository;
    
    public function set eventDispatcher(eventDispatcher: IEventDispatcher): void {
      this._eventDispatcher = eventDispatcher;
      repository = new TemplateRepository("assets/templates/html5-bootstrap/components");
    }
    
    public function get displayName(): String {
      return "HTML5 / jQuery / Bootstrap export";
    }
    
    public function accepts(spec:ExportSpec): Boolean {
      return spec.exportNature==StringConstants.PROJECT_NATURE_WEB;
    }
    
    public function buildJob(spec:ExportSpec): ExportTaskBuilder {
      if (!accepts(spec)) 
        throw new IllegalOperationError("specification is not acceptable");
      
      var builder:ExportTaskBuilder = new ExportTaskBuilder(spec);
      copyHtmlAssetsToFolder(builder);
      generateSourcesForMockups(builder, spec.sourceMockups);
      return builder;
    }
    
    private function copyHtmlAssetsToFolder(builder:ExportTaskBuilder): void {
      builder
      .copy("assets/templates/html5-bootstrap/css", "css")
        .copy("assets/templates/html5-bootstrap/images", "images")
        .copy("assets/templates/html5-bootstrap/icons", ApplicationManager.getHTMLIconsFolder())
        .copy("assets/templates/html5-bootstrap/js", "js")
        .copy("assets/templates/html5-bootstrap/swf", "swf");                
      
      if (StringUtils.isNotBlank(ApplicationManager.getAdditionalCSSFile())) {
        var additionalCSSFile:File = new File(ApplicationManager.getAdditionalCSSFile());
        builder.copy(additionalCSSFile, additionalCSSFile.name);
      }
    }
    
    private function generateSourcesForMockups(builder:ExportTaskBuilder, sourceMockups:ArrayCollection):void {
      for each(var mockupFile:BMMLFile in sourceMockups) {
        var parser:BMMLParser = new BMMLParser(mockupFile.file.nativePath, repository);
        var html:String = parser.getHtml();
        if (ApplicationManager.isBrowserOffsetApplied() && parser.getBrowserWindowOffset() != null){
          html = wrappedByOffsetDiv(html, parser.getBrowserWindowOffset());
        }
        var additionalCss:String = "";
        if (StringUtils.isNotBlank(ApplicationManager.getAdditionalCSSFile())) {
          var f:File = new File(ApplicationManager.getAdditionalCSSFile());
          if (f.exists)
            additionalCss = '<link rel="stylesheet" href="css/'+f.name+'" type="text/css" />';
        }
        
        builder
        .transformAndCopy("assets/templates/html5-bootstrap/preview.template.html", new Substitutions()
          .replace("HTMLtitle", ApplicationManager.getHTMLTitle())
          .replace("defaultFontSize", ApplicationManager.getDefaultFontSize())
          .replace("defaultFontFamily", ApplicationManager.getDefaultFontFamily())
          .replace("style", parser.getCss())
          .replace("html", html)
          .replace("jsDocReady", parser.getJs())
          .replace("additionalCSS", additionalCss)
          .replace("customCode", ApplicationManager.getHTMLCustomCode()),
          StringUtils.getNormalizedName(mockupFile.file.name)+".html");
        
        _eventDispatcher.dispatchEvent(ExportEvent.mockupExported(mockupFile));
        
        generateSourcesForMockups(builder, mockupFile.linkedFiles);
      }
    }
    
    private static function wrappedByOffsetDiv(html: String, ofs: OffsetModifier): String {
      return "<div id=\"napkeeMainCanvas\" class=\"napkeeComponent\" style=\"top:-"+ofs.y+"px;left:-"+ofs.x+"px\">\n" 
        + html 
        + "\n</div>\n";
    }
    
  }
}