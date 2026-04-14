extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var death_audio: AudioStreamPlayer2D = $SFX/deathAudio
@onready var jump_audio: AudioStreamPlayer2D = $SFX/jumpAudio

var is_dead = false

func _ready() -> void:
	
	position.x = Global.spawn_x
	position.y = Global.spawn_y
	
	Global.respawn.connect(on_respawn)
	
	is_dead = false

var mode = 1

func die():
	
	if is_dead:
		return
	
	print("dead")
	is_dead = true
	death_audio.play()
	Global.player_died.emit()
	animated.play("die")
	await animated.animation_finished
	Global.score = 0

func on_respawn():
	get_tree().reload_current_scene()

func flip_sprite(dir):
	if dir == -1:
		animated.flip_h = true
	if dir == 1:
		animated.flip_h = false

func increase_score():
	Global.add_score(1)
	print("Score: ", Global.score)

func _physics_process(delta: float) -> void:
	# print("running")
	if not is_dead:
		
		if Input.is_action_just_pressed("mode"):
			mode *= -1
			if mode == 1:
				get_tree().reload_current_scene()
			if mode == -1:
				collision_shape.queue_free()
				
		
		if mode == 1:
			# Add the gravity.
			if not is_on_floor():
				velocity += get_gravity() * delta

			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				jump_audio.play()
				velocity.y = JUMP_VELOCITY
			
			var direction := Input.get_axis("move_left", "move_right")
			
			flip_sprite(direction)
			
			if not is_dead:
				if is_on_floor():
					if direction == 0:
						animated.play("idle")
					elif direction == 1 or direction == -1:
						animated.play("run")
						
				else:
					animated.play("jump")
					
				

			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			
			move_and_slide()
			
		if mode == -1:
			
			var directiony := Input.get_axis("ui_up", "ui_down")
			if directiony:
				velocity.y = directiony * SPEED
			else:
				velocity.y = move_toward(velocity.x, 0, SPEED)
				
			var directionx := Input.get_axis("move_left", "move_right")
			if directionx:
				velocity.x = directionx * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
			move_and_slide()
		

	
