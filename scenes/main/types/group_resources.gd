class_name GroupResources extends Resource

var people: ResourceItem
var food: ResourceItem
var rock_tools: ResourceItem

func _init(_people_amount: int, _food_amount: int) -> void:
	people = ResourceItem.new(ResourceItem.ResourceType.PEOPLE, _people_amount)
	food = ResourceItem.new(ResourceItem.ResourceType.FOOD, _food_amount)
	rock_tools = ResourceItem.new(ResourceItem.ResourceType.ROCK_TOOLS, 0)

func _to_string() -> String:
	var s = ""
	s += "people: %d\n"%people.amount
	s += "food: %d\n"%food.amount
	s += "rock_tools: %d\n"%rock_tools.amount
	return s
