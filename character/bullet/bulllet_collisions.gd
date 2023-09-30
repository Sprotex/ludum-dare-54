extends Node

@export var character_body: CharacterBody3D
@export var normal_offset_scale = 0.1
@export var particles: CPUParticles3D


func _ricochet(collision: KinematicCollision3D) -> void:
  var collision_normal = collision.get_normal()
  var travel_direction = collision.get_travel()
  var reflected_direction = travel_direction.bounce(collision_normal)
  character_body.global_transform.basis = Basis.looking_at(reflected_direction)
  character_body.global_transform.origin += collision_normal * normal_offset_scale


func _remove_particles() -> void:
  var particles_parent = particles.get_parent()
  particles_parent.remove_child(particles)
  particles_parent.get_parent().add_child(particles)
  particles.emitting = false
  await get_tree().create_timer(particles.lifetime).timeout
  particles.queue_free()


func _collide_with_body(body: Character) -> void:
  character_body.queue_free()
  body.health.take_damage()
  _remove_particles()


func _on_bullet_collision(collision: KinematicCollision3D) -> void:
  var collider = collision.get_collider()
  if collider is Character:
    _collide_with_body(collider)
    return
  _ricochet(collision)
