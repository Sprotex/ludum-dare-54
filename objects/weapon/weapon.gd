extends Node3D


@export var character_body: Character
@export var inputs: CharacterInputs
@export var reload_time := 0.5
@export var bullet: PackedScene
@export var firepoint: Node3D
@export var firepoint_direction: Node3D

var is_reloading := false


func shoot() -> void:
  var bullet_instance = bullet.instantiate()
  MessageBus.on_object_created.emit(bullet_instance)
  MessageBus.on_bullet_shot.emit()
  AudioManager.play_audio(global_position, AudioManager.laser_audio)
  bullet_instance.global_position = firepoint.global_position
  bullet_instance.global_rotation = firepoint_direction.global_rotation
  if character_body.type == Enums.CharacterType.PLAYER:
    MessageBus.on_player_shot.emit(reload_time)


func reload() -> void:
  is_reloading = true
  await get_tree().create_timer(reload_time).timeout
  is_reloading = false


func try_shoot() -> void:
  if not inputs.shooting:
    return
  if is_reloading:
    return
  shoot()
  reload()


func _process(_delta) -> void:
  try_shoot()
  
