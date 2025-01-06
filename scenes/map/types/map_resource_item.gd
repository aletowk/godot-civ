class_name MapResourceItem extends ResourceItem

var growth: int

func _init(_type: ResourceType, _number: int, _growth: int) -> void:
	type = _type
	amount = _number
	growth = _growth
	
func _to_string() -> String:
	var type_str = MapResourceItem.ResourceType.find_key(type)
	return "(%s, %d, %d)"%[type_str, amount, growth]
