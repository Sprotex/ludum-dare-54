extends Node

@export var character_body: CharacterBody3D


func _on_bullet_collision(collision: KinematicCollision3D) -> void:
  var collision_normal = collision.get_normal()
  var travel_direction = collision.get_travel()
  var reflected_direction = travel_direction.bounce(collision_normal)
  character_body.global_transform.basis = Basis.looking_at(reflected_direction)

