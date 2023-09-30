extends Node

@export var character_body: CharacterBody3D
@export var input_vector: InputVector
@export var movement_speed: float = 3.0

func _physics_process(delta: float) -> void:
  var framerate_independent_movement = input_vector.vector * movement_speed * delta
  character_body.move_and_collide(framerate_independent_movement)
