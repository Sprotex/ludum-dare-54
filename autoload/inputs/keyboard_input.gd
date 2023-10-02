extends Node


func _process(_delta: float) -> void:
  GameInputs.movement.x = Input.get_axis("move_left", "move_right")
  GameInputs.movement.z = Input.get_axis("move_forward", "move_backward")
  GameInputs.movement.y = Input.get_action_strength("jump")
  GameInputs.camera_swap = Input.is_action_just_pressed("camera_swap")
