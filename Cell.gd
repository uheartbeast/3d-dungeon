extends Spatial
class_name Cell

onready var topFace: = $TopFace
onready var northFace: = $NorthFace
onready var eastFace: = $EastFace
onready var southFace: = $SouthFace
onready var westFace: = $WestFace
onready var bottomFace: = $BottomFace

func update_faces(cell_list) -> void:
	var my_grid_position = Vector2(translation.x/Globals.GRID_SIZE, translation.z/2)
	if cell_list.has(my_grid_position + Vector2.RIGHT):
		eastFace.hide()
	if cell_list.has(my_grid_position + Vector2.LEFT):
		westFace.hide()
	if cell_list.has(my_grid_position + Vector2.DOWN):
		southFace.hide()
	if cell_list.has(my_grid_position + Vector2.UP):
		northFace.hide()
