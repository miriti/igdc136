package ;

import openfl.display.Sprite;
import openfl.geom.Point;

class TroopGroup {
  var troops:Array<Troop> = new Array<Troop>();
  var groupWidth:Int = 5;

  /**
   * Constructor
   */
  public function new() {}

  /**
   * Clear the group
   */
  public function clear() {
    troops = new Array<Troop>();
  }

  /**
   * Add a troop to the group
   */
  public function add(troop: Troop): Void {
    troops.push(troop);
  }

  /**
   * Go to
   */
  public function goto(x:Float, y: Float, imm:Bool, at:Sprite): Void {
    troops = troops.filter(function(t) {
      return t.healthPoints>0;
      });

    troops.sort(function(a:Troop,b:Troop):Int {
        var la = Math.pow(x - a.x,2) + Math.pow(y - a.y, 2);
        var lb = Math.pow(x - b.x,2) + Math.pow(y - b.y, 2);
        if(la==lb) return 0;
        return la > lb ? 1 : -1;
    });

    var vector:Point = new Point(troops[0].x - x, troops[0].y - y);
    vector.normalize(1);

    var lmin = Math.pow(x - troops[0].x, 2) + Math.pow(y - troops[0].y, 2);
    var lmax = Math.pow(x - troops[troops.length-1].x, 2) + Math.pow(y - troops[troops.length-1].y, 2);

    var half_col = Math.floor(groupWidth/2);

    var distr = [];

    for(d in -half_col...(half_col+1)) {
      distr.push(d);
    }

    var col = 0;
    var row = 0;

    var space = new Sprite();
    at.addChild(space);
    space.x = x;
    space.y = y;
    space.rotation = ((Math.atan2(vector.y, vector.x) * 180) / Math.PI)-90;

    var troops_queue = troops.copy();

    while(troops_queue.length > 0) {
      var obj = new Sprite();

      obj.graphics.beginFill(0xff0000);
      obj.graphics.drawRect(-10, -10, 20, 20);
      obj.graphics.endFill();

      obj.x = distr[distr.length-1-col] * 30;
      obj.y = row * 30;

      space.addChild(obj);

      var bounds = obj.getBounds(at);

      var new_x = bounds.x;
      var new_y = bounds.y;

      col++;
      if(col == distr.length) {
        col = 0;
        row++;
      }

      troops_queue.sort(function(a:Troop, b:Troop):Int {
          var la = Math.pow(new_x - a.x,2) + Math.pow(new_y - a.y, 2);
          var lb = Math.pow(new_x - b.x,2) + Math.pow(new_y - b.y, 2);
          if(la==lb) return 0;
          return la > lb ? 1 : -1;
      });

      var troop = troops_queue.shift();

      troop.goto(new_x, new_y, imm);
    }

    at.removeChild(space);
  }
}
