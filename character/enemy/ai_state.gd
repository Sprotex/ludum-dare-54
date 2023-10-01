extends Node

class_name AIState

signal on_ai_state_enabled
signal on_ai_state_disabled


@export var next_state: AIState
@export var enabled = true:
  set(value):
    if enabled == value:
      return
    enabled = value
    if enabled:
      on_ai_state_enabled.emit()
      return
    on_ai_state_disabled.emit()
    next_state.enabled = true



func wait_for(wait_time: float) -> SceneTreeTimer:
  return get_tree().create_timer(wait_time)


func _ready():
  set_process(enabled)
  on_ai_state_enabled.connect(_handle_ai_state_enabled)
  on_ai_state_disabled.connect(_handle_ai_state_disabled)
  if enabled:
    on_ai_state_enabled.emit()


func _handle_ai_state_enabled() -> void:
  pass


func _handle_ai_state_disabled() -> void:
  pass