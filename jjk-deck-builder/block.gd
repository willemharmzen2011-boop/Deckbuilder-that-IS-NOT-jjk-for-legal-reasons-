extends CharacterBody2D
@onready var area_2d: Area2D = $Area2D
#lists which card actually is so it can be used for countingthe cards for the inventory system
const card_type = "block"
#variable for shwoign if cursor is on card
var cursor_on_card =false
#shows if the card is selected or not
var is_selected = false
#dictates the slots the card sits in 
#and also used for card orders
var card_placement_order: int = 0
var block = 5
var card_is_on_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_group("discard pile"):
		pass
	if is_selected == true:
		#gets the mouses position
		var target_pos = get_global_mouse_position()
		#card follows cursor by traveling to the global mouse position with a lerp
		global_position = global_position.lerp(target_pos, 0.2)
	z_index = card_placement_order




func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#grabs teh turn manager node so it can checkign if turn staart == trueand if its so
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	#checks for left click and if the card is over at the same time
	if event is InputEventMouseButton and turn_manager.turn_start == true and cursor_on_card and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_selected = true
			get_viewport().set_input_as_handled()
		else:
			is_selected = false
			if card_is_on_player:
				var player = get_tree().get_first_node_in_group("player")
				if player:
					player.receive_block()




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	#detects if cursor on card and sets cursor_on_card to true
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	#desctects if the cursor left the cards area and sets cursor_on_card to false
	cursor_on_card = false
