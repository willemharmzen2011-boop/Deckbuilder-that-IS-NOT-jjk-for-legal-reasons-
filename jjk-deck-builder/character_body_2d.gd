extends Node2D
var card_type: String = "punch"
var cursor_on_card = false
var is_selected: = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if the card is selected the card will be dragged slightly behind the mouse
	if is_selected == true:
		var target_pos = get_global_mouse_position()
		global_position = global_position.lerp(target_pos, 0.2)
	
		
		

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#checks for left click input and that the cursor is over the card all at once
	if event is InputEventMouseButton and  cursor_on_card and event.button_index == MOUSE_BUTTON_LEFT:
		#if it gets pressed make the card selected
		if event.pressed:
			is_selected = true
		#otherwise the card isnt selected
		else:is_selected = false




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	#detects if the cursor is on the card
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	#detects if the cursor isnt on the card
	cursor_on_card = false
