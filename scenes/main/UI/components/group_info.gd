extends Control

var group: Group
var show_resources: bool = false
var mouse_over: bool = false
var init_pos: Vector2
const resources_vbox_name = "VBoxResourcesItems"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_pos = position

	$PanelContainer.connect("mouse_entered", _on_mouse_entered)
	$PanelContainer.connect("mouse_exited", _on_mouse_exited)
	EventBus.connect("new_turn_signal", _update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# * Check for drag replacement
	if Input.is_action_pressed("Click") and mouse_over:
		var diff = init_pos - get_global_mouse_position()
		if diff != Vector2.ZERO:
			# Click is registered in ProjectSettings>InputMap
			position -= diff
			init_pos = position

func _on_show_resources_button_pressed() -> void:
	
	if !$PanelContainer/VBoxRoot/VBoxResourcesMain/ScrollContainer.get_node(resources_vbox_name):
		var res_vbox = VBoxContainer.new()
		res_vbox.name = resources_vbox_name
		$PanelContainer/VBoxRoot/VBoxResourcesMain/ScrollContainer.add_child(res_vbox)
		
		for res in group.resources:
			var res_hbox = HBoxContainer.new()
			res_hbox.name = res
			res_vbox.add_child(res_hbox)

			var res_lbl = Label.new()
			res_lbl.name = res + "_name"
			
			var res_amt = Label.new()
			res_amt.name = res + "_amount"
			res_hbox.add_child(res_lbl)
			res_hbox.add_child(res_amt)

			res_lbl.text = res
			res_amt.text = str(group.resources[res].amount)

func update_res_entries(vbox_res_root: VBoxContainer) -> void:
	print("update_res_entries")
	for res in group.resources:
		var res_hbox_node = vbox_res_root.get_node(res)
		# var res_name_node = res_hbox_node.get_node(res + "_name")
		var res_amnt_node = res_hbox_node.get_node(res + "_amount")
		res_amnt_node.text = str(group.resources[res].amount)

func _update() -> void:
	print("_update")
	var res_vbox_node = $PanelContainer/VBoxRoot/VBoxResourcesMain/ScrollContainer.get_node(resources_vbox_name)
	if res_vbox_node:
		update_res_entries(res_vbox_node)

func _on_close_button_pressed() -> void:
	queue_free()

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	if !Input.is_action_pressed("Click"):
		mouse_over = false

func init(_group: Group) -> void:
	group = _group
	$PanelContainer/VBoxRoot/HBoxContainer/Name.text = group.name

