extends Node

class_name CharacterMovement

@export var character_body: CharacterBody3D
@export var inputs: CharacterInputs
@export var movement_speed := 3.0
@export var rotation_speed := 1.0

func get_gravity_vector() -> Vector3:
  return ProjectSettings.get_setting("physics/3d/default_gravity_vector")


func get_gravity_magnitude() -> float:
  return ProjectSettings.get_setting("physics/3d/default_gravity")


# NOTE(Andy): To be overriden.
func calculate_movement(_initial_movement: Vector3, _delta: float) -> Vector3:
  return character_body.global_transform.basis * inputs.movement * movement_speed


func move(delta: float) -> void:
  character_body.velocity = calculate_movement(character_body.velocity, delta)
  character_body.move_and_slide()


func rotate(_delta: float) -> void:
  var rotation = inputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  character_body.rotate_y(deg_to_rad(-rotation.x))


func _physics_process(delta: float) -> void:
  move(delta)
  rotate(delta)
