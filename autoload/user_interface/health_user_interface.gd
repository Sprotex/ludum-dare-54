extends HBoxContainer

@export var heart_scene: PackedScene


func _reset() -> void:
  _add_hearts(3)


func _ready() -> void:
  _reset()
  MessageBus.on_player_health_changed.connect(_handle_player_health_changed)
  MessageBus.on_scene_reloaded.connect(_reset)


func _remove_hearts(count: int) -> void:
  for i in count:
    remove_child(get_child(0))


func _add_hearts(count: int) -> void:
  for i in count:
    var instance = heart_scene.instantiate()
    add_child(instance)


func _handle_player_health_changed(hearts: int) -> void:
  var current_hearts = get_child_count()
  var change = abs(hearts - current_hearts)
  print(change)
  if hearts < current_hearts:
    _remove_hearts(change)
    return
  _add_hearts(change)
    