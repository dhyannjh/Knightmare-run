extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You Died")
	# Engine.time_scale = 0.5
	if body.has_method("die"):
		body.die()
