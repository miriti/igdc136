package;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class GameButton extends Sprite {
  public function new(content:DisplayObject) {
    super();

    content.x = -content.width / 2;
    content.y = -content.height / 2;
    addChild(content);

    buttonMode = true;
    addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent) {
      alpha = 0.8;
    });

    addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent) {
      alpha = 1;
    });
  }
}
