package;

import openfl.events.Event;
import openfl.display.Sprite;
import motion.Actuate;

class Main extends Sprite {
	var debug:Bool = true;

	public function new () {
		super ();

		if(debug) {
			startGame();
		} else {
			var intro = new Intro();
			addChild(intro);

			intro.addEventListener("end", function(event:Event) {
				removeChild(intro);
				var menu = new Menu();

				menu.addEventListener("start_game", function(event:Event) {
					Actuate.tween(menu, 1, {alpha: 0}).onComplete(function(event) {
						removeChild(menu);

					startGame();
					});
				});

				addChild(menu);
			});
		}

	}

	function startGame() : Void {
		var gameMain = new GameMain();
		gameMain.x = 1280 / 2;
		gameMain.y = 720 / 2;
		addChild(gameMain);
	}


}
