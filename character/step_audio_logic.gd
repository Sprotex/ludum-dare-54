extends Node

@export var character_body: Character
@export var step_distance := 0.3

@onready var last_step_position := character_body.global_position


func _physics_process(_delta) -> void:
  if not character_body.is_on_floor():
    return
  if last_step_position.distance_squared_to(character_body.global_position) > step_distance * step_distance:
    last_step_position = character_body.global_position
    AudioManager.play_audio(character_body.global_position, AudioManager.step_audio)
