extends Node

class_name PlayerBroadcaster

@export var player: Character


func _ready() -> void:
  MessageBus.on_player_object_requested.connect(func(): MessageBus.on_player_object_broadcast.emit(player))
