extends AIState

@export var inputs: EnemyInputs


func _handle_ai_state_enabled() -> void:
  inputs.shooting = true
  wait_for(0.0)
  await on_wait_timeout
  inputs.shooting = false
  enabled = false
