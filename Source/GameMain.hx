package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class GameMain extends GameObject  {
  var gameField:GameField;

  /**
   * Dragging
   */
  var dragging:Bool = false;
  var dragging_current:Point = new Point();
  var dragging_last:Point = new Point();

  /**
   * Selection
   */
  var selection_start:Point;
  var selection:Selection;
  var selection_group:TroopGroup;

  public function new() {
    super();

    var policeGroup:TroopGroup = new TroopGroup();
    var group:TroopGroup = new TroopGroup();

    gameField = new GameField();
    addChild(gameField);

    for(i in 0...50) {
        var t = new RedTroop();
        group.add(t);
        gameField.addTroop(t);
    }

    group.goto(300, 0, true, gameField);

    for(i in 0...50) {
      var p = new BlueTroop();
      policeGroup.add(p);
      gameField.addTroop(p);
    }

    policeGroup.goto(-300, 0, true, gameField);

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
    } else {
      var pos:Point = globalToLocal(new Point(stage.mouseX, stage.mouseY));

      if(selection_group!=null) {
        selection_group.goto(pos.x, pos.y, false, gameField);
        selection_group = null;
      }else{

        selection_start = pos;

        selection = new Selection();
        selection.x = pos.x;
        selection.y = pos.y;
        addChild(selection);

      }
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

    if(selection != null) {

    }
  }

  public function onStageMouseUp(event:MouseEvent) : Void {
    if (!dragging) {
      removeChild(selection);
      selection = null;
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

  override function update(delta:Float) : Void {
    if(selection != null) {
      var pos:Point = globalToLocal(new Point(stage.mouseX, stage.mouseY));
      var delta:Point = new Point(pos.x - selection_start.x, pos.y - selection_start.y);

      if(pos.x < selection_start.x) {
        selection.x = pos.x;
      }

      if(pos.y < selection_start.y) {
        selection.y = pos.y;
      }

      selection.selWidth = Math.abs(delta.x);
      selection.selHeight = Math.abs(delta.y);

      var sel_rect:Rectangle = new Rectangle(selection.x, selection.y, selection.selWidth, selection.selHeight);

      var red_troops:Array<Troop> = gameField.getTroops().filter(function(t:Troop) {
        return Std.is(t, RedTroop);
      });

      for(tr in red_troops) {
        var bound:Rectangle = tr.getBounds(this);
        if(sel_rect.intersects(bound)) {
          tr.selected = true;
        }else{
          tr.selected = false;
        }
      }

      selection_group = new TroopGroup();
      var selected_troops:Array<Troop> = red_troops.filter(function(troop) {
        if(troop.selected) {
          selection_group.add(troop);
        }
        return troop.selected;
      });

      if(selected_troops.length==0) {
        selection_group = null;
      }
    }
  }
}
