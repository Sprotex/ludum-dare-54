extends AIState

@export var character_movement: CharacterMovement
@export var inputs: CharacterInputs

var max_walk_distance = 10.0


signal on_turn_completed
signal on_move_completed


func _turn() -> void:
  var final_rotation = 1.0
  var rotation_time = final_rotation / character_movement.rotation_speed
  inputs.rotation = Vector2.RIGHT * final_rotation
  await wait_for(rotation_time).timeout
  inputs.rotation = Vector2.ZERO
  on_turn_completed.emit()


func _move() -> void:
  var move_distance = max_walk_distance / character_movement.movement_speed
  var move_time = move_distance / character_movement.movement_speed
  inputs.movement = Vector3.FORWARD
  await wait_for(move_time).timeout
  inputs.movement = Vector3.ZERO
  on_move_completed.emit()


func _handle_ai_state_enabled() -> void:
  _turn()
  await on_turn_completed
  _move()
  await on_move_completed
  enabled = false