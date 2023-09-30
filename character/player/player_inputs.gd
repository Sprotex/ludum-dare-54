extends CharacterInputs

class_name PlayerInputs


func _process(_delta: float) -> void:
  movement = GameInputs.movement
  rotation = GameInputs.rotation
  shooting = GameInputs.shooting
  