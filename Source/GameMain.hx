package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;

class GameMain extends Sprite  {
  var gameField:GameField;
  var dragging:Bool = false;
  var dragging_current:Point = new Point();
  var dragging_last:Point = new Point();

  var group:TroopGroup = new TroopGroup();

  public function new() {
    super();

    gameField = new GameField();
    addChild(gameField);

    for(i in 0...5*10) {
        var t = new Troop();
        group.add(t);
        gameField.addChild(t);
    }

    group.goto(0, 0, true, gameField);

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
  }

  /**
   * ADDED_TO_STAGE
   */
  public function onAddedToStage(event:Event) : Void {
    stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
    stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
    stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);

    stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDown);
    stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
  }

  public function onStageMouseDown(event:MouseEvent) : Void {
    if(GameInput.getInstance().isSpace()) {
      dragging = true;
      dragging_current.x = stage.mouseX;
      dragging_current.y = stage.mouseY;
    }
  }

  public function onStageMouseMove(event:MouseEvent): Void {
    if(dragging) {
      var draggin_delta = new Point();
      draggin_delta.x = stage.mouseX - dragging_current.x;
      draggin_delta.y = stage.mouseY - dragging_current.y;

      dragging_current.x = stage.mouseX;
      dragging_current.y = stage.mouseY;

      gameField.x += draggin_delta.x;
      gameField.y += draggin_delta.y;
    }
  }

  public function onStageMouseUp(event:MouseEvent) : Void {
    if (!dragging) {
      var pos = gameField.globalToLocal(new Point(stage.mouseX, stage.mouseY));

      group.goto(pos.x, pos.y, false, gameField);
    } else {
      dragging = false;
    }
  }

  public function onStageKeyDown(event:KeyboardEvent) : Void {
    GameInput.getInstance().keyDown(event.keyCode);
  }

  public function onStageKeyUp(event:KeyboardEvent) : Void {
    GameInput.getInstance().keyUp(event.keyCode);
  }

  /**
   * REMOVED_FROM_STAGE
   */
  public function onRemovedFromStage(event:Event) : Void {
    stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
    stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);

    stage.removeEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDown);
    stage.removeEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
  }
}
