extends AIState

class_name WaitState

@export var wait_time := 1.0


func _handle_ai_state_enabled() -> void:
  await wait_for(wait_time).timeout
  enabled = false