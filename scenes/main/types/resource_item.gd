class_name ResourceItem extends Resource

enum ResourceType {
	FOOD,
	PEOPLE,
	FRUITS,
	ANIMALS,
	ROCK_TOOLS,
}

var type: ResourceType
var amount: int

func _init(_type: ResourceType, _amount: int) -> void:
	type = _type
	amount = _amount
