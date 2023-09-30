extends CharacterMovement


signal on_collision(collision)


func move(delta: float) -> void:
  character_body.velocity = calculate_movement(character_body.velocity, delta)
  var collisions = character_body.move_and_collide(character_body.velocity * delta)
  if not collisions:
    return
  on_collision.emit(collisions)
  
