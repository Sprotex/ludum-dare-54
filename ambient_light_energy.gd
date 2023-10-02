extends WorldEnvironment

@export var increase_per_bullet := 0.1
@export var max_light_energy := 3.0

var bullet_count := 0


func _increase_light_energy() -> void:
  bullet_count += 1
  _set_light_energy(increase_per_bullet * bullet_count)


func _decrease_light_energy() -> void:
  bullet_count -= 1
  _set_light_energy(increase_per_bullet * bullet_count)


func _set_light_energy(value: float) -> void:
  environment.ambient_light_energy = clampf(value, 0.0, max_light_energy)


func _ready() -> void:
  MessageBus.on_bullet_shot.connect(_increase_light_energy)
  MessageBus.on_bullet_deleted.connect(_decrease_light_energy)
