extends Node3D

class_name CameraRig

@export var rotation_speed := 1.0
@export var limit_scale = 0.99
@export var raycast: RayCast3D
@export var camera: Camera3D
@export var inputs: PlayerInputs
@export var character_body: Character

@onready var camera_starting_point = camera.transform.origin
@onready var camera_side = position.x


func _ready() -> void:
  raycast.add_exception(character_body)


func _set_camera_position() -> void:
  if inputs.camera_swap:
    camera_side *= -1
    var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
    var target_position = Vector3(camera_side, position.y, position.z)
    tween.tween_property(self, "position", target_position, 0.5)
  if raycast.is_colliding():
    camera.global_position = raycast.get_collision_point()
  else:
    camera.position = camera_starting_point


func _process(_delta: float) -> void:
  var local_rotation = GameInputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  rotation.x = clamp(rotation.x + deg_to_rad(local_rotation.y), -TAU * .25 * limit_scale, TAU * .25 * limit_scale)
  _set_camera_position()
