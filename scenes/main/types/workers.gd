class_name Workers extends Resource

var workers: Dictionary = {}

enum Type {
	UNEMPLOYED,
	ROCK_TOOLS_CRAFTING
}

func _init(_unemployed: int) -> void:
	for work in Type:
		workers[work] = {
			"type" : work,
			"number": 0
		}
	workers["UNEMPLOYED"] = {
		"type": Type.UNEMPLOYED,
		"number": _unemployed
	}