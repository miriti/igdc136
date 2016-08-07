package;

import openfl.events.Event;
import openfl.display.Sprite;
import motion.Actuate;

class Main extends Sprite {

	public function new () {
		super ();

		var intro = new Intro();
		addChild(intro);

		intro.addEventListener("end", function(event:Event) {
			removeChild(intro);
			var menu = new Menu();

			menu.addEventListener("start_game", function(event:Event) {
				Actuate.tween(menu, 1, {alpha: 0}).onComplete(function(event) {
					removeChild(menu);

					var gameMain = new GameMain();
					addChild(gameMain);
				});
			});

			addChild(menu);
		});

	}


}
