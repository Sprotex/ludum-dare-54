extends CharacterBody3D

class_name Character

@export var type: Enums.CharacterType
@export var health: Health


func die() -> void:
  if type == Enums.CharacterType.PLAYER:
    MessageBus.on_player_died.emit()
    health.queue_free()
    return
  if type == Enums.CharacterType.ENEMY:
    MessageBus.on_enemy_died.emit()
  queue_free()
