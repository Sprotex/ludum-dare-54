extends CharacterInputs

class_name PlayerInputs


func _ready() -> void:
  MessageBus.on_player_died.connect(_handle_player_died)


func _handle_player_died() -> void:
  set_process(false)
  movement = Vector3.ZERO
  rotation = Vector2.ZERO
  shooting = false


func _process(_delta: float) -> void:
  movement = GameInputs.movement
  rotation = GameInputs.rotation
  shooting = GameInputs.shooting
  