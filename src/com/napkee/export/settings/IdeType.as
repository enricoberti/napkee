package com.napkee.export.settings
{
  public final class IdeType {
    public static const IDE_FLASH_BUILDER3: IdeType = new IdeType();
    public static const IDE_FLASH_BUILDER4: IdeType = new IdeType();
    public static const IDE_FDT: IdeType = new IdeType();
    
    public static function forSetting(n: *):IdeType {
      switch (n) {
        case 0: return IDE_FLASH_BUILDER3;
        case 1: return IDE_FDT;
        case 2: return IDE_FLASH_BUILDER4;
        case "fb3": return IDE_FLASH_BUILDER3;
        case "fb4.7": return IDE_FLASH_BUILDER4;
        case "fdt": return IDE_FDT;
      }
      return null;
    }
  }
}