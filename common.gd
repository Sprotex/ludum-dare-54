extends Node

class_name Common


static func do_emphasis(node: Node, property: NodePath) -> void:
  var tween = node.get_tree().create_tween()
  tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)
  tween.tween_property(node, property, Vector2.ONE, .2).from(Vector2.ONE * 2)