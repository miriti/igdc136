package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;
import motion.Actuate;

class Intro extends Sprite {

  var logo:Bitmap;

  public function new() {
    super();

    logo = new Bitmap(Assets.getBitmapData("assets/igdc_logo.png"));

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

  }

  private function onAddedToStage(e:Event) {
    addChild(logo);

    Actuate.tween(logo, 1, {alpha: 0}).delay(1.5).onComplete(function() {
      endIntro();
    });
  }

  private function endIntro() : Void {
    dispatchEvent(new Event("end"));
  }
}
