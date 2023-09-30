extends Label

class_name ScoreLabel


func _ready():
  MessageBus.on_score_changed.connect(func(score): text = str(score))
