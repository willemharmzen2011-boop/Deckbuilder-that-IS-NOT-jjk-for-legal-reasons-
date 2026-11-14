extends TextureButton
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

#ok so i dont think the button is working but why wouldnt it?
#i might try switching to a normal button node but i really hope it doesnt do annoying stuff like what they usually do 
# if that doesnt work it might point to the enemy turn just being broken so ill fix that if so

func _on_pressed() -> void:
	turn_start = false
	var enemies_list = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies_list:
		enemy.enemy_turn()
	card_manager.new_turn_hand_clear()
