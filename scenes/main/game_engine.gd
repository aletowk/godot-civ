extends Node

var groups: Array[Group]

var turn_number: int = 0

func _ready() -> void:
	initialize()
	get_parent().get_node("CanvasLayer/UI/Run").text = "Run Turn %d"%turn_number
	
func initialize() -> void:
	# Create player group
	for i in range(3):
		var grp = Group.new()
		grp.init("Grp %d"%i, true, {
			"PEOPLE": 10, "FOOD": 100
		})
		groups.append(grp)


	# Init UI
	var ui: UI = get_parent().get_node("CanvasLayer/UI")
	ui.init(groups)

func run() -> void:
	print("Run Turn %d"%turn_number)
	
	for group in groups:
		group.consume()
	print(groups)

func _on_run_pressed() -> void:
	run()
	turn_number += 1
	get_parent().get_node("CanvasLayer/UI/Run").text = "Run Turn %d"%turn_number
	EventBus.new_turn_signal.emit()