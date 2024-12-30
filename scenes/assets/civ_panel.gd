extends Control

var groups: Array[GroupInfo] = [
	GroupInfo.new("Toto", 3, 3),
	GroupInfo.new("Tota", 4, 4)
]

func update_groups(root: VBoxContainer) -> void:
	# First clear the content
	for child in root.get_children():
		root.remove_child(child)
		
	for group in groups:
		print(group)
		var grp = create_groupe_abstract(group)
		root.set("theme_override_constants/separation", grp.get_node("HBoxContainer").size.y)
		root.add_child(grp)

func create_groupe_abstract(group: GroupInfo) -> GroupAbstract:
	var new_groupe = preload("res://scenes/assets/groups/group_abstract.tscn").instantiate()
	new_groupe.info = group
	new_groupe.parent_box = new_groupe.get_node("HBoxContainer")
	new_groupe.get_node("HBoxContainer/name").text = group.name
	new_groupe.get_node("HBoxContainer/info").text = "People:%d | Food:%d"%[group.people, group.food]
	return new_groupe

func _on_tab_container_tab_clicked(tab: int) -> void:
	var tab_title = $TabContainer.get_tab_title(tab)
	
	match tab_title:
		"Groups":
			update_groups($TabContainer.get_node("Groups"))
