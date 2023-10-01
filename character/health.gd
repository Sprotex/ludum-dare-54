extends Node

class_name Health

@export var character_body: Character
@export var max_health := 3
@onready var health = max_health


func take_damage() -> void:
  health -= 1
  if health <= 0:
    character_body.die()
