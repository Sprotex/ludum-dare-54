extends AIState

@export var character_movement: CharacterMovement
@export var inputs: CharacterInputs
@export var max_walk_distance = 10.0

@onready var random = RandomNumberGenerator.new()


func _handle_ai_state_enabled() -> void:
  var random_rotation = random.randf_range(-TAU * .5, TAU * .5)
  var random_distance = random.randf_range(0.0, max_walk_distance)
  turn(inputs, character_movement, random_rotation)
  await on_turn_completed
  move(inputs, character_movement, random_distance)
  await on_move_completed
  enabled = false
