extends AIState

@export var character_movement: CharacterMovement
@export var inputs: CharacterInputs

var max_walk_distance = 10.0


func _handle_ai_state_enabled() -> void:
  turn(inputs, character_movement, TAU)
  await on_turn_completed
  move(inputs, character_movement, max_walk_distance)
  await on_move_completed
  enabled = false
