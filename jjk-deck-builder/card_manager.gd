extends Node2D
var punch_card_num = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#gets the children so it can add them as values to the dictionary
			
			for punch in get_children():
				if punch.card_type == "punch" and get_parent().turn_start == true and get_parent().turn_first_trigger == false:
					playerstate.player_deck["punch"] += 1
					get_parent().turn_first_trigger = true
		
	
	


		
