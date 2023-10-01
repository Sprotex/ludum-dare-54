extends Node

class_name Health

@export var character_body: Character
@export var _max := 3
@onready var current = _max:
  set(value):
    if current == value:
      return
    current = value
    MessageBus.on_player_health_changed.emit(value)
    if current <= 0:
      character_body.die()
