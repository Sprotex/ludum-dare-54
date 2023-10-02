extends WorldEnvironment

@export var increase_per_bullet := 0.1
@export var max_light_energy := 3.0

var bullet_count := 0


func _increase_light_energy() -> void:
  bullet_count += 1
  _set_light_energy()


func _decrease_light_energy() -> void:
  bullet_count -= 1
  _set_light_energy()


func _set_light_energy() -> void:
  var value = increase_per_bullet * bullet_count
  var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
  tween.tween_property(environment, "ambient_light_energy", clampf(value, 0.0, max_light_energy), 0.1)


func _reset() -> void:
  bullet_count = 0
  _set_light_energy()


func _ready() -> void:
  MessageBus.on_scene_reloaded.connect(_reset)
  MessageBus.on_bullet_shot.connect(_increase_light_energy)
  MessageBus.on_bullet_deleted.connect(_decrease_light_energy)
