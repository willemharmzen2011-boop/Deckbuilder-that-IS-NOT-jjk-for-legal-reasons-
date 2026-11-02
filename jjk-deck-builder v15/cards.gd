extends Node2D
var cursor_on_card = false
var is_selected: = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_selected:
		var target_pos = get_global_mouse_position()
		global_position = global_position.lerp(target_pos, 0.2)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int)-> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if cursor_on_card:
			is_selected = true
		else: is_selected = false




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	cursor_on_card = false
