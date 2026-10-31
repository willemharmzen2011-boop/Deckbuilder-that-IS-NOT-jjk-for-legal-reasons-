extends StaticBody2D
#what does an enemy do lets think for a second here
#first we need it to be able to attack the player it also needs to be able to take damage this can be done using
#variables for health on each and assigning damage variables also so when we activate a attack we can say.set player health = player health -= enemy damage 
#the same can be done the other way round we also need the enemy to start their turn when turn_start = false and 
#at the end of its turn set turn_start to true and after that is done we can try adding blocking by doing 
#something like if attacking and block > 1 damage = damage-block and then we say if damage < 1 skip the turn 
 
var enemy_health = 70
const enemy_max_health = 70
var attack_damage = 3
var block = 0
var turn_presets = [
	#preset 0 full attack 
	#hits twice for 12 damage no defence
	{ 
		"preset_name": "full_attack",
		"actions": [
			{"type":"attack", "value": 3},
			{"type":"attack", "value": 2}
		]
		},
	
	#preset 1 full defence :3
	{ #defends for 13 sheild once
		"preset_name": "full_defence",
		"actions": [
			{"type":"defence", "value":13}
		]
		},
	#preset 2 balanced :O
	{#uses a more balenced set up with 9 attack damage and 5 sheilds
		"preset_name": "Balanced",
		"actions": [
			{"type": "attack","value": 3},
			{"type":"defence", "value": 5}
		]
	},
	
	#preset 3 skewed to attack
	{#stronger on attack with 12 damage and 3 sheild
	
		"preset_name": "attack_skewed",
		"actions": [
			{"type": "attack","value": 4},
			{"type":"defence","value":3}
			
		]
	},
	
	#preset 4 skewed to defence
	{#stronger on defence with 8 defence points and 9 attack
		"preset_name":"defence_skewed",
		"actions":[
			{"type":"defence", "value": 14},
			{"type": "attack", "value": 4}
		]
	},
	
	#preset 5 all in
	{ # its all in both 8 defence and 15 attack
		"preset_name": "all_in",
		"actions": [
			{"type":"defence","value":8},
			{"type": "attack", "value":5}
		]
	}
]
var selected_move = {}
@onready var health_bar = $ProgressBar 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Enemy spawned with health: ", enemy_health)#<---remvoe this
	health_bar.max_value = enemy_max_health
	health_bar.value = 70
	enemy_health = 70


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("Enemy Health is currently: ", enemy_health)#<---remove this
	health_bar.value = enemy_health
		#add random action selection here 
		#how do i make the enemy code select upto 10 and or anywhere under 10 random actions in its turn
		#i know ill use multiplication to do something like attack damage = attack damage x 5 and
		#then the same thing for blocking and stuff but how do i select those numbersto multiply them by 
		#and add up to a max of 10 but can be under that amount 
		





func take_damage(body: Node2D) -> void:#calls my cool and statement thing for groups
	print("take_damage was called! Current health was: ", enemy_health)#<--- remove this
	#sets a temparary variablefor the overlapping area2ds which should only be a card
	var overlapping_cards = $Area2D.get_overlapping_areas()
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	#checks if there is more than 0 overlapping cards
	if overlapping_cards.size() > 0:
		# Loop through overlapping areas to safely add valid cards to the discard pile group
		for card in overlapping_cards:
			if card.is_in_group("attack card"):
				card.add_to_group("discard pile")
		
		#my fancy get_node and statement gets used to check if the damage card is a attack card and a discard pile
		var used_damage_cards = get_nodes_in_both_groups("attack card", "discard pile")
		var total_damage = 0
		#creates a for loop to...
		for card in used_damage_cards:
			# Grab the card's damage value safely
			var card_damage = card.attack_damage
			
			# If the enemy has block, absorb the damage first
			if block > 0:
				if block >= card_damage:
					block -= card_damage
					card_damage = 0
				else:
					card_damage -= block
					block = 0
			
			# Add this card's final damage to the total pool
			total_damage += card_damage
			
			# Clean up the card after use
			card.queue_free()
		
		# Apply the total damage inflicted by all played cards
		enemy_health -= total_damage
		enemy_health = max(0, enemy_health)
		
		# Reset block after taking the hit
		block = 0
		
		# If the enemy's health is 0 or less, trigger death
		if enemy_health <= 0:
			die()
	
	
	


func enemy_move():
	var move_choice = randi_range(0,turn_presets.size() -1) 
	selected_move = turn_presets[move_choice]
	
	print("Picked: ", selected_move["preset_name"])#<--- remove this

func execute_move():
	for action in selected_move["actions"]:
		var move_type = action["type"]
		var times_executed = action["value"]
	
		if move_type == "attack":
			var player_damage = attack_damage * times_executed
		
		#finds the player and sends the player damage over to be processed on that side
			var player = get_tree().get_first_node_in_group("player")
			if player and player.has_method("take_damage"):
				player.take_damage(player_damage)
		
		if move_type == "defence":
			block = block + times_executed
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	if turn_manager:
		turn_manager.turn_start = true


#a and function for getting groups :3
func get_nodes_in_both_groups(group1: String, group2: String) -> Array:
	#sets a variable for the rest of the stuff to be set int
	var result = []
	#gets the group you selected when the function is called
	for node in get_tree().get_nodes_in_group(group1):
		#and then filters it more by getting the second one also
		if node.is_in_group(group2):
			
			result.append(node)
	return result

func die():
	#put death animation and sounds here later
	#deletes the enemy safely when the death function is triggered
	queue_free()
