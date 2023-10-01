extends Node

@export var music_player: AudioStreamPlayer
@export var audio_player_container: Node
@export var laser_audio: AudioStream
@export var step_audio: AudioStream
@export var ricochet_audio: AudioStream
@export var player_death_audio: AudioStream
@export var enemy_death_audio: AudioStream
@export var music_start_init_delay := 1.0
@export var random_pitch_width := 0.1

@onready var random = RandomNumberGenerator.new()

var player: Character

@onready var audio_players = audio_player_container.get_children()
var next_audio_index = 0:
  set(value):
    if value >= len(audio_players):
      value = 0
    next_audio_index = value


func _ready() -> void:
  _reset()
  MessageBus.on_scene_reloaded.connect(_reset)
  MessageBus.on_player_object_broadcast.connect(func(object): player = object)
  MessageBus.on_player_died.connect(func(): play_audio_positionless(player_death_audio))
  MessageBus.on_enemy_died.connect(func(enemy): play_audio(enemy.global_position, enemy_death_audio))


func _reset() -> void:
  music_player.stop()
  for audio_player in audio_players:
    audio_player.stop()
  await get_tree().create_timer(music_start_init_delay).timeout
  music_player.play()


func play_audio_positionless(audio_stream: AudioStream, randomize_pitch: bool = true) -> void:
  if not player:
    MessageBus.on_player_object_requested.emit()
  play_audio(player.global_position, audio_stream, randomize_pitch)


func play_audio(position: Vector3, audio_stream: AudioStream, randomize_pitch: bool = true) -> void:
  var audio_player = audio_players[next_audio_index]
  audio_player.stop()
  audio_player.stream = audio_stream
  audio_player.global_position = position
  audio_player.pitch_scale = 1
  if randomize_pitch:
    audio_player.pitch_scale = random.randf_range(1.0 - random_pitch_width, 1.0 + random_pitch_width)
  audio_player.play()
  next_audio_index += 1
