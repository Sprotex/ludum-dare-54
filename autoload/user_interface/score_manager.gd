extends Node


var score = 0:
  set(value):
    score = value
    MessageBus.on_score_changed.emit(score)


func _reset() -> void:
  score = 0


func _ready() -> void:
  MessageBus.on_scene_reloaded.connect(_reset)
  MessageBus.on_enemy_died.connect(func(_enemy): score += 1)
