extends Control
class_name Map

signal show_location_info

@export var width: int = 5
@export var height: int = 5

var loc_info_panel = preload("res://scenes/map/ui/location_info.tscn").instantiate()

func _init() -> void:
	add_child(loc_info_panel)
	loc_info_panel.hide()

func _ready() -> void:
	$GridContainer.columns = width
	
	for i in range(width):
		for j in range(height):
			var loc = preload("res://scenes/map/location.tscn").instantiate()

			loc.name = str(Vector2i(i,j))
			var res_arr: Array[MapResourceItem] = [
					MapResourceItem.new(MapResourceItem.ResourceType.FRUITS, 10, 1),
					MapResourceItem.new(MapResourceItem.ResourceType.ANIMALS, 3, 1)
				]
			loc.init(res_arr)
			$GridContainer.set("theme_override_constants/v_separation", loc.size.x/2)
			$GridContainer.set("theme_override_constants/h_separation", loc.size.y/2)
			$GridContainer.add_child(loc)

	connect("show_location_info", _on_show_location)

func _on_show_location(location_name: String) -> void:
	var child_loc = null
	for child in $GridContainer.get_children():
		if child.name == location_name:
			child_loc = child
			break
	if child_loc:
		loc_info_panel.reset()
		loc_info_panel.init(location_name, child_loc.resources)
		loc_info_panel.show()
		loc_info_panel.position = get_global_mouse_position()