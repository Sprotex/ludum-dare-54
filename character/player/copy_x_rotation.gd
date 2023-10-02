extends Node3D

@export var rotation_source: Node3D

func _process(_delta):
  global_rotation.x = rotation_source.global_rotation.x