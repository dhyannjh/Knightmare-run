extends Node2D

const SPEED = 30
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_animation: AnimationPlayer = $deathAnimation
@onready var kill_sound: AudioStreamPlayer2D = $killSound


var direction = 1

func _ready() -> void:
	death_animation.play("RESET")

func _process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated.flip_h = false
		
	position.x += direction * SPEED * delta


func _on_player_checker_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0:
		body.velocity.y = -150
		body.increase_score()
		kill_sound.play()
		animated.play("die")
		death_animation.play("deathAnimation")
	
	
