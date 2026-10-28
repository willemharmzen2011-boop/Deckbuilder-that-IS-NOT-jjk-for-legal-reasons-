extends Node2D
var turn_start = true
var turn_first_trigger = false
var cursor_on_turn_end_button = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	# how do i make a turn system hm lets think for a second
	#so when the turn_start variable is true our cards work and so when we use the finish turn button it should turn turn_start to false ending the turn
	#so that the cards dont move anymore and then we can also add it so the button stops working also unitl the turn comes around to the player
	#but what needs to go in here is not a turn manager function it needs to be the buttons function so that it is able to directly control the turn 


func _on_mouse_shape_entered(shape_idx: int) -> void:
	cursor_on_turn_end_button = true


func _on_mouse_shape_exited(shape_idx: int) -> void:
	cursor_on_turn_end_button = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and turn_start == true and cursor_on_turn_end_button and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			turn_start = false
