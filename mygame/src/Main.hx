package;
class Main extends hxd.App {
  
    override function init() {
      hxd.Res.initEmbed();
       
      var tile = hxd.Res.hashlink.toTile();
      
      var bmp = new h2d.Bitmap(tile, new h2d.Object(s2d));
    }
    static function main() {
        new Main();
    }
}