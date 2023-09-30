extends Node3D


@export var inputs: CharacterInputs
@export var reload_time := 0.5
@export var bullet: PackedScene
@export var firepoint: Node3D

var is_reloading := false


func shoot() -> void:
  var bullet_instance = bullet.instantiate()
  get_tree().get_root().add_child(bullet_instance)
  bullet_instance.global_position = firepoint.global_position


func try_shoot() -> void:
  if not inputs.shooting:
    return
  if is_reloading:
    return
  shoot()
  is_reloading = true
  await get_tree().create_timer(reload_time).timeout
  is_reloading = false


func _process(_delta) -> void:
  try_shoot()
  
