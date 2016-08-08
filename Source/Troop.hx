package ;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;
import motion.Actuate;

class Troop extends GameObject  {

  static var bitmapData: BitmapData = null;

  var bitmap: Bitmap;
  var jump_phase: Float;

  var target_x:Float;
  var target_y:Float;

  public function new() {
    super();

    jump_phase = Math.random() * Math.PI;

    if(bitmapData == null) {
      bitmapData = Assets.getBitmapData("assets/red_troop.png");
    }

    bitmap = new Bitmap(bitmapData);
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;

    addChild(bitmap);
  }

  public function goto(new_x:Float, new_y:Float, imm:Bool):Void {
    if(imm) {
      target_x = x = new_x;
      target_y = y = new_y;
    } else {
      var len = Math.sqrt(Math.pow(new_x-x, 2) + Math.pow(new_y - y, 2));

      Actuate.tween(this, len/100, {x:new_x,y:new_y});
    }
  }

  public override function update(delta:Float):Void {
    bitmap.y = -bitmap.width / 2 + Math.sin(jump_phase) * 2;
    jump_phase += (Math.PI * 3) * delta;
  }

}
