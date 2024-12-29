extends CanvasLayer

signal start_game

func _ready() -> void:
	$Start.connect("pressed", self.start)
	
func start() -> void:
	self.show_message("Started !")

func show_message(text):
	$CityDescription.text = text
	$CityDescription.show()
