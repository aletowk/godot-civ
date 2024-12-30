class_name GroupAbstract extends Control

var info: GroupInfo
var parent_box: HBoxContainer

func create_group_details() -> void:
	var details = preload("res://scenes/assets/groups/group_details.tscn").instantiate()
	
	details.get_node("VBoxContainer/name").text = info.name
	details.get_node("VBoxContainer/people").text = "People: %d"%info.people
	details.get_node("VBoxContainer/food").text = "Food: %d"%info.food

	details.position = position + Vector2(parent_box.size.x + 10, 0)
	add_child(details)

func _on_show_pressed() -> void:
	create_group_details()
