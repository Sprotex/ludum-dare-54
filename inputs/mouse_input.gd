extends Node


func _ready() -> void:
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
  if not event is InputEventMouseMotion:
    return
  GameInputs.rotation += event.relative


func _zero_rotation() -> void:
  GameInputs.rotation = Vector2.ZERO


func _physics_process(_delta: float) -> void:
  _zero_rotation.call_deferred()
