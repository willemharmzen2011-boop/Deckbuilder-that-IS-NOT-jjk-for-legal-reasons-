extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_manager.draw_pile.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_respawn_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
