extends ProgressBar
const MAX_CURSED_ENERGY = 5
var current_cursed_energy = MAX_CURSED_ENERGY
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = MAX_CURSED_ENERGY
	value = current_cursed_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 

func update_cursed_energy_bar():
	value = current_cursed_energy
	

func cursed_energy_used(card_node):
	current_cursed_energy -= card_node.CURSED_ENERGY_COST
	update_cursed_energy_bar()
