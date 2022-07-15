package;

import slide.tweens.TweenObject;
import slide.easing.Sine;
import h2d.Bitmap;
import slide.easing.Linear;
import slide.Slide;
import hxd.impl.Float32;
import hxd.Event;
import hxd.Timer;
import haxe.macro.Compiler;
import h2d.Object;

class Main extends hxd.App {
  
  var bmp:h2d.Bitmap;
  var a:h2d.Object;
  var checkBox:h2d.CheckBox;
    override function init() {
      //hxd.Window.getInstance().vsync = true;
      #if ios
        //trace(tools.NativeIOS.get_native_scale());
      #end
      
      #if mac
        trace(tools.MacNative.get_native_scale());
      #end

      // var red:h2d.Tile = hxd.Res.loader.load("red.png").toTile();
      // var redObj = new h2d.Bitmap(red, new h2d.Object(s2d));
      // redObj.scaleX = s2d.width / red.width;
      // redObj.scaleY = s2d.height / red.height;
      // trace(redObj.scaleX);
      engine.backgroundColor = 0xff0000;
      
 
      var tile:h2d.Tile = hxd.Res.loader.load("hashlink.png").toTile();
      bmp = new h2d.Bitmap(tile, new h2d.Object(s2d));
       
      //trace(Compiler.getDefine("hl_ver"));
     
      yoyo(500);
      
    }
    var dir = 1;
  
    function yoyo(_x:Float){
      Slide.tween(bmp)
      .to({x:_x}, 2)
      .ease(Sine.easeInOut)
      .start().onComplete(()->{
        yoyo(dir == 1 ? 500 : 0);
      });
      dir *= -1;
    }
    
    
    override function update(dt:Float) {
      super.update(dt);
      Slide.step(dt);
    }

    override function onResize() {
      super.onResize();
    }
    
    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
 
}
 
