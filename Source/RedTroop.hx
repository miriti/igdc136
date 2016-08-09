package;

class RedTroop extends Troop {
  public function new() {
    super();

    initBitmap("red_troop");
  }

  override function getEnemies(): Array<Troop> {
    return getField().getTroops().filter(function(t:Troop) {
      var len:Float = Math.pow(x - t.x, 2) + Math.pow(y - t.y, 2);
      return ((len <= Math.pow(30, 2)) && (Std.is(t, BlueTroop)));
    });
  }

}
