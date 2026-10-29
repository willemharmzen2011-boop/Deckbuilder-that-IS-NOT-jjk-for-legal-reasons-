
extends CharacterBody2D
#calls the area 2d into the script
@onready var area_2d: Area2D = $Area2D 
#lists what type of card this card is, used for counting up the cards so they can be put back into the inventory
const card_type: String = "punch"
#detects if cursor is on the card
var cursor_on_card = false
#used for knowing if the card is selected or not
var is_selected = false
#dictates in which slot the card is placed on the deck
#may also be useable for the visual layer the card is on while sitting in the hand just for added detail
var card_placement_order: int = 0
var attack_damage = 7
var card_is_on_enemy = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  is_in_group("discard pile"):
		
	
	#if the card is selected the card will be dragged slightly behind the mouse
	if is_selected == true:
		#gets the mouse's global position so it can
		var target_pos = get_global_mouse_position()
		#change the cards position while being slightly delayed for a bit of flair
		global_position = global_position.lerp(target_pos, 0.2)
	z_index = card_placement_order
		
		


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#fetches the turn manager node so we can check if turn_start == true and if it does then 
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	# Checks for left click input and that the cursor is over the card all at once
	if event is InputEventMouseButton and turn_manager.turn_start == true and cursor_on_card and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_selected = true
			get_viewport().set_input_as_handled()
		else:
			is_selected = false




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	#detects if the cursor is on the card
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	#detects if the cursor isnt on the card
	cursor_on_card = false
	
