package tools;

 
import hxd.impl.Float32;
#if mac
@:hlNative("mac_native")
#end
class MacNative{
    public static function get_native_scale():Float32{
         return 1;
    }; 
}
