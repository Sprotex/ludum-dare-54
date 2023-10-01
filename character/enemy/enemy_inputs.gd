extends CharacterInputs

class_name EnemyInputs


var player: Character


func _set_player_reference() -> void:
  if Enums.CharacterType.PLAYER in ObjectRegistration.objects:
    player = ObjectRegistration.objects[Enums.CharacterType.PLAYER]


func _ready():
  set_process(false)
  print(name)
  

func _process(delta):
  pass