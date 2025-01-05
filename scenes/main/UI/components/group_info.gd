extends Control

var group: Group
var show_resources: bool = false
var mouse_over: bool = false
var init_pos: Vector2
const resources_vbox_name = "VBoxResourcesItems"
const workers_vbox_name = "VBoxWorkersItems"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_pos = position

	$PanelContainer.connect("mouse_entered", _on_mouse_entered)
	$PanelContainer.connect("mouse_exited", _on_mouse_exited)

	$PanelContainer/VBoxRoot/VBoxWorkersMain/HBoxContainer/Button.connect("pressed", _on_show_workers_button_pressed)
	
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
			# res_amt.size_flags_horizontal = Control.SIZE_EXPAND
			res_amt.name = res + "_amount"
			res_amt.size_flags_horizontal = Control.SizeFlags.SIZE_EXPAND
			res_hbox.add_child(res_lbl)
			res_hbox.add_child(res_amt)

			res_lbl.text = res
			res_amt.text = str(group.resources[res].amount)

func _on_show_workers_button_pressed() -> void:
	
	if !$PanelContainer/VBoxRoot/VBoxWorkersMain/ScrollContainer.get_node(workers_vbox_name):
		var workers_vbox = VBoxContainer.new()
		workers_vbox.name = workers_vbox_name
		$PanelContainer/VBoxRoot/VBoxWorkersMain/ScrollContainer.add_child(workers_vbox)
		
		for worker in group.workers.workers:
			var worker_hbox = HBoxContainer.new()
			worker_hbox.name = worker
			workers_vbox.add_child(worker_hbox)

			var worker_lbl = Label.new()
			worker_lbl.name = worker + "_name"
			
			var worker_amt = Label.new()
			worker_amt.size_flags_horizontal = Control.SIZE_EXPAND
			worker_amt.name = worker + "_number"
			worker_hbox.add_child(worker_lbl)
			worker_hbox.add_child(worker_amt)

			worker_lbl.text = worker
			worker_amt.text = str(group.workers.workers[worker].number)

			if(worker != "UNEMPLOYED"):
				var line_edit = LineEdit.new()
				line_edit.text = str(0)
				worker_hbox.add_child(line_edit)

				var add_button = Button.new()
				add_button.text = "+"
				add_button.pressed.connect(add_worker.bind(worker, line_edit))
				worker_hbox.add_child(add_button)

				var remove_button = Button.new()
				remove_button.text = "-"
				remove_button.pressed.connect(remove_worker.bind(worker, line_edit))
				worker_hbox.add_child(remove_button)

func add_worker(worker: String, line_edit_obj: LineEdit):
	var new_nb_workers = int(line_edit_obj.text)
	if group.workers.workers["UNEMPLOYED"].number >= new_nb_workers:
		print("Adding %d to %s work"%[new_nb_workers, worker])

		group.workers.workers[worker].number += new_nb_workers
		group.workers.workers["UNEMPLOYED"].number -= new_nb_workers
		_update()

func remove_worker(worker: String, line_edit_obj: LineEdit):
	var to_remove_nb_workers = int(line_edit_obj.text)
	if to_remove_nb_workers > group.workers.workers[worker].number:
		to_remove_nb_workers = group.workers.workers[worker].number
	
	print("Removing %d to %s work"%[to_remove_nb_workers, worker])

	group.workers.workers[worker].number -= to_remove_nb_workers
	group.workers.workers["UNEMPLOYED"].number += to_remove_nb_workers
	_update()

func update_res_entries(vbox_res_root: VBoxContainer) -> void:
	for res in group.resources:
		var res_hbox_node = vbox_res_root.get_node(res)
		var res_amnt_node = res_hbox_node.get_node(res + "_amount")
		res_amnt_node.text = str(group.resources[res].amount)

func update_workers_entries(vbox_workers_root: VBoxContainer) -> void:
	print("update_workers_entries")
	for worker in group.workers.workers:
		var hbox_node = vbox_workers_root.get_node(worker)
		var worker_nb_node = hbox_node.get_node(worker + "_number")
		worker_nb_node.text = str(group.workers.workers[worker].number)

func _update() -> void:
	var res_vbox_node = $PanelContainer/VBoxRoot/VBoxResourcesMain/ScrollContainer.get_node(resources_vbox_name)
	if res_vbox_node:
		update_res_entries(res_vbox_node)
	
	var workers_vbox_node = $PanelContainer/VBoxRoot/VBoxWorkersMain/ScrollContainer.get_node(workers_vbox_name)
	if workers_vbox_node:
		update_workers_entries(workers_vbox_node)

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

