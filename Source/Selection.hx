package ;

import openfl.display.Sprite;

class Selection extends Sprite {
  public var selWidth(default, set):Float;
  public var selHeight(default, set):Float;

  function drawSelection() : Void {
    if((selWidth > 0) && (selHeight > 0)) {
      graphics.clear();
      graphics.beginFill(0xb60f13, 0.3);
      graphics.drawRect(0, 0, selWidth, selHeight);
      graphics.endFill();
    }
  }

  public function set_selWidth(value:Float):Float {
    drawSelection();
    return selWidth = value;
  }

  public function set_selHeight(value:Float):Float {
    drawSelection();
    return selHeight = value;
  }

  public function new() {
    super();

    selWidth = selHeight = 0;
  }

}
