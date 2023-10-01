extends Node3D


func _ready():
  MessageBus.on_object_created.connect(_handle_object_created)


func _handle_object_created(object: Node) -> void:
  add_child(object)