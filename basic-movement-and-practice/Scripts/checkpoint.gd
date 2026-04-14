extends Area2D

@onready var checkpoint_sound: AudioStreamPlayer2D = $checkpointSound

func _on_body_entered(body: Node2D) -> void:
	
	print("Checkpoint reached")
	checkpoint_sound.play()
	Global.spawn_x = position.x
	Global.spawn_y = position.y - 5
