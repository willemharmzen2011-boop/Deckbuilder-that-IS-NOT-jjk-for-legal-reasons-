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
var draw_pile: Array[PackedScene] = []
var discard_pile: Array[PackedScene] = []
var current_hand: Array[Node] = []
	
	# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_pile_maker()
	deal_hand(5)
	
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

func new_turn_hand_clear():
	#kill them left over cards
	for card in current_hand:
		if is_instance_valid(card):
			card.queue_free()
	current_hand.clear()
	#get the new cards
	deal_hand(5)
	#just wait a lil so godot puts the new crds in the terr
	await get_tree().process_frame
	
	var cards = get_tree().get_nodes_in_group("cards")
	for i in range(cards.size()):
		var card = cards[i]
		if card:
			card.set("card_placement_order", i)
	
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
	cursed_strike_card_num = get_children().filter(func(c): return c.is_in_group("cursed_strike_card")).size()


func draw_pile_maker():
	draw_pile.clear()
	
	#grab dem numbys from playerstate
	for card_name in playerstate.player_deck:
		var amount = playerstate.player_deck[card_name]
		
		for i in range(amount):
			if playerstate.card_scenes.has(card_name):
				draw_pile.append(playerstate.card_scenes[card_name])
	draw_pile.shuffle()

func deal_hand(amount: int) -> void:
	for i in range(amount):
		if draw_pile.is_empty():
			draw_pile = discard_pile.duplicate()
			discard_pile.clear()
			draw_pile.shuffle()
		
		if draw_pile.is_empty():
			break
		
		var card_scene = draw_pile.pop_front()
		var card_instance = card_scene.instantiate()
		add_child(card_instance)
		
		current_hand.append(card_instance)

	
	#k so how do you deal cards lets think for a sec
	#since we already have a inventory in the playerstate autoload we just need to take those values and turn those into
	#cards on screen using var card_scene = preload("res://scenes/attack_card.tscn")
	#var card_instance = card_scene.instantiate() and add_child(card_instance) but to use them i need to make a random card generator
	#based on what cards are left in the inventory
	#so what i can do probably is get my inventory and preload all of the cards in a drawpile randomly by
	# creating a second dictionary with the file preloads and something to scramble the order of those cards prepareing them for
	#draw and if there is a missing card in the hand it should replace it with a card loaded in the deck
