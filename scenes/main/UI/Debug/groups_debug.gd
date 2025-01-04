extends Control
class_name  GroupsDebug

var groups: Array[Group]
var init_pos: Vector2
var mouse_over: bool = false

func _ready() -> void:
	init_pos = position

func _on_panel_mouse_entered() -> void:
	mouse_over = true

func _on_panel_mouse_exited() -> void:
	if !Input.is_action_pressed("Click"):
		mouse_over = false

func _on_panel_close() -> void:
	queue_free()

func _process(delta: float) -> void:
	# * Check for drag replacement
	if Input.is_action_pressed("Click") and mouse_over:
		var diff = init_pos - get_global_mouse_position()
		if diff != Vector2.ZERO:
			# Click is registered in ProjectSettings>InputMap
			position -= diff + size/2
			init_pos = position

func init(_groups: Array[Group]):
	groups = _groups
	for group in groups:
		var butt = Button.new()
		butt.name = group.name
		butt.text = group.name
		$Panel/ScrollContainer/VBoxContainer.add_child(butt)