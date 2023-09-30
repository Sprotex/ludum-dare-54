extends Node

@export var character_body: CharacterBody3D
@export var normal_offset_scale = 0.1

func _on_bullet_collision(collision: KinematicCollision3D) -> void:
  var collision_normal = collision.get_normal()
  var travel_direction = collision.get_travel()
  var reflected_direction = travel_direction.bounce(collision_normal)
  character_body.global_transform.basis = Basis.looking_at(reflected_direction)
  character_body.global_transform.origin += collision_normal * normal_offset_scale
