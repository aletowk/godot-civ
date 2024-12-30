class_name GroupInfo extends Node

var people: int
var food: int
var workers: Dictionary

func _init(_name: String, _people: int, _food: int) -> void:
	name = _name
	people = _people
	food = _food
	workers = {
		"explorer": 0,
		"gatherer": 0
	}

func _to_string() -> String:
	var s = "Group: %s\nPeople: %d\nFood:%d\nWorkers:\n"%[name, people, food]
	for w in workers:
		s += "\t%s : %d\n"%[w, workers[w]]
	return s
