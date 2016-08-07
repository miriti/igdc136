package ;

import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

class Troop extends Sprite  {
static var bitmapData: BitmapData = null;

  public function new() {
    super();

    if(bitmapData==null){
      bitmapData = Assets.getBitmapData("assets/red_troop.png");
    }

    var bitmap = new Bitmap(bitmapData);
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;

    addChild(bitmap);

  }

}
