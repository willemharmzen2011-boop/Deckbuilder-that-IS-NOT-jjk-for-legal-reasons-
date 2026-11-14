extends Node
#this is the players inventory dictionary
var player_deck = {
	"punch":15,
	"block":12,
	"cursed_strike":13
}

var card_scenes= {
	"punch": preload("res://punch.tscn"),
	"block": preload("res://block.tscn"),
	"cursed_strike": preload("res://cursed_strike (3).tscn")
}

var disgard_pile = {
	"punch":0,
	"block":0,
	"cursed_strike":0
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
