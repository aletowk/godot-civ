extends ColorRect

var fruits: MapResourceItem
var animals: MapResourceItem

func init(_fruits: MapResourceItem, _animals: MapResourceItem) -> void:
	fruits = _fruits
	animals = _animals

func _on_mouse_entered() -> void:
	print("Entered:", self.name, self.fruits, self.animals)
	var info = preload("res://scenes/assets/location_info.tscn").instantiate()
	info.name = "info_panel"
	info.get_node("VBoxContainer/HBoxName/value").text = self.name
	info.get_node("VBoxContainer/HBoxFruits/number").text = str(self.fruits.number)
	info.get_node("VBoxContainer/HBoxFruits/growth").text = "(+%d)"%self.fruits.growth
	info.get_node("VBoxContainer/HBoxAnimals/number").text = str(self.animals.number)
	info.get_node("VBoxContainer/HBoxAnimals/growth").text = "(+%d)"%self.animals.growth
	
	info.position = get_global_mouse_position()
	info.show()
	add_child(info)

func _on_mouse_exited() -> void:
	print("Exited:", self.name)
	remove_child(get_node("info_panel"))
