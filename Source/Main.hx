package;


import openfl.display.Sprite;
import motion.Actuate;
import openfl.events.Event;

class Main extends Sprite {


	public function new () {

		super ();

		var intro = new Intro();
		addChild(intro);

		intro.addEventListener("end", function(event:Event) {
			removeChild(intro);
			addChild(new Menu());
		});

	}


}
