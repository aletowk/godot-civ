class_name Group extends Resource

var name: String
var player: bool
var resources: Dictionary = {}
var workers: Workers
var unemployed: int
#var location: ??? 

func init(_name: String, _player: bool, _resources: Dictionary):
	name = _name
	player = _player

	# * Resources initialization
	var to_init = ResourceItem.ResourceType.keys()
	# Init Passed resources
	for res in _resources:
		if res in ResourceItem.ResourceType:
			resources[res] = ResourceItem.new(ResourceItem.ResourceType[res], _resources[res])
			to_init.erase(res)
	# Init other resources to 0
	for res in to_init:
		resources[res] = ResourceItem.new(ResourceItem.ResourceType[res], 0)
	
	workers = Workers.new(resources["PEOPLE"].amount)

func consume() -> void:
	# Use the consumables
	# Food
	var people_res: ResourceItem = resources["PEOPLE"]
	var food_res: ResourceItem = resources["FOOD"]
	var food_to_get = people_res.amount
	food_res.amount -= food_to_get
	if food_res.amount < 0:
		# TODO: remove people randomly
		food_res.amount = 0

func _to_string() -> String:
	var res_str = ""
	for res in resources:
		res_str += "%s: %d, "%[res, resources[res].amount]
	return "Group %s:\nResources:\n%s"%[name,res_str]
