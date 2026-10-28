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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var turn_manager = get_tree().get_nodes_in_group("turn_manager")
	if turn_manager.turn_start == false:
		#add random action selection here 
		#how do i make the enemy code select upto 10 and or anywhere under 10 random actions in its turn
		#i know ill use multiplication to do something like attack damage = attaack damage x 5 and
		#then the same thing for blocking and stuff but how do i select those numbersto multiply them by 
		#and add up to a max of 10 but can be under that amount 
		
		pass 
		

func enemy_take_damage():
	#calls my cool and statement thing for groups
	
	var used_damage_cards = get_nodes_in_both_groups("attack card", "discard pile")
	for card in used_damage_cards:
		#if the block variable = more than 0
		if block > 0:
		#minus the attack damage by the block
			card.attack_damage -= block
			
	# when this function is triggered the enemy takes the damage inflicted by the player
	enemy_health -= attack_damage
	#resets the block after the enemy stops taking damage so it can do it again next round
	block = 0
	#if the enemys health is less than 0 set of the die func
	if enemy_health < 0:
		die()

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
