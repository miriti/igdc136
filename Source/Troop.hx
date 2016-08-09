package ;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;
import motion.Actuate;
import motion.easing.Linear;

class Troop extends GameObject  {
  static var bitmapData: Map<String, BitmapData> = new Map<String, BitmapData>();
  var bitmap: Bitmap;

  var jump_phase: Float;

  var target_x:Float;
  var target_y:Float;

  var moving:Bool = false;
  var fighting:Bool = false;

  public var healthPoints:Float = 10;

  public function new() {
    super();

    jump_phase = Math.random() * Math.PI;
  }

  public function hit(pt:Float): Void {
    healthPoints -= pt;

    if(healthPoints <= 0) {
      parent.removeChild(this);
    }
  }

  function initBitmap(name:String) : Void {
    if(!bitmapData.exists(name)) {
      bitmapData[name] = Assets.getBitmapData("assets/" + name + ".png");
    }

    bitmap = new Bitmap(bitmapData[name]);
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;

    addChild(bitmap);
  }

  function isEnemy(penemy:Troop) : Bool {
    return false;
  }

  public function getField(): GameField {
    return cast(parent, GameField);
  }

  public function getEnemies() : Array<Troop> {
    return [];
  }

  public function goto(new_x:Float, new_y:Float, imm:Bool):Void {
    target_x = new_x;
    target_y = new_y;

    if(new_x > x) {
      scaleX = 1;
    }else{
      scaleX = -1;
    }

    if(imm) {
      x = new_x;
      y = new_y;
    } else {
      moving = true;
      var len = Math.sqrt(Math.pow(new_x-x, 2) + Math.pow(new_y - y, 2));

      Actuate.tween(this, len/100, {x:new_x,y:new_y}).ease(Linear.easeNone).onComplete(function() {
        moving = false;
      });
    }
  }

  public override function update(delta:Float):Void {
    if(moving) {
      bitmap.y = -bitmap.width / 2 + Math.sin(jump_phase) * 2;
      jump_phase += (Math.PI * 3) * delta;
    } else {
      bitmap.y = -bitmap.width / 2;
    }

    if(fighting) {
    } else {
      var enemies:Array<Troop> = getEnemies();

      if((enemies != null) && (enemies.length > 0)) {
        Actuate.stop(this);
        fighting = true;
        enemies.sort(function(a,b) {
          return Math.random() > 0.5 ? -1 : 1;
          });

          enemies[0].hit(2.5);

          Actuate.tween(this, 0.1, {rotation: -20*scaleX}).onComplete(function() {
            Actuate.tween(this, 0.1, {rotation: 0}).onComplete(function() {
              fighting = false;
              goto(target_x, target_y, false);
            });
          });
      }
    }
  }

}
