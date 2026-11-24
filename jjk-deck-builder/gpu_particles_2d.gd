extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#starts making the particles
	emitting = true
	#deletes the thing after the thing is called
	finished.connect(_on_finished)


func _on_finished() -> void:
	queue_free()
