package com.napkee.export.settings
{
    public class SdkType {
        public static const SDK_FLEX3: SdkType = new SdkType();
        public static const SDK_FLEX4: SdkType = new SdkType();
        
        public static function forSetting(n: *):SdkType {
            switch (n) {
                case 0: return SDK_FLEX3;
                case 1: return SDK_FLEX4;
                case "flexsdk_3": return SDK_FLEX3;
                case "flexsdk_4": return SDK_FLEX4;
            }
            return null;
        }
    }
}