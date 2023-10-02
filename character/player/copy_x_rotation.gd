extends Node3D

@export var rotation_source: Node3D


func _process(_delta) -> void:
  (func(): global_rotation.x = rotation_source.global_rotation.x).call_deferred()