extends Node

@export var character_body: CharacterBody3D
@export var inputs: CharacterInputs
@export var movement_speed := 3.0
@export var rotation_speed := 1.0


func move(delta: float) -> void:
  var framerate_independent_movement = inputs.movement * movement_speed * delta
  var local_movement = character_body.global_transform.basis * framerate_independent_movement
  character_body.move_and_collide(local_movement)


func rotate(_delta: float) -> void:
  var rotation = inputs.rotation * rotation_speed * Constants.PIXEL_TO_DEGREE_RATIO
  character_body.rotate_y(deg_to_rad(-rotation.x))


func _physics_process(delta: float) -> void:
  move(delta)
  rotate(delta)
