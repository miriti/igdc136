package;


class GameInput  {
  private static var _instance = null;
  var keys:Map<Int,Bool> = new Map<Int,Bool>();

  public function new() {
    for(i in 0...256) {
      keys[i] = false;
    }
  }

  public static function getInstance() : GameInput {
    if(_instance == null) {
      _instance = new GameInput();
    }

    return _instance;
  }

  public function keyDown(code:Int): Void {
    keys[code] = true;
  }

  public function keyUp(code:Int):Void {
    keys[code] = false;
  }

  public function isSpace(): Bool {
    return keys[32];
  }

}
