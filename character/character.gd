extends CharacterBody3D

class_name Character

@export var type: Enums.CharacterType
var health: Health

func set_health() -> void:
  for child in get_children():
    if not child is Health:
      continue
    health = child
    return


func die() -> void:
  if type == Enums.CharacterType.PLAYER:
    MessageBus.on_player_died.emit()
    return
  if type == Enums.CharacterType.ENEMY:
    MessageBus.on_enemy_died.emit()
  queue_free()


func _ready() -> void:
  set_health()
