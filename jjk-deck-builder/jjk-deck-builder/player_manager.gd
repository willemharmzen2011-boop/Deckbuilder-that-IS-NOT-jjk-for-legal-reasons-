extends Node2D

@onready var value_label: Label = $ValueLabel
var max_player_health = 70
var player_health = 70 :
	set(value):
		player_health = value
		if health_bar:
			health_bar.value = player_health

var energy_level = 5
var max_energy_level = 5
var max_special_energy_level = 3
var special_energy_level = 3


var block = 0 :
	set(value):
		block = value
		if value_label:
			value_label.text = str(block)

var player_damage = 0
var health_bar: ProgressBar

func _ready() -> void:
	health_bar = get_node_or_null("ProgressBar") as ProgressBar
	
	if health_bar != null:
		health_bar.max_value = max_player_health
		health_bar.value = player_health
	else:
		print("error: couldn't find progressbar node under da playa")
		

	if value_label:
		value_label.text = str(block)


func receive_block():
	var overlapping_areas = $Area2D.get_overlapping_areas()
	
	if overlapping_areas.size() > 0:
		for area in overlapping_areas:
			var card = area.get_parent()
			
			if card and card.is_in_group("block"):
				var card_block_amount = card.block_value if "block" in card else 5
				block += card_block_amount
				print("Player gained block:", card_block_amount, "Total block:", block)
				card.queue_free()
				break

func take_damage():
	print("player took damage! Incoming:", player_damage)
	
	if block > 0:
		if block >= player_damage:
			block -= player_damage
			player_damage = 0
		else:
			player_damage -= block
			block = 0
			
	player_health -= player_damage
	player_health = max(0, player_health)
	player_damage = 0
	
	if player_health <= 0:
		player_die()
	  
func player_die():
	get_tree().change_scene_to_file("res://respawn_screen.tscn")
