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
    print("player ded")
    return
  queue_free()


func _ready() -> void:
  set_health()
