extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")

func _on_body_entered(body: Node2D) -> void:
	print("coins + 1")
	body.increase_score()
	
	animation_player.play("pickup")
	#queue_free() #removes secene from game
