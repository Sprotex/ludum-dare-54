extends Node

class_name MouseInput

@export var inputs: Inputs


func _ready() -> void:
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
  if not event is InputEventMouseMotion:
    return
  inputs.rotation += event.relative


func _physics_process(_delta: float) -> void:
  inputs.set_deferred("rotation", Vector2.ZERO)