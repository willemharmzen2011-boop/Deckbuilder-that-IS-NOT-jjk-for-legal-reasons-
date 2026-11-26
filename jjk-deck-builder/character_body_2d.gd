
extends CharacterBody2D
#calls the area 2d into the script
@onready var area_2d: Area2D = $Area2D 
const HIT_EFFECT_SCENE = preload("res://strike_effects.tscn")
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
const ENERGY_COST = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  is_in_group("discard pile"):
		pass
	
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
	#grabs the energy thing so it can check if theres enough energy to perform it
	var energy = get_tree().get_first_node_in_group("energy")
	# Checks for left click input and that the cursor is over the card all at once
	if event is InputEventMouseButton and turn_manager.turn_start == true and cursor_on_card and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_selected = true
			get_viewport().set_input_as_handled()
		else:
			#changes is_selected to false to make it unselected
			is_selected = false
			#it te=n checks if the card is on the enemy
			if card_is_on_enemy:
				#it gets now the enemy for later stuff
				var enemy = get_tree().get_first_node_in_group("enemy")
				# checks if energy is enough to use the card
				if enemy and energy.current_energy >= ENERGY_COST:
					#hands the node to the enemy to execute the take_damage()
					enemy.take_damage(self)
					#hands the node to the energy system where it deducts the energy cost from the energy supply
					energy.energy_used(self)
					#puts the preloaded guy into the world
					var hit_effect = HIT_EFFECT_SCENE.instantiate()
					#places the effect ontop of the enemy
					hit_effect.global_position = enemy.global_position
					#drop it in the main scene where the card is loaded
					get_tree().current_scene.add_child(hit_effect)




func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	#detects if the cursor is on the card
	cursor_on_card = true


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	#detects if the cursor isnt on the card
	cursor_on_card = false
	


func card_over_enemy(area: Area2D) -> void:
	print("the card is over the", area.name)
	var parent_node = area.get_parent()
	if parent_node and parent_node.is_in_group("enemy"):
		card_is_on_enemy = true
		print("super success tha card is over the enemy")


func card_off_enemy(area: Area2D) -> void:
	print("something is not in da area anymore",area.name)
	var parent_node = area.get_parent()
	if parent_node and parent_node.is_in_group("enemy"):
		card_is_on_enemy = false
		print("card left the enemy area")
