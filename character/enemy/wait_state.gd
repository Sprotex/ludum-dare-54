extends AIState

class_name WaitState

@export var wait_time := 1.0


func _handle_ai_state_enabled() -> void:
  wait_for(wait_time)
  await on_wait_timeout
  enabled = false
