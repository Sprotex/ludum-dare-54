extends Node


func _handle_movement(event: InputEvent) -> void:
  if not event is InputEventMouseMotion:
    return
  GameInputs.rotation += event.relative


func _handle_buttons(event: InputEvent) -> void:
  if not event is InputEventMouseButton:
    return
  GameInputs.shooting = event.pressed


func _zero_rotation() -> void:
  GameInputs.rotation = Vector2.ZERO


func _physics_process(_delta: float) -> void:
  _zero_rotation.call_deferred()


func _unhandled_input(event: InputEvent) -> void:
  _handle_movement(event)
  _handle_buttons(event)
