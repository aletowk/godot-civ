extends Control


func _ready() -> void:
	$PanelContainer/VBoxContainer/HBoxContainer/CloseButton.pressed.connect(_on_close_button_pressed)

func init(_name: String, resources: Array[MapResourceItem]):
	get_node("PanelContainer/VBoxContainer/HBoxContainer/Name").text = _name

	for res in resources:
		var lbl = Label.new()
		lbl.name = ResourceItem.ResourceType.find_key(res.type)
		var grwth_str = "+%d"%res.growth if res.growth >= 0 else " %d"%res.growth
		lbl.text = "%s: %d (%s)"%[res, res.amount, grwth_str]
		$PanelContainer/VBoxContainer/Resources.add_child(lbl)

func reset() -> void:
	for child in $PanelContainer/VBoxContainer/Resources.get_children():
		child.queue_free()

func _on_close_button_pressed() -> void:
	hide()