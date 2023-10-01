extends Node3D

@export var enemy_death_respawn_period := 1.0
@export var start_spawn_count := 2
@export var min_path_offset := 1.0
@export var max_path_offset := 2.0
@export var path_follow: PathFollow3D
@export var enemy_scenes: Array[PackedScene]
@export var upgrade_spawner_timer: Timer

@onready var random = RandomNumberGenerator.new()


func select_random(array: Array) -> Variant:
  var index = random.randi_range(0, len(array) - 1)
  return array[index]


func _spawn_enemy() -> void:
  path_follow.progress_ratio = random.randf()
  var offset = random.randf_range(min_path_offset, max_path_offset)
  var enemy_scene = select_random(enemy_scenes)
  var instance = enemy_scene.instantiate()
  instance.position = Vector3.DOWN * 50.0
  MessageBus.on_object_created.emit(instance)
  instance.global_position = path_follow.global_position + path_follow.basis.x * offset


func _respawn_enemy() -> void:
  await get_tree().create_timer(enemy_death_respawn_period).timeout
  _spawn_enemy()


func _ready() -> void:
  await get_tree().create_timer(enemy_death_respawn_period).timeout
  for i in start_spawn_count:
    _spawn_enemy()
  MessageBus.on_enemy_died.connect(_respawn_enemy)
  upgrade_spawner_timer.timeout.connect(_spawn_enemy)
  upgrade_spawner_timer.timeout.connect(func(): upgrade_spawner_timer.start())
