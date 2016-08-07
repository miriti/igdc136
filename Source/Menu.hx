package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.Event;
import motion.Actuate;

class Menu extends Sprite {

  public function new() {
    super();

    alpha = 0;

    var menuBg = new Bitmap(Assets.getBitmapData("assets/menu_bg.png"));
    menuBg.y = 720 - menuBg.height;

    addChild(menuBg);

    var logo = new Bitmap(Assets.getBitmapData("assets/game_logo.png"));
    logo.x = (1280-logo.width)/2;
    logo.y = 20;

    addChild(logo);

    var btnPlay = new Bitmap(Assets.getBitmapData("assets/btn_play.png"));
    btnPlay.x = (1280 - btnPlay.width) / 2;
    btnPlay.y = (720 - 250/2);
    addChild(btnPlay);

    addEventListener(Event.ADDED_TO_STAGE, function name(event:Event) {
      Actuate.tween(this, 1, {alpha: 1});
    });

  }

}
