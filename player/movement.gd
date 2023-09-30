extends Node

@export var character_body: CharacterBody3D
@export var inputs: CharacterInputs
@export var movement_speed := 3.0
@export var rotation_speed := 1.0
@export var jump_power := 10.0


func get_gravity_vector() -> Vector3:
  return ProjectSettings.get_setting("physics/3d/default_gravity_vector")


func get_gravity_magnitude() -> float:
  return ProjectSettings.get_setting("physics/3d/default_gravity")


func calculate_jump_movement(current_movement: Vector3) -> Vector3:
  if not character_body.is_on_floor():
    current_movement.y = 0
    return current_movement
  if inputs.movement.y <= 0:
    current_movement.y = 0
    return current_movement
  return current_movement - get_gravity_vector() * jump_power


func calculate_gravity_movement(current_movement: Vector3, _delta: float) -> Vector3:
  if character_body.is_on_floor():
    return current_movement
  return current_movement + get_gravity_vector() * get_gravity_magnitude() * _delta


func calculate_friction_movement(current_movement: Vector3) -> Vector3:
  current_movement.y += character_body.velocity.y
  var friction_multiplier = Vector3(0.8, 1.0, 0.8)
  if character_body.is_on_floor():
    return current_movement * friction_multiplier
  return current_movement


func move(delta: float) -> void:
  var local_movement = character_body.global_transform.basis * inputs.movement * movement_speed + character_body.velocity
  local_movement = calculate_jump_movement(local_movement)
  local_movement = calculate_gravity_movement(local_movement, delta)
  local_movement = calculate_friction_movement(local_movement)
  character_body.velocity = local_movement
  character_body.move_and_slide()


func rotate(_delta: float) -> void:
  var rotation = inputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  character_body.rotate_y(deg_to_rad(-rotation.x))


func _physics_process(delta: float) -> void:
  move(delta)
  rotate(delta)
