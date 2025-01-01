extends Node

var groups: Array[Group]

var turn_number: int = 0

func _ready() -> void:
	initialize()
	get_parent().get_node("CanvasLayer/UI/Run").text = "Run Turn %d"%turn_number
	
func initialize() -> void:
	# Create player group
	var grp = Group.new()
	var resources = GroupResources.new(10, 100)
	grp.init("Grp 1", true, resources)
	groups.append(grp)

func run() -> void:
	print("Run Turn %d"%turn_number)
	
	for group in groups:
		group.consume()
	print(groups)

func _on_run_pressed() -> void:
	
	run()
	
	turn_number += 1
	get_parent().get_node("CanvasLayer/UI/Run").text = "Run Turn %d"%turn_number
