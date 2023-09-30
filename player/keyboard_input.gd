extends Node

class_name KeyboardInput

@export var inputs: Inputs


func _process(delta: float) -> void:
	inputs.movement.x = Input.get_axis("move_left", "move_right")
	inputs.movement.z = Input.get_axis("move_forward", "move_backward")
