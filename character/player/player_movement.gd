extends CharacterMovement

class_name PlayerMovement

@export var jump_power := 1.0
@export var friction_multiplier := 0.6
@export var air_friction_multiplier := 0.95
@export var air_movement_multiplier := 0.1


func calculate_movement(initial_movement: Vector3, delta: float) -> Vector3:
  var movement = calculate_lateral_movement(initial_movement)
  movement = calculate_jump_movement(movement)
  movement = calculate_gravity_movement(movement, delta)
  movement = calculate_friction_movement(movement)
  return movement


func calculate_jump_movement(current_movement: Vector3) -> Vector3:
  if not character_body.is_on_floor():
    current_movement.y = 0
    return current_movement
  if inputs.movement.y <= 0:
    current_movement.y = 0
    return current_movement
  return current_movement - get_gravity_vector() * jump_power


func calculate_friction_movement(current_movement: Vector3) -> Vector3:
  current_movement.y += character_body.velocity.y
  var current_friction_multiplier = friction_multiplier
  if not character_body.is_on_floor():
    current_friction_multiplier = air_friction_multiplier
  var movement_multiplier = Vector3(current_friction_multiplier, 1.0, current_friction_multiplier)
  return current_movement * movement_multiplier


func calculate_lateral_movement(current_movement: Vector3) -> Vector3:
  var current_movement_delta = character_body.global_transform.basis * inputs.movement * movement_speed
  if not character_body.is_on_floor():
    current_movement_delta *= air_movement_multiplier
  current_movement += current_movement_delta
  return current_movement
