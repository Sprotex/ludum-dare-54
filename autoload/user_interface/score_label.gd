extends Label

class_name ScoreLabel


func _ready():
  MessageBus.on_score_changed.connect(_handle_score_changed)


func _handle_score_changed(score: int) -> void:
  text = str(score)
  Common.do_emphasis(self, "scale")