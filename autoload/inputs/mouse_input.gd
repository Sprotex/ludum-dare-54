extends Node


func _handle_movement(event: InputEvent) -> void:
  if not event is InputEventMouseMotion:
    return
  var mouse_movement = Vector3(event.relative.x, event.relative.y, 0.0)
  GameInputs.rotation += mouse_movement * Constants.PIXEL_TO_DEGREE_RATIO


func _handle_buttons(event: InputEvent) -> void:
  if not event is InputEventMouseButton:
    return
  if event.button_index != MOUSE_BUTTON_LEFT:
    return
  GameInputs.shooting = event.pressed


func _zero_rotation() -> void:
  GameInputs.rotation = Vector3.ZERO


func _physics_process(_delta: float) -> void:
  _zero_rotation.call_deferred()


func _unhandled_input(event: InputEvent) -> void:
  _handle_movement(event)
  _handle_buttons(event)
