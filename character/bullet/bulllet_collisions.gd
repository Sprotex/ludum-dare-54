extends Node

@export var character_body: CharacterBody3D


func try_ricochet() -> void:
  var last_slide_collision = character_body.get_last_slide_collision()
  if not last_slide_collision:
    return
  # var collider = last_slide_collision.get_collider()
  var collision_normal = last_slide_collision.get_normal()
  var new_velocity = character_body.velocity.reflect(collision_normal)
  character_body.velocity = new_velocity
  character_body.position -= new_velocity


func _physics_process(_delta: float) -> void:
  try_ricochet.call_deferred()
