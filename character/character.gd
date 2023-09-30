extends CharacterBody3D

class_name Character

enum Type { OTHER, PLAYER, ENEMY  }

@export var type: Character.Type
var health: Health

func set_health() -> void:
  for child in get_children():
    if not child is Health:
      continue
    health = child
    return


func die() -> void:
  if type == Type.PLAYER:
    MessageBus.on_player_died.emit()
    return
  if type == Type.ENEMY:
    MessageBus.on_enemy_died.emit()
  queue_free()


func _ready() -> void:
  set_health()
