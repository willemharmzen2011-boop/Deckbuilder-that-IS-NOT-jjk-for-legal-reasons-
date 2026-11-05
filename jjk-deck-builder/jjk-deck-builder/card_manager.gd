extends Node2D
var punch_card_num = 0
var cursed_strike_card_num = 0
var is_setup_complete = false
#card slot positions in order
var slot_positions = [
	Vector2(-200, 0),
	Vector2(-110, 0),
	Vector2(0, 0),
	Vector2(110, 0),
	Vector2(200, 0)
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	#random card selector goes here to select five completely random cards from the deck
	# get what group each card is in if its in the group cards then we
	var cards = get_tree().get_nodes_in_group("cards")
	#go through the list of cards giving the 5 cards concecutive numbers 
	
	for i in range(cards.size()):
		var card = cards[i]
		#card_placement_order = assigned card number (repeat for all 5 cards)
		card.set("card_placement_order", i)
	
	is_setup_complete = true
	 
	
	

			
			
			

# 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_setup_complete:
		hand_layout_manager()

#lays out the cards in the correct places in here
func hand_layout_manager():
	#finds the cards in the tree
	var cards = get_tree().get_nodes_in_group("cards")
	#creates a loop to sort the cards until there is no more to sort
	for card in cards:
		#if the card isnt selected it will...
		if not card.get("is_selected"):
			#get its slot index as its car_placement_order variable
			var slot_index = card.get("card_placement_order")
			# if slot index then comes back as null and slot index is less than slot_positons then...
			if slot_index != null and slot_index < slot_positions.size():
				# make one of them lerps to make a smooth movement from the point where it was dropped to the 
				#target_pos ya know
				var target_pos = slot_positions[slot_index]
				card.global_position = card.global_position.lerp(target_pos, 0.2)
	
	
	#ignore lol
	#for this one what am i needing to do. lets think for a second...
	#so we want our 5 cards that were numbered before to be placed at specific coordinates that we set as vector2s at the top.
	#which coordinate they are sent to is determend by the unique numbers set on each card so wii need to set the card variable to be set to the cards from before
	#so we use get_tree().get_nodes_in_group("cards") to find them this also gives us access to the internal variables of each card meaning we can read them
	#this is important because the numbers we assigned are assigned as the variable card_placement_order inside the card nodes
	#so now that we have access to those variables we read them and for specific numbers we assign one of those Vector2 coordinates so we can use
	#global_position = coordinate.lerp(target_pos, 0.2) to glide over to the spot they need to be in
	
	


#used to fill the inventory with updated card amounts
func inventory_logger():
	#gets the children so it can add them as values to the dictionary
	count_punch_cards()
	playerstate.player_deck["punch"] += punch_card_num
	get_parent().turn_first_trigger = true 

func count_punch_cards():
	punch_card_num = get_children().filter(func(c): return c.is_in_group("punch_card")).size()
	
func count_cursed_strike_cards():
	cursed_strike_card_num = get_children().filter(func(c): return c.is_in_group("punch_card")).size()
