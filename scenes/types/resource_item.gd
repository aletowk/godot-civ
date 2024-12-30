class_name ResourceItem extends Node

enum ResourceType {
	FRUITS,
	ANIMALS
}

var number: int
var growth: int
var type: ResourceType

func _init(_type: ResourceType, _number: int, _growth: int) -> void:
	type = _type
	number = _number
	growth = _growth
	
func _to_string() -> String:
	return "(%s, %d, %d)"%[str(type), number, growth]
