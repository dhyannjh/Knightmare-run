extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var quit_button: Button = $quitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_died.connect(on_player_died)
	visible = false
	quit_button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_player_died():
	visible = true
	quit_button.disabled = false
	modulate.a = 0
	animation_player.play("fade_in")
	

func _on_button_pressed() -> void:
	Global.respawn.emit()
	

func _unhandled_input(event):
	if visible and event.is_action_pressed("ui_accept"):
		Global.respawn.emit()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
