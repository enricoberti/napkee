package com.napkee.exporters
{
  
  /**
   * Factory that produces parser types capable of building Halo (MX) controls
   */
  public class ParserFactoryForHalo implements IParserFactory
  {
    private var registeredParsers: Array = new Array();
    private var skipMarkupParsers: Array = new Array();
    private var _skipMarkup:Boolean;
    private var _templateRepository: TemplateRepository;        
    
    public function ParserFactoryForHalo() {
      registerClasses();
      registerSkippableMarkup();
    }
    
    private function registerClasses(): void {
      registeredParsers["com.balsamiq.mockups::Accordion"] = Class(AccordionParser);
      registeredParsers["com.balsamiq.mockups::Alert"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::Arrow"] = Class(ArrowParser);
      registeredParsers["com.balsamiq.mockups::BarChart"] = Class(BarChartParser);
      registeredParsers["com.balsamiq.mockups::BreadCrumbs"] = Class(BreadCrumbsParser);
      registeredParsers["com.balsamiq.mockups::Button"] = Class(ButtonParser);
      registeredParsers["com.balsamiq.mockups::ButtonBar"] = Class(ButtonBarParser);
      registeredParsers["com.balsamiq.mockups::Calendar"] = Class(CalendarParser);
      registeredParsers["com.balsamiq.mockups::CallOut"] = Class(CallOutParser);
      registeredParsers["com.balsamiq.mockups::Canvas"] = Class(CanvasParser);
      registeredParsers["com.balsamiq.mockups::CheckBox"] = Class(CheckBoxParser);
      registeredParsers["com.balsamiq.mockups::CheckBoxGroup"] = Class(CheckBoxGroupParser);
      registeredParsers["com.balsamiq.mockups::ColorPicker"] = Class(ColorPickerParser);
      registeredParsers["com.balsamiq.mockups::ColumnChart"] = Class(ColumnChartParser);
      registeredParsers["com.balsamiq.mockups::ComboBox"] = Class(ComboBoxParser);
      registeredParsers["com.balsamiq.mockups::CoverFlow"] = Class(CoverFlowParser);
      registeredParsers["com.balsamiq.mockups::DataGrid"] = Class(DataGridParser);
      registeredParsers["com.balsamiq.mockups::DateChooser"] = Class(DateChooserParser);
      registeredParsers["com.balsamiq.mockups::FieldSet"] = Class(FieldSetParser);
      registeredParsers["com.balsamiq.mockups::FormattingToolbar"] = Class(FormattingToolbarParser);
      registeredParsers["com.balsamiq.mockups::HCurly"] = Class(HCurlyParser);
      registeredParsers["com.balsamiq.mockups::HelpButton"] = Class(HelpButtonParser);
      registeredParsers["com.balsamiq.mockups::HorizontalScrollBar"] = Class(HorizontalScrollBarParser);
      registeredParsers["com.balsamiq.mockups::HRule"] = Class(HRuleParser);
      registeredParsers["com.balsamiq.mockups::HSlider"] = Class(HSliderParser);
      registeredParsers["com.balsamiq.mockups::HSplitter"] = Class(HSplitterParser);
      registeredParsers["com.balsamiq.mockups::IconLabel"] = Class(IconLabelParser);
      registeredParsers["com.balsamiq.mockups::iPhone"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::iPhoneKeyboard"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::iPhoneMenu"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::iPhonePicker"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::LineChart"] = Class(LineChartParser);
      registeredParsers["com.balsamiq.mockups::Link"] = Class(LinkParser);
      registeredParsers["com.balsamiq.mockups::LinkBar"] = Class(LinkBarParser);
      registeredParsers["com.balsamiq.mockups::List"] = Class(ListParser);
      registeredParsers["com.balsamiq.mockups::Map"] = Class(MapParser);
      registeredParsers["com.balsamiq.mockups::MediaControls"] = Class(MediaControlsParser);
      registeredParsers["com.balsamiq.mockups::Menu"] = Class(MenuParser);
      registeredParsers["com.balsamiq.mockups::MenuBar"] = Class(MenuBarParser);
      registeredParsers["com.balsamiq.mockups::ModalScreen"] = Class(ModalScreenParser);
      registeredParsers["com.balsamiq.mockups::MultilineButton"] = Class(MultilineButtonParser);
      registeredParsers["com.balsamiq.mockups::NumericStepper"] = Class(NumericStepperParser);
      registeredParsers["com.balsamiq.mockups::PieChart"] = Class(PieChartParser);
      registeredParsers["com.balsamiq.mockups::PointyButton"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::ProgressBar"] = Class(ProgressBarParser);
      registeredParsers["com.balsamiq.mockups::RadioButton"] = Class(RadioButtonParser);
      registeredParsers["com.balsamiq.mockups::RadioButtonGroup"] = Class(RadioButtonGroupParser);
      registeredParsers["com.balsamiq.mockups::RedX"] = Class(RedXParser);
      registeredParsers["com.balsamiq.mockups::RoundButton"] = Class(RoundButtonParser);
      registeredParsers["com.balsamiq.mockups::ScratchOut"] = Class(ScratchoutParser);
      registeredParsers["com.balsamiq.mockups::SearchBox"] = Class(SearchBoxParser);
      registeredParsers["com.balsamiq.mockups::SiteMap"] = Class(SiteMapParser);
      registeredParsers["com.balsamiq.mockups::StickyNote"] = Class(StickyNoteParser);
      registeredParsers["com.balsamiq.mockups::SubTitle"] = Class(SubTitleParser);
      registeredParsers["com.balsamiq.mockups::Switch"] = Class(Unsupported);
      registeredParsers["com.balsamiq.mockups::TextArea"] = Class(TextAreaParser);
      registeredParsers["com.balsamiq.mockups::TextInput"] = Class(TextInputParser);
      registeredParsers["com.balsamiq.mockups::TabBar"] = Class(TabBarParser);
      registeredParsers["com.balsamiq.mockups::TagCloud"] = Class(TagCloudParser);
      registeredParsers["com.balsamiq.mockups::Title"] = Class(TitleParser);
      registeredParsers["com.balsamiq.mockups::TitleWindow"] = Class(TitleWindowParser);
      registeredParsers["com.balsamiq.mockups::Tooltip"] = Class(TooltipParser);
      registeredParsers["com.balsamiq.mockups::Tree"] = Class(TreeParser);
      registeredParsers["com.balsamiq.mockups::VCurly"] = Class(VCurlyParser);
      registeredParsers["com.balsamiq.mockups::VerticalScrollBar"] = Class(VerticalScrollBarParser);
      registeredParsers["com.balsamiq.mockups::VerticalTabBar"] = Class(VerticalTabBarParser);
      registeredParsers["com.balsamiq.mockups::VideoPlayer"] = Class(VideoPlayerParser);
      registeredParsers["com.balsamiq.mockups::VolumeSlider"] = Class(VolumeSliderParser);
      registeredParsers["com.balsamiq.mockups::VRule"] = Class(VRuleParser);
      registeredParsers["com.balsamiq.mockups::VSlider"] = Class(VSliderParser);
      registeredParsers["com.balsamiq.mockups::VSplitter"] = Class(VSplitterParser);
      registeredParsers["com.balsamiq.mockups::Webcam"] = Class(WebcamParser);
    }
    
    private function registerSkippableMarkup(): void {
      skipMarkupParsers["com.balsamiq.mockups::Arrow"] = true;
      skipMarkupParsers["com.balsamiq.mockups::CallOut"] = true;
      skipMarkupParsers["com.balsamiq.mockups::RedX"] = true;
      skipMarkupParsers["com.balsamiq.mockups::RoundButton"] = true;
      skipMarkupParsers["com.balsamiq.mockups::ScratchOut"] = true;
      skipMarkupParsers["com.balsamiq.mockups::StickyNote"] = true;
      skipMarkupParsers["com.balsamiq.mockups::HCurly"] = true;
      skipMarkupParsers["com.balsamiq.mockups::VCurly"] = true;
    }
    
    public function set skipMarkup(skipMarkup: Boolean): void {
      _skipMarkup = skipMarkup;
    }
    
    public function createParser(controlCode:XML, offsetModifier:OffsetModifier): IControlParser {
      var _class: Class = registeredParsers[controlCode.@controlTypeID];
      if (_class == null) return null;
      if (_skipMarkup && skipMarkupParsers[controlCode.@controlTypeID]) return null;
      return new _class(controlCode, offsetModifier);
    }
  }
}