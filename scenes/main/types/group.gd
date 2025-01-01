class_name Group extends Resource

var name: String
var player: bool
var resources: GroupResources
var workers: Array[Worker]
var unemployed: int
#var location: ??? 

func init(_name: String, _player: bool, _resources: GroupResources):
	name = _name
	player = _player
	resources = _resources
	workers = []
	unemployed = resources.people.amount

func consume() -> void:
	# Use the consumables
	# Food
	var food_to_get = resources.people.amount
	resources.food.amount -= food_to_get
	if resources.food.amount < 0:
		# TODO: remove people randomly
		resources.food.amount = 0

func _to_string() -> String:
	return "Group %s:\n\tResources:\n%s"%[name,resources]
