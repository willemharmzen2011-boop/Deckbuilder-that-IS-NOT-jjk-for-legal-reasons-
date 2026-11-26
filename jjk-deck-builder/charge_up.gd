extends CharacterBody2D
const CHARGE_EFFECT_SCENE = preload("res://magic_charge_effects.tscn")
@onready var area_2d: Area2D = $Area2D
#lists which card actually is so it can be used for countingthe cards for the inventory system
const CARD_TYPE = "charge_up"
#variable for shwoign if cursor is on card
var cursor_on_card =false
#shows if the card is selected or not
var is_selected = false
#dictates the slots the card sits in 
#and also used for card orders
var card_placement_order: int = 0
var block = 3
var card_is_on_player
const ENERGY_COST = 0
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
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	
	var energy = get_tree().get_first_node_in_group("energy")
	
	var cursed_energy = get_tree().get_first_node_in_group("cursed_energy")
	# Checks for left click input and that the cursor is over the card all at once
	if event is InputEventMouseButton and turn_manager.turn_start == true and cursor_on_card and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_selected = true
			get_viewport().set_input_as_handled()
		else:
			#changes is_selected to false to drop the card
			is_selected = false
			#checks if the cards over the player
			if card_is_on_player:
				#grabs the player node using
				var player = get_tree().get_first_node_in_group("player")
				#checks if you have enough energy to play the card 
				if player and energy.current_energy >= ENERGY_COST:
					#sends the node to the player do apply it to receive_block
					player.receive_block(self)
					#sends the node to the energy system to minus the energy cost variable from the energy total
					energy.energy_used(self)
					#sends the node to the cursed energy node to grant the player more energy
					cursed_energy.add_energy()
					#puts the charge effect into the scene
					var charge_effect = CHARGE_EFFECT_SCENE.instantiate()
					#moves the effect into the correct place in the scene
					charge_effect.global_position = player.global_position
					#drops it into the scene now
					get_tree().current_scene.add_child(charge_effect)
					#deletes the card from the scene
					queue_free()




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	#detects if cursor on card and sets cursor_on_card to true
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	#desctects if the cursor left the cards area and sets cursor_on_card to false
	cursor_on_card = false



func _on_card_off_player(body: Node2D) -> void:
	card_is_on_player = false
	if is_in_group("player"):
		print("the card is over the player ")
#_on_card_off_player isnt triggering why might that be

func _on_card_over_player(body: Node2D) -> void:
	card_is_on_player = true
