package ;

import openfl.events.Event;
import openfl.display.Sprite;

class GameField extends Sprite {
  var troops:Array<Troop> = new Array<Troop>();

  public function new() {
    super();
  }

  public function getTroops() : Array<Troop> {
    return troops;
  }

  public function addTroop(troop:Troop) : Void {
    addChild(troop);
    troops.push(troop);
    troop.addEventListener(Event.REMOVED_FROM_STAGE, function(event:Event) {
      troops.remove(troop);
    });
  }

}
