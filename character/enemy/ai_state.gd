extends Node

class_name AIState

signal on_ai_state_enabled
signal on_ai_state_disabled

signal on_turn_completed
signal on_move_completed
signal on_wait_timeout


func wait_for(wait_time: float) -> void:
  await get_tree().create_timer(wait_time).timeout
  on_wait_timeout.emit()


func turn(inputs: EnemyInputs, character_movement: CharacterMovement, rotation: float) -> void:
  var rotation_time = abs(rotation) / character_movement.rotation_speed
  inputs.rotation = Vector2.RIGHT * sign(rotation)
  wait_for(rotation_time)
  await on_wait_timeout
  inputs.rotation = Vector2.ZERO
  on_turn_completed.emit()


func move(inputs: EnemyInputs, character_movement: CharacterMovement, distance: float) -> void:
  var move_distance = distance / character_movement.movement_speed
  var move_time = move_distance / character_movement.movement_speed
  inputs.movement = Vector3.FORWARD
  wait_for(move_time)
  await on_wait_timeout
  inputs.movement = Vector3.ZERO
  on_move_completed.emit()


@export var next_state: AIState
@export var enabled = false:
  set(value):
    if enabled == value:
      return
    enabled = value
    if enabled:
      on_ai_state_enabled.emit()
      return
    on_ai_state_disabled.emit()
    next_state.enabled = true



func _ready():
  set_process(enabled)
  on_ai_state_enabled.connect(_handle_ai_state_enabled)
  on_ai_state_disabled.connect(_handle_ai_state_disabled)
  if enabled:
    on_ai_state_enabled.emit()
  _ai_state_ready()


func _ai_state_ready():
  pass


func _handle_ai_state_enabled() -> void:
  pass


func _handle_ai_state_disabled() -> void:
  pass
