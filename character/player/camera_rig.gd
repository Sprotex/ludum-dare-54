extends Node3D

class_name CameraRig

@export var rotation_speed := 1.0


func _process(_delta: float) -> void:
  var local_rotation = GameInputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  rotate_x(deg_to_rad(-local_rotation.y))
  rotation.x = clamp(rotation.x, -TAU * .25, TAU * .25)
