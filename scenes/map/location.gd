extends ColorRect

var resources: Array[MapResourceItem] = []

func init(_resources: Array[MapResourceItem]) -> void:
	if resources != []:
		resources = []
	resources = _resources

func _on_mouse_entered() -> void:
	print("Entered:", name)
	get_parent().get_parent().show_location_info.emit(name)

func _on_mouse_exited() -> void:
	print("Exited:", name)
	remove_child(get_node("info_panel"))
