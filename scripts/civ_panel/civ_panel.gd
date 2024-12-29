extends CanvasLayer

var city_node = preload("res://scenes/assets/CityUI.tscn")

var cities = []

func update_desc():
	var msg = ""
	for city in cities:
		msg += city + "\n"
	$CivDescription.text = msg

func _ready() -> void:
	$Add.connect("pressed", self.add_city)

	self.add_city()
	self.add_city()

func add_city() -> void:
	var new_city_name = "City" + str(len(cities) + 1)
	
	var new_city = city_node.instantiate()
	var city_lbl: Label = new_city.get_node("Label")
	city_lbl.text = new_city_name
	$GridContainer.add_child(new_city)
	$GridContainer.set("theme_override_constants/v_separation", city_lbl.size.x/2)
	
	print(new_city_name)
	cities.append(new_city_name)
