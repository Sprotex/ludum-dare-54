extends Node

@export var music_player: AudioStreamPlayer
@export var audio_player_container: Node
@export var test_audio_stream: AudioStream
@export var music_start_init_delay := 1.0

@onready var audio_players = audio_player_container.get_children()
var next_audio_index = 0:
  set(value):
    if value > len(audio_players):
      value = 0
    next_audio_index = value


func _ready() -> void:
  _reset()
  MessageBus.on_scene_reloaded.connect(_reset)


func _reset() -> void:
  music_player.stop()
  for audio_player in audio_players:
    audio_player.stop()
  await get_tree().create_timer(music_start_init_delay).timeout
  music_player.play()


func play_audio(position: Vector3, audio_stream: AudioStream) -> void:
  var audio_player = audio_players[next_audio_index]
  audio_player.stop()
  audio_player.stream = audio_stream
  audio_player.global_position = position
  audio_player.play()
  next_audio_index += 1
