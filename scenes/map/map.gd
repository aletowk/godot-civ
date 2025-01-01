extends Control

@export var width: int = 5
@export var height: int = 5

func _ready() -> void:
	$GridContainer.columns = width
	
	for i in range(width):
		for j in range(height):
			var loc = preload("res://scenes/map/location.tscn").instantiate()

			loc.name = str(Vector2i(i,j))
			loc.init(
				MapResourceItem.new(MapResourceItem.ResourceType.FRUITS, 10, 1),
				MapResourceItem.new(MapResourceItem.ResourceType.ANIMALS, 3, 1)
			)
			$GridContainer.set("theme_override_constants/v_separation", loc.size.x/2)
			$GridContainer.set("theme_override_constants/h_separation", loc.size.y/2)
			$GridContainer.add_child(loc)
