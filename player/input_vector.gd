extends Node

class_name InputVector

var vector = Vector3.ZERO


func _process(delta: float) -> void:
	vector.x = Input.get_axis("move_left", "move_right")
	vector.z = -Input.get_axis("move_backward", "move_forward")
