package com.napkee.export.settings
{
    public class FlashRuntimeType {
        public static const RUNTIME_AIR: FlashRuntimeType = new FlashRuntimeType();
        public static const RUNTIME_FLASHPLAYER: FlashRuntimeType = new FlashRuntimeType();
        
        public static function forSetting(n:*): FlashRuntimeType
        {
            switch (n) {
                case 0: return RUNTIME_FLASHPLAYER;
                case 1: return RUNTIME_AIR;
                case "air": return RUNTIME_AIR;
                case "flash": return RUNTIME_FLASHPLAYER;
            }
            return null;
        }
        
        public function isAir(): Boolean { return this===RUNTIME_AIR }
    }
}