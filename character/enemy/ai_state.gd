extends Node

class_name AIState

signal on_ai_state_enabled
signal on_ai_state_disabled

signal on_transformation_finished
signal on_wait_timeout

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


func wait_for(wait_time: float) -> void:
  await get_tree().create_timer(wait_time).timeout
  on_wait_timeout.emit()


func _transform(inputs: EnemyInputs, character_movement: CharacterMovement, difference: float, type: Enums.TransformType) -> void:
  var speed = character_movement.movement_speed
  var value_name = "movement"
  var value = Vector3.FORWARD
  if type == Enums.TransformType.TURN:
    speed = character_movement.rotation_speed
    value_name = "rotation"
    value = Vector3.RIGHT * sign(difference)
  var transformation_time = abs(difference) / speed
  inputs.set(value_name, value)
  wait_for(transformation_time)
  await on_wait_timeout
  inputs.set(value_name, Vector3.ZERO)
  on_transformation_finished.emit()
  

func turn(inputs: EnemyInputs, character_movement: CharacterMovement, rotation: float) -> void:
  _transform(inputs, character_movement, rotation, Enums.TransformType.TURN)


func move(inputs: EnemyInputs, character_movement: CharacterMovement, distance: float) -> void:
  _transform(inputs, character_movement, distance, Enums.TransformType.MOVE)


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
