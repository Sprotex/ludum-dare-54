extends Node

class_name CharacterMovement

@export var character_body: CharacterBody3D
@export var inputs: CharacterInputs
@export var movement_speed := 3.0
@export var rotation_speed := 1.0
@export var retain_movement_scale := 1.0

func get_gravity_vector() -> Vector3:
  return ProjectSettings.get_setting("physics/3d/default_gravity_vector")


func get_gravity_magnitude() -> float:
  return ProjectSettings.get_setting("physics/3d/default_gravity")


func calculate_gravity_movement(current_movement: Vector3, _delta: float) -> Vector3:
  if character_body.is_on_floor():
    return current_movement
  return current_movement + get_gravity_vector() * get_gravity_magnitude() * _delta

# NOTE(Andy): To be overriden.
func calculate_movement(_initial_movement: Vector3, _delta: float) -> Vector3:
  _initial_movement.x = 0.0
  _initial_movement.z = 0.0
  var movement = calculate_gravity_movement(_initial_movement * retain_movement_scale, _delta)
  return character_body.global_transform.basis * inputs.movement * movement_speed + movement


func move(delta: float) -> void:
  character_body.velocity = calculate_movement(character_body.velocity, delta)
  character_body.move_and_slide()


func rotate(_delta: float) -> void:
  var rotation = inputs.rotation * rotation_speed
  character_body.rotate_y(deg_to_rad(-rotation.x))


func _physics_process(delta: float) -> void:
  move(delta)
  rotate(delta)
