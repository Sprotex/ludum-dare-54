extends CharacterInputs

class_name PlayerInputs


var camera_swap := false


func _ready() -> void:
  MessageBus.on_player_died.connect(_handle_player_died, CONNECT_DEFERRED)


func _handle_player_died() -> void:
  set_process(false)
  movement = Vector3.ZERO
  rotation = Vector3.ZERO
  shooting = false


func _process(_delta: float) -> void:
  movement = GameInputs.movement
  rotation = GameInputs.rotation
  shooting = GameInputs.shooting
  camera_swap = GameInputs.camera_swap
  