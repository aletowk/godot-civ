extends Control
class_name  GroupsDebug

var groups: Array[Group]
var init_pos: Vector2
var mouse_over: bool = false
var ui: UI

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
			position -= diff
			init_pos = position

func init(_groups: Array[Group], _ui: UI):
	ui = _ui
	groups = _groups
	for group in groups:
		var butt = Button.new()
		butt.name = group.name
		butt.text = group.name
		$Panel/ScrollContainer/VBoxContainer.add_child(butt)
		butt.pressed.connect(popup_group_info.bind(group))


func popup_group_info(_grp : Group):
	var grp_info_node_name = "GroupeInfo_" + _grp.name
	if !ui.get_node(grp_info_node_name):
		var grp_info = preload("res://scenes/main/UI/components/group_info.tscn").instantiate()
		grp_info.init(_grp)
		ui.add_child(grp_info)


