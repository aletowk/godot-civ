extends Control
class_name UI

var groups: Array[Group] # Copy of the groups instance in game_engine.gd

func init(_groups: Array[Group]) -> void:
	groups = _groups

func _on_show_groups_pressed() -> void:
	var grp_dbg_scroll_nodename = "GroupsDebugScroll" 
	if( !get_node(grp_dbg_scroll_nodename)):
		var groups_dbg_scroll: GroupsDebug = preload("res://scenes/main/UI/Debug/groups_debug.tscn").instantiate()
		groups_dbg_scroll.name = grp_dbg_scroll_nodename
		add_child(groups_dbg_scroll)
		groups_dbg_scroll.init(groups, self)
