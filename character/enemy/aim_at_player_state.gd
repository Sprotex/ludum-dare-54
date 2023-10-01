extends AIState

@export var inputs: CharacterInputs
@export var character_movement: CharacterMovement
@export var character_body: Character

var player: Character


func _ai_state_ready():
  MessageBus.on_player_object_broadcast.connect(func(player_object): player = player_object)

    
func _handle_ai_state_enabled() -> void:
  if not player:
    MessageBus.on_player_object_requested.emit()
  var forward = -character_body.basis.z
  var direction_to_player = (player.global_transform.origin - character_body.global_transform.origin).normalized()
  var to_player_angle = direction_to_player.signed_angle_to(forward, Vector3.UP)
  turn(inputs, character_movement, to_player_angle)
  await on_transformation_finished
  enabled = false
