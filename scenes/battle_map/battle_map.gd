extends Control

const MAP_CELL_SIZE = Vector2(50, 20)

@export var nb_cells: int = 3 # Cells number of one side of the battle map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add negative cells
	# var offset = Vector2(0,0)
	# for i in range(nb_cells):
	# 	var rec = ColorRect.new()
	# 	rec.name = "-%d"%[nb_cells - i]
	# 	rec.size = MAP_CELL_SIZE
	# 	rec.position = Vector2(i*(rec.size.x*2),0)
	# 	rec.color = Color.RED
	# 	add_child(rec)
	# 	offset = rec.position

	# offset.x += MAP_CELL_SIZE.x*3
	# for i in range(nb_cells):
	# 	var rec = ColorRect.new()
	# 	rec.name = "+%d"%[nb_cells - i]
	# 	rec.size = MAP_CELL_SIZE
	# 	rec.position = offset + Vector2(i*(rec.size.x*2),0)
	# 	rec.color = Color.RED
	# 	add_child(rec)
	var hbox = HBoxContainer.new()
	add_child(hbox)
	for i in range(-nb_cells, +nb_cells + 1):
		var battle_cell = preload("res://scenes/battle_map/battle_cell.tscn").instantiate()
		battle_cell.name = "%d"%[i]
		var lbl: Label = battle_cell.get_node("VBoxContainer/Label")
		lbl.text = battle_cell.name
		hbox.add_child(battle_cell)
		hbox.add_theme_constant_override("separation", battle_cell.get_node("VBoxContainer").size.x*1.5)
		if i == 0:
			battle_cell.get_node("VBoxContainer/ColorRect").color = Color(0x55,0x55,0x55)