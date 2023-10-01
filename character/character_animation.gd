extends AnimationTree

@export var character_body: Character


func step() -> void:
  AudioManager.play_audio(character_body.global_position, AudioManager.step_audio)


func _get_bobbing_value() -> float:
  if not character_body.is_on_floor():
    return 0.0
  return character_body.velocity.length()


func _process(delta):
  var animation_bobbing = _get_bobbing_value()
  set("parameters/bobbing/blend_position", animation_bobbing)
