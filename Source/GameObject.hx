package;

import openfl.display.Sprite;
import openfl.events.Event;

class GameObject extends Sprite {

  public function new() {
    super();

    addEventListener(Event.ENTER_FRAME, function(event:Event) {
      update(60/1000);
    });
  }

  public function update(delta:Float): Void {

  }

}
