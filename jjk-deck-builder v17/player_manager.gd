extends Node
var max_player_health = 70
var player_health = 70
var energy_level = 5
var max_energy_level = 5
var max_special_energy_level = 3
var special_energy_level = 3
var block = 0
var player_damage = 0
# Called when the node enters the scene tree for the first time.
var health_bar: ProgressBar
func _ready() -> void:
	health_bar = get_node_or_null("ProgressBar") as ProgressBar
	
	if health_bar != null:
		health_bar.max_value = max_player_health
		health_bar.value = player_health
	else:
		print("error: couldn't find progressbar node under da playa")
# Called when the node enters the scene tree for the first time.

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar = get_node_or_null("ProgressBar") as ProgressBar
	health_bar.value = player_health

func take_damage():
	print("player took damage! Incoming:", player_damage)
	
	#if the player has any stored block, absorb the damage first
	if block > 0:
		if block >= player_damage:
			block -= player_damage
			player_damage = 0
		else:
			player_damage -= block
			player_health = max(0, player_health)
	#apply remaining damage to player health
	player_health -= player_damage
	player_health = max(0, player_health)
	
	#checks for the player health
	if player_health <= 0:
		player_die()
	
func player_die():
	#player death animation here
	get_tree().change_scene_to_file("res://respawn_screen.tscn")
