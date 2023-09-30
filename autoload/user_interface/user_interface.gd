extends CanvasLayer


@export var death_screen: Control
@export var static_set_nodes: Array[Control]
@export var descending_stop_nodes: Array[Control]
@export var hide_nodes: Array[Control]

func connect_once(_signal: Signal, callable: Callable) -> void:
  if _signal.is_connected(callable):
    return
  _signal.connect(callable)


func _reset() -> void:
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
  for child in get_children():
    _show_recursively_towards_children(child, false)
  for node in hide_nodes:
    show_node(node, false)
  
  
func _ready() -> void:
  MessageBus.on_player_died.connect(_handle_player_died)
  MessageBus.on_scene_reloaded.connect(_reset)
  _reset()


func _handle_player_died() -> void:
  _show_recursively_towards_parent(death_screen)
  Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_restart_button_pressed():
  get_tree().reload_current_scene()
  MessageBus.on_scene_reloaded.emit()


func _set_visibility_with_exceptions(node: Control, is_node_visible = true) -> void:
  if node in static_set_nodes:
    return
  node.visible = is_node_visible


func _set_filter_with_exceptions(node: Control, is_node_visible = true) -> void:
  if node in static_set_nodes:
    return
  node.mouse_filter = Control.MOUSE_FILTER_PASS
  if is_node_visible:
    node.mouse_filter = Control.MOUSE_FILTER_STOP


func show_node(node: Control, is_node_visible = true) -> void:
  _set_visibility_with_exceptions(node, is_node_visible)
  _set_filter_with_exceptions(node, is_node_visible)


func _show_recursively_towards_parent(node: Node, is_node_visible = true) -> void:
  if not node is Control:
    return
  show_node(node, is_node_visible)
  _show_recursively_towards_parent(node.get_parent(), is_node_visible)


func _show_recursively_towards_children(node: Node, is_node_visible = true) -> void:
  if not node is Control:
    return
  if node in descending_stop_nodes:
    return
  show_node(node, is_node_visible)
  for child in node.get_children():
    _show_recursively_towards_children(child)
  
