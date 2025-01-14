extends Control

const MAP_CELL_SIZE = Vector2(50, 20)

enum UnitType {
	ARCHER,
	WARRIOR
}

class Unit:
	var type: UnitType
	var pos: int
	func _init(_type: UnitType, _pos: int):
		self.type = _type
		self.pos = _pos

var attackers: Array[Unit] = [] # On left side of the map
var defenders: Array[Unit] = [] # On right side of the map

@export var nb_cells: int = 3 # Cells number of one side of the battle map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hbox = HBoxContainer.new()
	hbox.name = "HBox"
	$Map.add_child(hbox)
	for i in range(-nb_cells, +nb_cells + 1):
		var battle_cell = preload("res://scenes/battle_map/battle_cell.tscn").instantiate()
		battle_cell.name = "%d"%[i]
		var lbl: Label = battle_cell.get_node("VBoxContainer/Label")
		lbl.text = battle_cell.name
		hbox.add_child(battle_cell)
		hbox.add_theme_constant_override("separation", battle_cell.get_node("VBoxContainer").size.x*1.5)
		if i == 0:
			battle_cell.get_node("VBoxContainer/ColorRect").color = Color(0x55,0x55,0x55)
	
	$HBoxContainer/Start.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	print("Start")
	init_units()


func init_units() -> void:
	attackers.append(Unit.new(UnitType.WARRIOR, -3))
	defenders.append(Unit.new(UnitType.ARCHER, +3))

	for unit in attackers:
		var battle_cell = get_node("Map/HBox/%d"%unit.pos)
		var unit_obj = ColorRect.new()
		if unit.type == UnitType.WARRIOR:
			unit_obj.color = Color.BLUE 
		else: 
			unit_obj.color = Color.GREEN
		battle_cell.get_node("VBoxContainer").add_child(unit_obj)
		unit_obj.custom_min_size = Vector2(10, 10)