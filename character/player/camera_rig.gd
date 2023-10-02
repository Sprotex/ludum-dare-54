extends Node3D

class_name CameraRig

@export var rotation_speed := 1.0
@export var limit_scale = 0.99
@export var raycast: RayCast3D
@export var camera: Camera3D
@export var inputs: PlayerInputs

@onready var camera_starting_point = camera.transform.origin


func _set_camera_position() -> void:
  if inputs.camera_swap:
    transform.origin.x = -transform.origin.x
  if raycast.is_colliding():
    camera.global_transform.origin = raycast.get_collision_point()
  else:
    camera.transform.origin = camera_starting_point


func _process(_delta: float) -> void:
  var local_rotation = GameInputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  rotation.x = clamp(rotation.x + deg_to_rad(local_rotation.y), -TAU * .25 * limit_scale, TAU * .25 * limit_scale)
  _set_camera_position()
