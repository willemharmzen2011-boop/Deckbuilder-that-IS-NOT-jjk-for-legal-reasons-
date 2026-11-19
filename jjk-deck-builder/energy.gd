extends Control
@onready var energy_indicator: Label = $Label 
const MAX_ENERGY = 3
var current_energy = MAX_ENERGY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_energy_indicator()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_energy_indicator():
	energy_indicator.text = str(current_energy) + "/3"

func energy_used(card_node):
	#when a card is played it takes its energy cost variable and minusing it from the current energy
	current_energy -= card_node.energy_cost
	#updates the energy indicator
	update_energy_indicator()

func reset_energy():
	current_energy = MAX_ENERGY
	update_energy_indicator()
