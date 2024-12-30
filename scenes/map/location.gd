extends ColorRect

var fruits: ResourceItem
var animals: ResourceItem

func init(_fruits: ResourceItem, _animals: ResourceItem) -> void:
	fruits = _fruits
	animals = _animals

func _on_mouse_entered() -> void:
	print("Entered:", self.name, self.fruits, self.animals)
	var info = preload("res://scenes/assets/location_info.tscn").instantiate()
	info.name = "info_panel"
	info.get_node("VBoxContainer/HBoxName/Name_entry").text = self.name
	info.get_node("VBoxContainer/HBoxFruits/Fruits_entry").text = str(self.fruits.number)
	info.get_node("VBoxContainer/HBoxAnimals/Animals_entry").text = str(self.animals.number)
	
	info.position = get_global_mouse_position()
	info.show()
	add_child(info)

func _on_mouse_exited() -> void:
	print("Exited:", self.name)
	remove_child(get_node("info_panel"))
