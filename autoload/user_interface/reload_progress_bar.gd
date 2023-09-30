extends Range

class_name ReloadProgressBar


func _ready() -> void:
  MessageBus.on_player_shot.connect(_handle_player_shot)


func _handle_player_shot(reload_time: float) -> void:
  var tween = get_tree().create_tween()
  tween.tween_property(self, "value", 1.0, reload_time).from(0.0)