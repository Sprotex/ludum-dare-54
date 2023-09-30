extends CanvasLayer


@export var death_screen: Control
@export var mouse_filter_exceptions: Array[Control]


func connect_once(_signal: Signal, callable: Callable) -> void:
  if _signal.is_connected(callable):
    return
  _signal.connect(callable)


func _ready() -> void:
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
  for child in get_children():
    _show_recursively_towards_children(child, false)
  connect_once(MessageBus.on_player_died, _handle_player_died)
  connect_once(MessageBus.on_scene_reloaded, _ready)


func _handle_player_died() -> void:
  _show_recursively_towards_parent(death_screen)
  Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_restart_button_pressed():
  get_tree().reload_current_scene()
  MessageBus.on_scene_reloaded.emit()


func show_node(node: Control, is_node_visible = true) -> void:
  node.visible = is_node_visible
  if node in mouse_filter_exceptions:
    return
  node.mouse_filter = Control.MOUSE_FILTER_PASS
  if is_node_visible:
    node.mouse_filter = Control.MOUSE_FILTER_STOP


func _show_recursively_towards_parent(node: Node, is_node_visible = true) -> void:
  if not node is Control:
    return
  show_node(node, is_node_visible)
  _show_recursively_towards_parent(node.get_parent(), is_node_visible)


func _show_recursively_towards_children(node: Node, is_node_visible = true) -> void:
  if not node is Control:
    return
  show_node(node, is_node_visible)
  for child in node.get_children():
    _show_recursively_towards_children(child)
  